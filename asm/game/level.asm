; X = level
load_level:
    pushreg

    ; get level address
    LDA levelArrayHi, X
    STA dataAdr_h
    LDA levelArrayLo, X
    STA dataAdr_l

    LDX #$00 ; tileCount
    @loadTiles:
        ; Check if Special Mtile
        LDY #$00
        LDA (dataAdr), Y
        CMP #$FF
        BEQ @array

        @normal:
            STA level, X    ; store the tile into Level
            INX             ; Increase tileCount
            JSR inc_dataAdr ; increase dataAdr
            JMP @loadTilesEnd

        @array:
            ; get length
            JSR inc_dataAdr
            LDA (dataAdr), Y
            STA counter ; counter for the loop
            ; increase dataAdr to get the tile
            JSR inc_dataAdr
            @array_loop:
                LDY #$00        ; get the tile
                LDA (dataAdr), Y
                STA level, X    ; store the tile into Level

                INX             ; Increase tileCount
                LDY counter     ; decrease counter loop
                DEY
                STY counter
                CPY #$00
                BNE @array_loop

        @loadTilesEnd:
        CPX #$F0
        BNE @loadTiles


    LDY #$00
    @loadData:
        LDA (dataAdr), Y
        STA level, X
        INX

        INY
        CPY #$0A
        BNE @loadData

    pullreg
    RTS



level_place_lasers:
    pushreg

    LDY #$00
    @loop:
        LDA level, Y
        CMP #MTILE::EMIT_UP_ON
        BEQ @up
        CMP #MTILE::EMIT_DOWN_ON
        BEQ @down
        CMP #MTILE::EMIT_LEFT_ON
        BEQ @left
        CMP #MTILE::EMIT_RIGHT_ON
        BEQ @right
        JMP @loopEnd

        @up:
        JSR add_laser_up
        JMP @loopEnd
        @down:
        JSR add_laser_down
        JMP @loopEnd
        @left:
        JSR add_laser_left
        JMP @loopEnd
        @right:
        JSR add_laser_right
        JMP @loopEnd

        @loopEnd:
        INY
        CPY #$F0
        BNE @loop

    pullreg
    RTS
