stage_menu_load:
    JSR drawMenu   ; Draw the menu

    LDA #STG_MENU   ; Change gameStage to Menu
    STA gameStage

    LDA #%00001010  ; Activate background and the left 8 pixels
    STA PPUMASK

    RTS
