stage_level_play:
    LDA buttons1
    AND #%00100000
    BEQ @start
        LDA buttons1Timer   ;check if buttons are unlock
        BNE @start
        
        JSR change_to_level_load

    @start:
    LDX level_FrameCounter      ; Check if frameCounter is zero
    CPX #$00                    ; if it is, then do a step
    BEQ @step

    DEX                         ; Decrease frameCounter
    STX level_FrameCounter      ; and wait for another frame
    JMP @end

    ; do a step
    @step:
        ; update all lasers
        LDX level_LaserDoneCounter  ; laser index
        @laser_loop:
            LDA laserArray_state, X ; check if the laser has stop
            AND #%00000100
            BEQ @laser_find_action
            JMP @laser_loop_inc

            @laser_find_action:
            JSR get_next_laser_pos ; get the next position of the laser into A
            ; /!\ TODO: Check for out of map position and if it is then state = PLAY_ERROR and error = LASER_OUTOFMAP
            TAY                 ; and transfere it to Y
            LDA level, Y        ; get tile type at the next laser position

            CMP #MTILE::VOID
            .byte $D0, $06 ; BNE @next
                JSR laser_action_move
                JMP @laser_loop_inc
            CMP #MTILE::GROUND
            .byte $D0, $06 ; BNE @next
                JSR laser_action_ground
                JMP @laser_loop_inc
            CMP #MTILE::LASER_HOR
            .byte $D0, $06 ; BNE @next
                JSR laser_action_laserhor
                JMP @laser_loop_inc
            CMP #MTILE::LASER_VER
            .byte $D0, $06 ; BNE @next
                JSR laser_action_laserver
                JMP @laser_loop_inc
            CMP #MTILE::LASER_CROSS
            .byte $D0, $06 ; BNE @next
                JSR laser_action_move
                JMP @laser_loop_inc
            CMP #MTILE::MIRROR_1
            .byte $D0, $06 ; BNE @next
                JSR laser_action_mirror_1
                JMP @laser_loop_inc
            CMP #MTILE::MIRROR_2
            .byte $D0, $06 ; BNE @next
                JSR laser_action_mirror_2
                JMP @laser_loop_inc
            CMP #MTILE::MIRROR_UL
            .byte $D0, $06 ; BNE @next
                JSR laser_action_mirror_ul
                JMP @laser_loop_inc
            CMP #MTILE::MIRROR_UR
            .byte $D0, $06 ; BNE @next
                JSR laser_action_mirror_ur
                JMP @laser_loop_inc
            CMP #MTILE::MIRROR_DL
            .byte $D0, $06 ; BNE @next
                JSR laser_action_mirror_dl
                JMP @laser_loop_inc
            CMP #MTILE::MIRROR_DR
            .byte $D0, $06 ; BNE @next
                JSR laser_action_mirror_dr
                JMP @laser_loop_inc
            CMP #MTILE::MIRROR_CROSS1
            .byte $D0, $06 ; BNE @next
                JSR laser_action_mirror_cross1
                JMP @laser_loop_inc
            CMP #MTILE::MIRROR_CROSS2
            .byte $D0, $06 ; BNE @next
                JSR laser_action_mirror_cross2
                JMP @laser_loop_inc
            CMP #MTILE::RECEIVE_UP
            .byte $D0, $06 ; BNE @next
                JSR laser_action_receive_up
                JMP @laser_loop_inc
            CMP #MTILE::RECEIVE_DOWN
            .byte $D0, $06 ; BNE @next
                JSR laser_action_receive_down
                JMP @laser_loop_inc
            CMP #MTILE::RECEIVE_LEFT
            .byte $D0, $06 ; BNE @next
                JSR laser_action_receive_left
                JMP @laser_loop_inc
            CMP #MTILE::RECEIVE_RIGHT
            .byte $D0, $06 ; BNE @next
                JSR laser_action_receive_right
                JMP @laser_loop_inc
            CMP #MTILE::MIRRORC_UL
            .byte $D0, $06 ; BNE @next
                JSR laser_action_mirror_corner_ul
                JMP @laser_loop_inc
            CMP #MTILE::MIRRORC_UR
            .byte $D0, $06 ; BNE @next
                JSR laser_action_mirror_corner_ur
                JMP @laser_loop_inc
            CMP #MTILE::MIRRORC_DL
            .byte $D0, $06 ; BNE @next
                JSR laser_action_mirror_corner_dl
                JMP @laser_loop_inc
            CMP #MTILE::MIRRORC_DR
            .byte $D0, $06 ; BNE @next
                JSR laser_action_mirror_corner_dr
                JMP @laser_loop_inc
            @laser_action_stop:
                JSR laser_action_stop
                JMP @laser_loop_inc

            ; increase the laser index and loop
            @laser_loop_inc:
            ; increase laser done counter
            LDY level_LaserDoneCounter
            INY
            STY level_LaserDoneCounter

            ; check if all laser had been updated
            CPY level_LaserCount
            BEQ @laser_loop_end

            ; else check if we don't exeed the max laser per frame
            INX
            TXA
            AND #MAXLASERPERFRAME
            BEQ @laser_loop_end_maxframe
            JMP @laser_loop

        @laser_loop_end:
        LDA #$00                    ; reset laser done counter
        STA level_LaserDoneCounter
        LDA level_MaxFrame          ; reset FrameCounter
        STA level_FrameCounter
        JMP @step_done
        @laser_loop_end_maxframe:
        JMP @end

        ; TODO antiLaser

    @step_done:

    ; check if all lasers has stop
    LDX #$00
    @check_laser_stop_loop:
        LDA laserArray_state, X
        AND #%00000100
        BEQ @end

        INX
        CPX level_LaserCount
        BNE @check_laser_stop_loop
    
    @laser_stop:
        LDY #$00
        @laser_stop_loop:
            LDA level, Y
            CMP #MTILE::RECEIVE_UP
            BEQ @stage_loose
            CMP #MTILE::RECEIVE_DOWN
            BEQ @stage_loose
            CMP #MTILE::RECEIVE_LEFT
            BEQ @stage_loose
            CMP #MTILE::RECEIVE_RIGHT
            BEQ @stage_loose

            INY
            CPY #$F0
            BNE @laser_stop_loop
        JMP @stage_win

        @stage_loose:
            LDA #$21
            STA vramAdr_h
            LDA #$68
            STA vramAdr_l

            LDA #>txt_loose
            STA dataAdr_h
            LDA #<txt_loose
            STA dataAdr_l

            LDX #$05
            JSR update_bg_data

            LDA #STG::LEVEL_LOOSE  ; go to the loose stage
            STA gameStage

            JMP @end
        
        @stage_win:
            LDA #$21
            STA vramAdr_h
            LDA #$68
            STA vramAdr_l

            LDA #>txt_win
            STA dataAdr_h
            LDA #<txt_win
            STA dataAdr_l

            LDX #$03
            JSR update_bg_data

            LDA #STG::LEVEL_WIN  ; go to the win stage
            STA gameStage

    @end:
    RTS     ; Return
