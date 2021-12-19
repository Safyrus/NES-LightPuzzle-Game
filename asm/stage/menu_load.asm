stage_menu_load:
    LDX #$00
    LDY #$00
    rst_pal:
        JSR set_palette
        INY
        INX
        CPY #$08
        BNE rst_pal
    rst_pal_end:
    JSR load_palettes_ppu   ; load palettes

    JSR reset_nametable_attributes

    JSR draw_menu   ; Draw the menu

    LDA #$01
    STA spr0_x
    LDA #$2D
    STA spr0_y
    LDA #SPR::ZERO
    STA spr0
    LDA #%00100000
    STA spr0_atr

    LDA #%00001010  ; Activate background and the left 8 pixels
    STA PPUMASK

    LDA #STG::MENU   ; Change game_stage to Menu
    STA game_stage

    RTS
