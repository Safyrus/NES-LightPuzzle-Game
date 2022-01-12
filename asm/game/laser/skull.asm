; X = laser index
; Y = laser position
laser_action_skull:
    PHA
    TYA
    PHA

    LDA laser_array_state, X
    AND #%00000010
    BEQ @vertical
    @horizontal:
    LDA #MTILE::SKULL_H
    STA level, Y
    JSR laser_action_move
    TXA
    TAY
    JSR laser_draw_skull_h
    JMP @end
    @vertical:
    LDA #MTILE::SKULL_V
    STA level, Y
    JSR laser_action_move
    TXA
    TAY
    JSR laser_draw_skull_v

    @end:
    PLA
    TAY
    PLA
    RTS


laser_action_skull_h:
laser_action_skull_v:
    PHA
    TYA
    PHA

    JSR laser_action_move
    TXA
    TAY
    JSR laser_draw_skull_on

    PLA
    TAY
    PLA
    RTS
