; X = level
loadLevel:
    PHA
    TXA
    PHA
    TYA
    PHA

    ; get level address
    LDA levelArrayHi, X
    STA dataAdr_h
    LDA levelArrayLo, X
    STA dataAdr_l

    LDX #$00 ; tileCount
    loadLevel_loop:
        ; Check if Special Mtile
        LDY #$00
        LDA (dataAdr), Y
        CMP #$FF
        BEQ loadLevel_array

        loadLevel_normal:
            STA level, X    ; store the tile into Level
            INX             ; Increase tileCount
            JSR incDataAdr  ; increase dataAdr
            JMP loadLevel_loopEnd

        loadLevel_array:
            ; get length
            JSR incDataAdr
            LDA (dataAdr), Y
            STA counter ; counter for the loop
            ; increase dataAdr to get the tile
            JSR incDataAdr
            loadLevel_array_loop:
                LDY #$00        ; get the tile
                LDA (dataAdr), Y
                STA level, X    ; store the tile into Level

                INX             ; Increase tileCount
                LDY counter     ; decrease counter loop
                DEY
                STY counter
                CPY #$00
                BNE loadLevel_array_loop

        loadLevel_loopEnd:
        CPX #$F0
        BNE loadLevel_loop

    PLA
    TAY
    PLA
    TAX
    PLA
    RTS
