stage_level_play:
    LDA buttons1
    AND #%00110000
    BEQ @start
        LDA drawStates  ; Disable PPU at the next Vblank
        AND #%11111100
        ORA #%01000000
        STA drawStates
        LDA #30        ; Disable for 30 frame
        STA PPUOffcounter

        LDA #STG::LEVEL_LOAD  ; load the main game
        STA gameStage


    @start:
    LDX level_FrameCounter      ; Check if frameCounter is zero
    CPX #$00                    ; if it is, then do a step
    BEQ @step

    DEX                         ; Decrease frameCounter
    STX level_FrameCounter      ; and wait for another frame
    JMP @end

    ; do a step
    @step:
        LDA level_MaxFrame          ; reset FrameCounter
        STA level_FrameCounter

        ; update all lasers
        LDX #$00        ; laser index
        @laser_loop:
            LDA laserArray_state, X ; check if the laser has stop
            AND #%00000100
            BNE @laser_loop_inc

            JSR get_next_laser_pos ; get the next position of the laser into A
            ; /!\ TODO: Check for out of map position and if it is then state = PLAY_ERROR and error = LASER_OUTOFMAP
            TAY                 ; and transfere it to Y
            LDA level, Y        ; get tile type at the next laser position

            CMP #MTILE::VOID
            BEQ @laser_action_move
            CMP #MTILE::GROUND
            BEQ @laser_action_ground
            CMP #MTILE::LASER_HOR
            BEQ @laser_action_laserhor
            CMP #MTILE::LASER_VER
            BEQ @laser_action_laserver
            CMP #MTILE::LASER_CROSS
            BEQ @laser_action_move
            CMP #MTILE::MIRROR_1
            BEQ @laser_action_mirror_1
            CMP #MTILE::MIRROR_2
            BEQ @laser_action_mirror_2
            CMP #MTILE::MIRROR_UL
            BEQ @laser_action_mirror_ul
            CMP #MTILE::MIRROR_UR
            BEQ @laser_action_mirror_ur
            CMP #MTILE::MIRROR_DL
            BEQ @laser_action_mirror_dl
            CMP #MTILE::MIRROR_DR
            BEQ @laser_action_mirror_dr
            CMP #MTILE::MIRROR_CROSS1
            BEQ @laser_action_mirror_cross1
            CMP #MTILE::MIRROR_CROSS2
            BEQ @laser_action_mirror_cross2
            CMP #MTILE::RECEIVE_UP
            BEQ @laser_action_receive_up
            CMP #MTILE::RECEIVE_DOWN
            BEQ @laser_action_receive_down
            CMP #MTILE::RECEIVE_LEFT
            BEQ @laser_action_receive_left
            CMP #MTILE::RECEIVE_RIGHT
            BEQ @laser_action_receive_right
            JMP @laser_action_stop

            ; increase the laser index and loop
            @laser_loop_inc:
            INX
            CPX level_LaserCount
            BNE @laser_loop
            JMP @laser_loop_end

            @laser_action_move:
                JSR laser_action_move
                JMP @laser_loop_inc
            @laser_action_ground:
                JSR laser_action_ground
                JMP @laser_loop_inc
            @laser_action_stop:
                JSR laser_action_stop
                JMP @laser_loop_inc
            @laser_action_laserhor:
                JSR laser_action_laserhor
                JMP @laser_loop_inc
            @laser_action_laserver:
                JSR laser_action_laserver
                JMP @laser_loop_inc
            @laser_action_mirror_1:
                JSR laser_action_mirror_1
                JMP @laser_loop_inc
            @laser_action_mirror_2:
                JSR laser_action_mirror_2
                JMP @laser_loop_inc
            @laser_action_mirror_ul:
                JSR laser_action_mirror_ul
                JMP @laser_loop_inc
            @laser_action_mirror_ur:
                JSR laser_action_mirror_ur
                JMP @laser_loop_inc
            @laser_action_mirror_dl:
                JSR laser_action_mirror_dl
                JMP @laser_loop_inc
            @laser_action_mirror_dr:
                JSR laser_action_mirror_dr
                JMP @laser_loop_inc
            @laser_action_mirror_cross1:
                JSR laser_action_mirror_cross1
                JMP @laser_loop_inc
            @laser_action_mirror_cross2:
                JSR laser_action_mirror_cross2
                JMP @laser_loop_inc
            @laser_action_receive_up:
                JSR laser_action_receive_up
                JMP @laser_loop_inc
            @laser_action_receive_down:
                JSR laser_action_receive_down
                JMP @laser_loop_inc
            @laser_action_receive_left:
                JSR laser_action_receive_left
                JMP @laser_loop_inc
            @laser_action_receive_right:
                JSR laser_action_receive_right
                JMP @laser_loop_inc

        @laser_loop_end:

        ; TODO antiLaser

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
