; X = laser index
; Y = laser position
laser_action_cross:
    PHA
    TYA
    PHA

    LDA laser_array_state, X
    AND #%00000010
    BEQ @vertical
    @horizontal:
    LDA #MTILE::CROSS_H
    STA level, Y
    JSR laser_action_move
    TXA
    TAY
    JSR laser_draw_cross_h
    JMP @end
    @vertical:
    LDA #MTILE::CROSS_V
    STA level, Y
    JSR laser_action_move
    TXA
    TAY
    JSR laser_draw_cross_v

    @end:
    PLA
    TAY
    PLA
    RTS


laser_action_cross_h:
laser_action_cross_v:
    PHA
    TYA
    PHA

    JSR laser_action_move
    TXA
    TAY
    JSR laser_draw_cross_on

    PLA
    TAY
    PLA
    RTS
