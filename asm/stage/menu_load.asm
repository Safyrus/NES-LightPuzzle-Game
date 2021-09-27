stage_menu_load:
    JSR draw_menu   ; Draw the menu

    LDA #STG::MENU   ; Change gameStage to Menu
    STA gameStage

    LDA #%00001010  ; Activate background and the left 8 pixels
    STA PPUMASK

    RTS
