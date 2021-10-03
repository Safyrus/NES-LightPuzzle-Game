stage_level_loose:
    LDA buttons1
    AND #%00110000
    BEQ @end
        JSR change_to_level_load
    @end:
    RTS
