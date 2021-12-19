stage_menu:
    LDA draw_states
    ORA #%00010001
    STA draw_states

    LDA level_index
    AND #%00001111
    CLC
    ADC #$10
    STA curs_y
    LDA level_index
    AND #%11110000
    LSR
    LSR
    LSR
    LSR
    CLC
    ADC #$10
    STA curs_x

    LDA #$21
    STA vram_adr_h
    LDA #$D2
    STA vram_adr_l
    LDA #>curs_x
    STA data_adr_h
    LDA #<curs_x
    STA data_adr_l
    LDX #$02
    JSR update_bg_data

    CLC
    LDA buttons_1
    ASL
    BCS @A
    ASL
    BCS @B
    ASL
    BCS @play
    ASL
    BCS @play
    ASL
    BCS @inc
    ASL
    BCS @dec
    ASL
    BCS @dec
    ASL
    BCS @inc
    JMP @end

    @A:
        LDX #(2*12)+3
        JSR play_note
        JMP @end
    @B:
        LDX #(2*12)+0
        JSR play_note
        JMP @end
    @inc:
        LDA buttons_1_timer
        BNE @end
        LDX level_index
        INX
        STX level_index
        CPX #LEVEL_MAX
        BCC @end
        LDX #$00
        STX level_index
        JMP @end
    @dec:
        LDA buttons_1_timer
        BNE @end
        LDX level_index
        DEX
        STX level_index
        CPX #LEVEL_MAX
        BCC @end
        LDX #LEVEL_MAX
        DEX
        STX level_index
        JMP @end
    @play:
        JSR change_to_level_load

    @end:
    RTS
