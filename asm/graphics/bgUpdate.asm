; add a string of data to update the background
; param: X= length
; vars:  dataAdr, vramAdr
updateBgData:
    PHA
    TXA
    PHA
    TYA
    PHA

    TXA
    CMP #$00
    BEQ updateBgData_end

    LDY bgDataIndex
    STA bgDrawData, Y

    TAX

    INY
    LDA vramAdr_h
    STA bgDrawData, Y
    INY
    LDA vramAdr_l
    STA bgDrawData, Y

    STY bgDataIndex
    LDA #$00
    STA counter
    updateBgData_data:
        LDY counter
        LDA (dataAdr), Y
        INY
        STY counter

        LDY bgDataIndex
        INY
        STA bgDrawData, Y
        STY bgDataIndex

        DEX
        CPX #$00
        BNE updateBgData_data
        LDY bgDataIndex
    INY
    STY bgDataIndex
    updateBgData_end:
    PLA
    TAY
    PLA
    TAX
    PLA
    RTS


; param: X=index
; vars:  vramAdr
updateBgMTile:
    PHA
    TXA
    PHA

    LDA metaTileArrayHi, X
    STA dataAdr_h
    LDA metaTileArrayLo, X
    STA dataAdr_l

    TXA
    LDX #$02
    JSR updateBgData
    TAX

    LDX #$02
    JSR addDataAdr
    LDA vramAdr_l
    CLC
    ADC #$20
    STA vramAdr_l
    BCC @next
    LDA vramAdr_h
    ADC #$00
    STA vramAdr_h
    @next:
    LDX #$02
    JSR updateBgData

    PLA
    TAX
    PLA
    RTS
