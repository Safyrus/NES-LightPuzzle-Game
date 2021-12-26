; Y = laser index
laser_draw_door_h_on:
    pushreg

    JSR laser_pos_to_vram_adr

    LDX #MTILE::DOOR_H_ON
    JSR update_bg_metatile

    @end:
    pullreg
    RTS


; Y = laser index
laser_draw_door_v_on:
    pushreg

    JSR laser_pos_to_vram_adr

    LDX #MTILE::DOOR_V_ON
    JSR update_bg_metatile

    @end:
    pullreg
    RTS
