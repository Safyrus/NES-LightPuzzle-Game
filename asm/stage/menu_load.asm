stage_menu_load:
    JSR drawMenu   ; Draw the menu

    LDX #$00
    LDY #$01
    JSR drawMetaTile
    LDX #$01
    LDY #$01
    JSR drawMetaTile
    LDX #$01
    LDY #$00
    JSR drawMetaTile

    LDA #STG_MENU   ; Change gameStage to Menu
    STA gameStage

    LDA #%00001010  ; Activate background and the left 8 pixels
    STA PPUMASK

    RTS
