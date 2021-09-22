; X = Coord
getMTileNametableAdr:
    PHA

    TXA
    LSR
    LSR
    LSR
    LSR
    LSR
    LSR
    CLC
    ADC #$20
    STA dataAdr_h
    TXA
    ASL
    AND #%00011111
    STA dataAdr_l
    TXA
    ASL
    ASL
    AND #%11000000
    CLC
    ADC dataAdr_l
    STA dataAdr_l

    PLA
    RTS


; add 1 to dataAdr
incDataAdr:
    PHA
    TXA
    PHA

    LDX dataAdr_l
    INX
    STX dataAdr_l
    CPX #$00
    BNE @end
    LDX dataAdr_h
    INX
    STX dataAdr_h

    @end:
    PLA
    TAX
    PLA
    RTS

; X = number to add
addDataAdr:
    PHA
    TXA
    PHA

    LDA dataAdr_l
    CLC
    STX tmp
    ADC tmp
    STA dataAdr_l
    BCC @end
    LDX dataAdr_h
    INX
    STX dataAdr_h

    @end:
    PLA
    TAX
    PLA
    RTS
