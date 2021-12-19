; add a string of data to update the background
; param: X= length
; vars:  data_adr, vram_adr
update_bg_data:
    pushreg

    TXA
    CMP #$00
    BEQ @end

    LDY bg_data_index
    STA bg_draw_data, Y

    TAX

    INY
    LDA vram_adr_h
    STA bg_draw_data, Y
    INY
    LDA vram_adr_l
    STA bg_draw_data, Y

    STY bg_data_index
    LDA #$00
    STA counter
    @data:
        LDY counter
        LDA (data_adr), Y
        INY
        STY counter

        LDY bg_data_index
        INY
        STA bg_draw_data, Y
        STY bg_data_index

        DEX
        CPX #$00
        BNE @data
        LDY bg_data_index
    INY
    STY bg_data_index
    @end:
    pullreg
    RTS


; param: X=index
; vars:  vram_adr
update_bg_metatile:
    PHA
    TXA
    PHA

    LDA metatile_array_hi, X
    STA data_adr_h
    LDA metatile_array_lo, X
    STA data_adr_l

    TXA
    LDX #$02
    JSR update_bg_data
    TAX

    LDX #$02
    JSR add_data_adr
    LDA vram_adr_l
    CLC
    ADC #$20
    STA vram_adr_l
    BCC @next
    LDA vram_adr_h
    ADC #$00
    STA vram_adr_h
    @next:
    LDX #$02
    JSR update_bg_data

    PLA
    TAX
    PLA
    RTS


; Y = index
update_ui_count:
    pushreg

    LDA level_selectable_object_type, Y
    LDX #$00
    @loop:
        CMP select_tiles, X
        BEQ @loop_end

        INX
        CPX #$10
        BNE @loop
    @loop_end:

    LDA #$24
    STA vram_adr_h
    TXA
    ASL
    ASL
    CLC
    ADC #$81
    CMP #$96
    BCC @next
    SEC
    SBC #$38
    CMP #$76
    BCC @next
    SEC
    SBC #$38
    SEC

    @next:
    STA vram_adr_l

    LDA level_selectable_object_count, Y
    ORA #%00010000
    STA tmp

    LDA #>tmp
    STA data_adr_h
    LDA #<tmp
    STA data_adr_l

    LDX #$01
    JSR update_bg_data

    pullreg
    RTS