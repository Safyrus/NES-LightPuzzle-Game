stage_play_level:
    LDA buttons1
    AND #%00110000
    BEQ @start
        LDA drawStates  ; Disable PPU at the next Vblank
        AND #%11111100
        ORA #%01000000
        STA drawStates
        LDA #30        ; Disable for 30 frame
        STA PPUOffcounter

        LDA #STG_PLAY_LOAD  ; load the main game
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

    @laser:
        LDX #$00                ; laser index to update
        @laserLoop:
            CPX level_LaserCount
            BEQ @laserEnd

            LDA laserArray_state, X
            AND #%00000100
            BNE @laserLoop_end

            JSR getNextLaserPos ; get the next position of the laser into A
;/!\        ; TODO: Check for out of map position and if it is then state = PLAY_ERROR and error = LASER_OUTOFMAP
            TAY                 ; and transfere it to Y
            LDA level, Y        ; get tile type at the next laser position

            CMP #MTILE::VOID
            BEQ @laserAction_move
            CMP #MTILE::GROUND
            BEQ @laserAction_ground
            CMP #MTILE::LASER_HOR
            BEQ @laserAction_laserhor
            CMP #MTILE::LASER_VER
            BEQ @laserAction_laserver
            CMP #MTILE::LASER_CROSS
            BEQ @laserAction_move
            CMP #MTILE::MIRROR_1
            BEQ @laserAction_mirror_1
            CMP #MTILE::MIRROR_2
            BEQ @laserAction_mirror_2
            CMP #MTILE::MIRROR_UL
            BEQ @laserAction_mirror_ul
            CMP #MTILE::MIRROR_UR
            BEQ @laserAction_mirror_ur
            CMP #MTILE::MIRROR_DL
            BEQ @laserAction_mirror_dl
            CMP #MTILE::MIRROR_DR
            BEQ @laserAction_mirror_dr
            CMP #MTILE::MIRROR_CROSS1
            BEQ @laserAction_mirror_cross1
            CMP #MTILE::MIRROR_CROSS2
            BEQ @laserAction_mirror_cross2
            JMP @laserAction_stop

            @laserLoop_end:
            INX
            JMP @laserLoop  ; loop
        JMP @laserEnd

    @laserEnd:
    JMP @end

        @laserAction_move:
            JSR laserAction_move
            JMP @laserLoop_end
        @laserAction_ground:
            JSR laserAction_ground
            JMP @laserLoop_end
        @laserAction_stop:
            JSR laserAction_stop
            JMP @laserLoop_end
        @laserAction_laserhor:
            JSR laserAction_laserhor
            JMP @laserLoop_end
        @laserAction_laserver:
            JSR laserAction_laserver
            JMP @laserLoop_end
        @laserAction_mirror_1:
            JSR laserAction_mirror_1
            JMP @laserLoop_end
        @laserAction_mirror_2:
            JSR laserAction_mirror_2
            JMP @laserLoop_end
        @laserAction_mirror_ul:
            JSR laserAction_mirror_ul
            JMP @laserLoop_end
        @laserAction_mirror_ur:
            JSR laserAction_mirror_ur
            JMP @laserLoop_end
        @laserAction_mirror_dl:
            JSR laserAction_mirror_dl
            JMP @laserLoop_end
        @laserAction_mirror_dr:
            JSR laserAction_mirror_dr
            JMP @laserLoop_end
        @laserAction_mirror_cross1:
            JSR laserAction_mirror_cross1
            JMP @laserLoop_end
        @laserAction_mirror_cross2:
            JSR laserAction_mirror_cross2
            JMP @laserLoop_end

    ; TODO antiLaser

    ; If all Laser and anti Laser stop
        ; state = PLAY_ERROR
        ; error = LASER_STOP

    @end:
    RTS     ; Return
