move_laser_mirror1:
    PHA

    TYA
    STA laser_array_pos, X   ; set new laser position

    LDA laser_array_state, X    ; get direction of the laser
    EOR #%00000011
    STA laser_array_state, X    ; set new direction of the laser

    @end:
    PLA
    RTS


move_laser_mirror2:
    PHA

    TYA
    STA laser_array_pos, X  ; set new laser position

    LDA laser_array_state, X    ; get direction of the laser
    EOR #%00000010
    STA laser_array_state, X    ; set new direction of the laser

    @end:
    PLA
    RTS


; Y = position where to reactivate lasers
move_laser_restart:
    PHA
    TXA
    PHA

    LDX #$00
    STX counter ; reset return value
    @loop:
        LDA laser_array_pos, X
        STA tmp
        CPY tmp
        BNE @loop_cmp

        LDA laser_array_state, X
        AND #%0001000
        BEQ @loop_cmp

        LDA laser_array_state, X
        AND #%11110011 ; desactivate restart + stop flags
        STA laser_array_state, X

        TXA
        PHA
        LDX counter
        INX
        STX counter
        PLA
        TAX

        @loop_cmp:
        INX
        CPX #LASER_MAX
        BNE @loop

    @end:
    PLA
    TAX
    PLA
    RTS
