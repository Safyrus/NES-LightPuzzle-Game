; X = Coord
get_metatile_nametable_adr:
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
    STA data_adr_h
    TXA
    ASL
    AND #%00011111
    STA data_adr_l
    TXA
    ASL
    ASL
    AND #%11000000
    CLC
    ADC data_adr_l
    STA data_adr_l

    PLA
    RTS


; add 1 to data_adr
inc_data_adr:
    PHA
    TXA
    PHA

    LDX data_adr_l
    INX
    STX data_adr_l
    CPX #$00
    BNE @end
    LDX data_adr_h
    INX
    STX data_adr_h

    @end:
    PLA
    TAX
    PLA
    RTS

; X = number to add
add_data_adr:
    PHA
    TXA
    PHA

    LDA data_adr_l
    CLC
    STX tmp
    ADC tmp
    STA data_adr_l
    BCC @end
    LDX data_adr_h
    INX
    STX data_adr_h

    @end:
    PLA
    TAX
    PLA
    RTS


change_to_level_load:
    PHA

    LDA draw_states  ; Disable PPU at the next Vblank
    AND #%11101100
    ORA #%01001000
    STA draw_states
    LDA #10        ; Disable for 10 frame
    STA ppu_off_counter

    LDA #STG::LEVEL_LOAD  ; load the main game
    STA game_stage

    PLA
    RTS

;
change_to_menu_load:
    PHA

    LDA draw_states  ; Disable PPU at the next Vblank
    AND #%11101000
    ORA #%01001000
    STA draw_states
    LDA #10        ; Disable for 10 frame
    STA ppu_off_counter

    LDA #STG::MENU_LOAD ; set the stage to MenuLoad
    STA game_stage

    PLA
    RTS


wait_spr0:
    PHA

    @wait:
    LDA PPUSTATUS
    AND #%01000000
    BEQ @wait

    PLA
    RTS


wait_ui:
    PHA
    TAX
    PHA

    BIT PPUSTATUS   ; reset latch
    LDA #$FF        ; set scrolling position to 255,0
    STA PPUSCROLL
    LDA #$00
    STA PPUSCROLL

    ; wait for the current frame to end
    ; to reset sprite zero hit flag
    LDX #$00
    @wait:
        INX
        CPX #$30
        BNE @wait

    JSR wait_spr0

    BIT PPUSTATUS   ; reset latch
    LDA #$00        ; set scrolling position to 0,0
    STA PPUSCROLL
    LDA #$00
    STA PPUSCROLL

    PLA
    TAX
    PLA
    RTS