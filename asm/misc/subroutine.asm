; X = Coord
get_metaTile_nametable_adr:
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
inc_dataAdr:
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
add_dataAdr:
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


change_to_level_load:
    PHA

    LDA drawStates  ; Disable PPU at the next Vblank
    AND #%11101100
    ORA #%01001000
    STA drawStates
    LDA #10        ; Disable for 10 frame
    STA PPUOffcounter

    LDA #STG::LEVEL_LOAD  ; load the main game
    STA gameStage

    PLA
    RTS
