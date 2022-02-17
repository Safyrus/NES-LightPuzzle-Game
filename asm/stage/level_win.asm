stage_level_win:
    LDA buttons_1
    AND #%00110000
    BNE @load
    LDA buttons_1
    AND #%11000000
    BNE @menu
    JMP @end
    @load:
        JSR clear_level_edit
        LDX level_index
        INX
        CPX #LEVEL_MAX
        BEQ @menu
        STX level_index
        JSR change_to_level_load
        JMP @end
    @menu:
        JSR change_to_menu_load
    @end:
    RTS
