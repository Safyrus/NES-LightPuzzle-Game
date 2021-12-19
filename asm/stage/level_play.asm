stage_level_play:
    LDA buttons_1
    AND #%00100000
    BEQ @start
        LDA buttons_1_timer   ;check if buttons are unlock
        BNE @start
        
        JSR change_to_level_load

    @start:
    LDX level_frame_counter      ; Check if frame_counter is zero
    CPX #$00                    ; if it is, then do a step
    BEQ @step

    DEX                         ; Decrease frame_counter
    STX level_frame_counter      ; and wait for another frame
    JMP @end

    ; do a step
    @step:
        ; update all lasers
        LDX level_laser_done_counter  ; laser index
        @laser_loop:
            LDA laser_array_state, X ; check if the laser has stop
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
            CMP #MTILE::SPLITTER_H
            .byte $D0, $06 ; BNE @next
                JSR laser_action_splitter_h
                JMP @laser_loop_inc
            CMP #MTILE::SPLITTER_V
            .byte $D0, $06 ; BNE @next
                JSR laser_action_splitter_v
                JMP @laser_loop_inc
            CMP #MTILE::MERGER_H
            .byte $D0, $06 ; BNE @next
                JSR laser_action_merger_h
                JMP @laser_loop_inc
            CMP #MTILE::MERGER_V
            .byte $D0, $06 ; BNE @next
                JSR laser_action_merger_v
                JMP @laser_loop_inc
            CMP #MTILE::MERGER_H_T
            .byte $D0, $06 ; BNE @next
                JSR laser_action_merger_ht
                JMP @laser_loop_inc
            CMP #MTILE::MERGER_H_B
            .byte $D0, $06 ; BNE @next
                JSR laser_action_merger_hb
                JMP @laser_loop_inc
            CMP #MTILE::MERGER_V_L
            .byte $D0, $06 ; BNE @next
                JSR laser_action_merger_vl
                JMP @laser_loop_inc
            CMP #MTILE::MERGER_V_R
            .byte $D0, $06 ; BNE @next
                JSR laser_action_merger_vr
                JMP @laser_loop_inc
            CMP #MTILE::DOOR_H
            .byte $D0, $06 ; BNE @next
                JSR laser_action_door_h
                JMP @laser_loop_inc
            CMP #MTILE::DOOR_V
            .byte $D0, $06 ; BNE @next
                JSR laser_action_door_v
                JMP @laser_loop_inc
            CMP #MTILE::DOOR_H_ON
            .byte $D0, $06 ; BNE @next
                JSR laser_action_door_h_on
                JMP @laser_loop_inc
            CMP #MTILE::DOOR_V_ON
            .byte $D0, $06 ; BNE @next
                JSR laser_action_door_v_on
                JMP @laser_loop_inc
            CMP #MTILE::GLASS
            .byte $D0, $06 ; BNE @next
                JSR laser_action_glass
                JMP @laser_loop_inc
            CMP #MTILE::CROSS
            .byte $D0, $06 ; BNE @next
                JSR laser_action_cross
                JMP @laser_loop_inc
            CMP #MTILE::CROSS_H
            .byte $D0, $06 ; BNE @next
                JSR laser_action_cross_h
                JMP @laser_loop_inc
            CMP #MTILE::CROSS_V
            .byte $D0, $06 ; BNE @next
                JSR laser_action_cross_v
                JMP @laser_loop_inc
            @laser_action_stop:
                JSR laser_action_stop
                JMP @laser_loop_inc

            ; increase the laser index and loop
            @laser_loop_inc:
            ; increase laser done counter
            LDY level_laser_done_counter
            INY
            STY level_laser_done_counter

            ; check if all laser had been updated
            CPY level_laser_count
            BEQ @laser_loop_end

            ; else check if we don't exeed the max laser per frame
            INX
            TXA
            AND #MAXLASERPERFRAME
            BEQ @laser_loop_end_maxframe
            JMP @laser_loop

        @laser_loop_end:
        LDA #$00                    ; reset laser done counter
        STA level_laser_done_counter
        LDA level_max_frame          ; reset level_max_frame
        STA level_frame_counter
        JMP @step_done
        @laser_loop_end_maxframe:
        JMP @end

    @step_done:

    ; check if all lasers has stop
    LDX #$00
    @check_laser_stop_loop:
        LDA laser_array_state, X
        AND #%00000100
        BEQ @end

        INX
        CPX level_laser_count
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
            CMP #MTILE::CROSS_H
            BEQ @stage_loose
            CMP #MTILE::CROSS_V
            BEQ @stage_loose
            CMP #MTILE::CROSS_ON
            BEQ @stage_loose

            INY
            CPY #$F0
            BNE @laser_stop_loop
        JMP @stage_win

        @stage_loose:
            LDA #$21
            STA vram_adr_h
            LDA #$68
            STA vram_adr_l

            LDA #>txt_loose
            STA data_adr_h
            LDA #<txt_loose
            STA data_adr_l

            LDX #$05
            JSR update_bg_data

            LDA #STG::LEVEL_LOOSE  ; go to the loose stage
            STA game_stage

            JMP @end
        
        @stage_win:
            LDA #$21
            STA vram_adr_h
            LDA #$68
            STA vram_adr_l

            LDA #>txt_win
            STA data_adr_h
            LDA #<txt_win
            STA data_adr_l

            LDX #$03
            JSR update_bg_data

            LDA #STG::LEVEL_WIN  ; go to the win stage
            STA game_stage

    @end:
    RTS     ; Return
