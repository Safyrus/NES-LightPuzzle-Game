; X = level
loadLevel:
    pushreg

    ; get level address
    LDA levelArrayHi, X
    STA dataAdr_h
    LDA levelArrayLo, X
    STA dataAdr_l

    LDX #$00 ; tileCount
    @loop:
        ; Check if Special Mtile
        LDY #$00
        LDA (dataAdr), Y
        CMP #$FF
        BEQ @array

        @normal:
            STA level, X    ; store the tile into Level
            INX             ; Increase tileCount
            JSR incDataAdr  ; increase dataAdr
            JMP @loopEnd

        @array:
            ; get length
            JSR incDataAdr
            LDA (dataAdr), Y
            STA counter ; counter for the loop
            ; increase dataAdr to get the tile
            JSR incDataAdr
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

        @loopEnd:
        CPX #$F0
        BNE @loop

    pullreg
    RTS
