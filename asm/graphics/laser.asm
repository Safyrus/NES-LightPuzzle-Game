.include "graphics/laser/skull.asm"
.include "graphics/laser/door.asm"
.include "graphics/laser/mirror.asm"
.include "graphics/laser/receive.asm"

; Y = laser index
laser_draw_ground:
    pushreg

    JSR laser_pos_to_vram_adr

    LDA laser_array_state, Y  ; check if the laser is vertical or horizontal
    AND #%00000010          ; and set the correct Mtile index
    BEQ @hor
    LDX #MTILE::LASER_VER
    JMP @draw
    @hor:
    LDX #MTILE::LASER_HOR
    
    @draw:                  ; draw the laser
    JSR laser_draw_activate

    JSR update_bg_metatile
    LDA laser_array_pos, Y
    TAY
    TXA
    STA level, Y

    pullreg
    RTS


; Y = laser index
laser_draw_lasercross_hor:
    pushreg

    JSR laser_pos_to_vram_adr

    LDA laser_array_state, Y  ; check if the laser is horizontal
    AND #%00000010          ; and draw the LASER_CROSS mtile if needed
    BEQ @end

    JSR laser_draw_activate

    LDX #MTILE::LASER_CROSS
    JSR update_bg_metatile
    LDA laser_array_pos, Y
    TAY
    TXA
    STA level, Y

    @end:
    pullreg
    RTS


; Y = laser index
laser_draw_lasercross_ver:
    pushreg

    JSR laser_pos_to_vram_adr

    LDA laser_array_state, Y  ; check if the laser is vertical
    AND #%00000010          ; and draw the LASER_CROSS mtile if needed
    BNE @end

    JSR laser_draw_activate

    LDX #MTILE::LASER_CROSS
    JSR update_bg_metatile
    LDA laser_array_pos, Y
    TAY
    TXA
    STA level, Y

    @end:
    pullreg
    RTS


; Y = laser index
laser_draw_activate:
    pushreg

    LDA laser_array_pos, Y
    TAX
    LDY #$02
    JSR change_attribute

    @end:
    pullreg
    RTS
