; Y = laser index
laser_draw_receive_up:
    pushreg

    JSR laser_pos_to_vram_adr

    LDX #MTILE::RECEIVE_UP_ON
    JSR laser_draw_activate
    JSR update_bg_metatile
    LDA laser_array_pos, Y
    TAY
    TXA
    STA level, Y

    pullreg
    RTS


; Y = laser index
laser_draw_receive_down:
    pushreg

    JSR laser_pos_to_vram_adr

    LDX #MTILE::RECEIVE_DOWN_ON
    JSR laser_draw_activate
    JSR update_bg_metatile
    LDA laser_array_pos, Y
    TAY
    TXA
    STA level, Y

    pullreg
    RTS


; Y = laser index
laser_draw_receive_left:
    pushreg

    JSR laser_pos_to_vram_adr

    LDX #MTILE::RECEIVE_LEFT_ON
    JSR laser_draw_activate
    JSR update_bg_metatile
    LDA laser_array_pos, Y
    TAY
    TXA
    STA level, Y

    pullreg
    RTS


; Y = laser index
laser_draw_receive_right:
    pushreg

    JSR laser_pos_to_vram_adr

    LDX #MTILE::RECEIVE_RIGHT_ON
    JSR laser_draw_activate
    JSR update_bg_metatile
    LDA laser_array_pos, Y
    TAY
    TXA
    STA level, Y

    pullreg
    RTS
