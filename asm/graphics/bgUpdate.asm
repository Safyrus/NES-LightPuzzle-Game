; add a string of data to update the background
; param: X= length
; vars:  dataAdr, vramAdr
update_bg_data:
    pushreg

    TXA
    CMP #$00
    BEQ @end

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
    @data:
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
        BNE @data
        LDY bgDataIndex
    INY
    STY bgDataIndex
    @end:
    pullreg
    RTS


; param: X=index
; vars:  vramAdr
update_bg_metaTile:
    PHA
    TXA
    PHA

    LDA metaTileArrayHi, X
    STA dataAdr_h
    LDA metaTileArrayLo, X
    STA dataAdr_l

    TXA
    LDX #$02
    JSR update_bg_data
    TAX

    LDX #$02
    JSR add_dataAdr
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
    JSR update_bg_data

    PLA
    TAX
    PLA
    RTS
