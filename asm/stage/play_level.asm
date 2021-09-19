stage_play_level:
    ;LDA #$20
    ;STA vramAdr_h
    ;LDA #$00
    ;LDX level_FrameCounter
    ;TXA
    ;ASL
    ;STA vramAdr_l
    ;LDX #MTILE::LASER_CROSS
    ;JSR updateBgMTile

    LDX level_FrameCounter      ; Check if frameCounter is zero
    CPX #$00                    ; if it is, then do a step
    BEQ stage_play_level_step

    DEX                         ; Decrease frameCounter
    STX level_FrameCounter      ; and wait for another
    JMP stage_play_level_end    ; frame

    ; do a step
    stage_play_level_step:
    LDA level_MaxFrame      ; reset FrameCounter
    STA level_FrameCounter

    stage_play_level_laser:
        LDX #$00                ; laser index to update
        stage_play_level_laserLoop:
            CPX level_LaserCount
            BEQ stage_play_level_laserEnd

            JSR getNextLaserPos ; get the next position of the laser into A
;/!\        ; TODO: Check for out of map position and if it is then state = PLAY_ERROR and error = LASER_OUTOFMAP
            TAY                 ; and transfere it to Y
            LDA level, Y        ; get tile type at the next laser position

            CMP #MTILE::VOID
            BEQ stage_play_level_laserAction_move
            CMP #MTILE::GROUND
            BEQ stage_play_level_laserAction_move
            JMP stage_play_level_laserAction_stop

            INX
            JMP stage_play_level_laserLoop  ; loop
        JMP stage_play_level_laserEnd

        stage_play_level_laserAction_move:
            JSR laserAction_move
            JMP stage_play_level_laserEnd
        stage_play_level_laserAction_stop:
            JSR laserAction_stop
            JMP stage_play_level_laserEnd

    stage_play_level_laserEnd:

    ; TODO antiLaser

    ; If all Laser and anti Laser stop
        ; state = PLAY_ERROR
        ; error = LASER_STOP

    stage_play_level_end:
    RTS     ; Return
    RTS     ; Return
    RTS     ; Return
    RTS     ; Return
    RTS     ; Return
