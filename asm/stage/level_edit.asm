stage_level_edit:
    LDA draw_states
    AND #%11110111  ; disable palette update
    ORA #%00010111  ; render background and sprites +
    STA draw_states ; attributes and scroll update

    LDA #%00011110  ; Activate sprites and background and the left 8 pixels
    STA PPUMASK

    JSR wait_ui

    JSR move_cursor
    JSR change_at_cursor
    JSR place_at_cursor
    JSR remove_at_cursor
    JSR update_cursor_sprite

    LDA buttons_1
    AND #%00100000
    BEQ @btn_select_end

        LDA buttons_1_timer   ; check if buttons are unlock
        BNE @btn_select_end

        LDX selected
        INX
        CPX max_selected
        BCC @selected
        LDX #$00
        @selected:
        STX selected
    @btn_select_end:

    @btn_start:
    LDA buttons_1
    AND #%00010000
    BEQ @end

        JSR level_place_edit
        JSR level_place_lasers

        LDA draw_states
        AND #%11111101
        STA draw_states

        LDA #%00001010  ; Activate background and the left 8 pixels
        STA PPUMASK

        LDA #STG::LEVEL_PLAY   ; Change game_stage to LevelPlay
        STA game_stage

    @end:

    RTS
