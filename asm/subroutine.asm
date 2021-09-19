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


;
incDataAdr:
    PHA
    TXA
    PHA

    LDX dataAdr_l
    INX
    STX dataAdr_l
    BCC incDataAdr_end
    LDX dataAdr_h
    INX
    STX dataAdr_h

    incDataAdr_end:
    PLA
    TAX
    PLA
    RTS

; X = to Add
addDataAdr:
    PHA
    TXA
    PHA

    LDA dataAdr_l
    CLC
    STX tmp
    ADC tmp
    STA dataAdr_l
    BCC addDataAdr_end
    LDX dataAdr_h
    INX
    STX dataAdr_h

    addDataAdr_end:
    PLA
    TAX
    PLA
    RTS
