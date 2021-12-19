stage_level_loose:
    LDA buttons_1
    AND #%00110000
    BNE @load
    LDA buttons_1
    AND #%11000000
    BNE @menu
    JMP @end
    @load:
        JSR change_to_level_load
        JMP @end
    @menu:
        JSR change_to_menu_load
    @end:
    RTS
