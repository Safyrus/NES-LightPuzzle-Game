; level size 14*12 meta tiles

; level table
level_array_lo:
    .byte <level_00
    .byte <level_01
    .byte <level_02
    .byte <level_03
    .byte <level_04
    .byte <level_05
    .byte <level_06
    .byte <level_07
    .byte <level_08
    .byte <level_09
    .byte <level_0A
    .byte <level_0B
    .byte <level_0C
    .byte <level_0D
    .byte <level_debug
level_array_hi:
    .byte >level_00
    .byte >level_01
    .byte >level_02
    .byte >level_03
    .byte >level_04
    .byte >level_05
    .byte >level_06
    .byte >level_07
    .byte >level_08
    .byte >level_09
    .byte >level_0A
    .byte >level_0B
    .byte >level_0C
    .byte >level_0D
    .byte >level_debug


level_00:
    .byte MTILE::SPE_ARRAY, (16*6+3-1), MTILE::WALL
    .byte MTILE::GROUND, MTILE::GROUND, MTILE::RECEIVE_DOWN, MTILE::GROUND, MTILE::GROUND, MTILE::SPE_ARRAY, (8+3-1), MTILE::WALL
    .byte MTILE::SPE_ARRAY, (5-1), MTILE::GROUND, MTILE::WALL, MTILE::WALL, MTILE::SPE_ARRAY, (4-1), MTILE::VOID, MTILE::SPE_ARRAY, (2+3-1), MTILE::WALL
    .byte MTILE::SPE_ARRAY, (5-1), MTILE::GROUND, MTILE::WALL, MTILE::WALL, MTILE::SPE_ARRAY, (4-1), MTILE::VOID, MTILE::SPE_ARRAY, (2+3-1), MTILE::WALL
    .byte MTILE::SPE_ARRAY, (5-1), MTILE::GROUND, MTILE::WALL, MTILE::WALL, MTILE::SPE_ARRAY, (4-1), MTILE::VOID, MTILE::SPE_ARRAY, (2+3-1), MTILE::WALL
    .byte MTILE::GROUND, MTILE::GROUND, MTILE::EMIT_UP_ON, MTILE::GROUND, MTILE::GROUND
    .byte MTILE::SPE_ARRAY, (16*4+8-1), MTILE::WALL
    .byte $01, $00, $00, $00, $00, $00, $00, $00, $02, $03

level_01:
    .byte MTILE::SPE_ARRAY, (16*5+3-1), MTILE::WALL
    .byte MTILE::SPE_ARRAY, (5-1), MTILE::GROUND, MTILE::RECEIVE_DOWN, MTILE::GROUND, MTILE::SPE_ARRAY, (9-1), MTILE::WALL
    .byte MTILE::SPE_ARRAY, (7-1), MTILE::GROUND, MTILE::WALL, MTILE::GROUND, MTILE::GROUND, MTILE::GROUND, MTILE::SPE_ARRAY, (5-1), MTILE::WALL
    .byte MTILE::SPE_ARRAY, (7-1), MTILE::GROUND, MTILE::WALL, MTILE::GROUND, MTILE::MIRROR_1, MTILE::GROUND, MTILE::SPE_ARRAY, (5-1), MTILE::WALL
    .byte MTILE::SPE_ARRAY, (7-1), MTILE::GROUND, MTILE::WALL, MTILE::GROUND, MTILE::GROUND, MTILE::GROUND, MTILE::SPE_ARRAY, (5-1), MTILE::WALL
    .byte MTILE::SPE_ARRAY, (7-1), MTILE::GROUND, MTILE::WALL, MTILE::GROUND, MTILE::EMIT_UP_ON, MTILE::GROUND, MTILE::SPE_ARRAY, (5-1), MTILE::WALL
    .byte MTILE::GROUND, MTILE::EMIT_UP_ON, MTILE::SPE_ARRAY, (5-1), MTILE::GROUND
    .byte MTILE::SPE_ARRAY, (16+6-1), MTILE::WALL
    .byte MTILE::SPE_ARRAY, (16*2-1), MTILE::VOID
    .byte MTILE::SPE_ARRAY, (16-1), MTILE::WALL
    .byte $04, $00, $00, $00, $00, $00, $00, $00, $02, $03

level_02:
    .byte MTILE::SPE_ARRAY, (16*4+5-1), MTILE::WALL
    .byte MTILE::SPE_ARRAY, (6-1), MTILE::GROUND, MTILE::SPE_ARRAY, (10-1), MTILE::WALL
    .byte MTILE::GROUND, MTILE::GROUND, MTILE::WALL, MTILE::WALL, MTILE::GROUND, MTILE::GROUND, MTILE::SPE_ARRAY, (10-1), MTILE::WALL
    .byte MTILE::GROUND, MTILE::GROUND, MTILE::WALL, MTILE::WALL, MTILE::GROUND, MTILE::GROUND, MTILE::SPE_ARRAY, (10-1), MTILE::WALL
    .byte MTILE::EMIT_RIGHT_ON, MTILE::GROUND, MTILE::WALL, MTILE::WALL, MTILE::GROUND, MTILE::RECEIVE_LEFT, MTILE::SPE_ARRAY, (10-1), MTILE::WALL
    .byte MTILE::GROUND, MTILE::GROUND, MTILE::WALL, MTILE::WALL, MTILE::GROUND, MTILE::GROUND, MTILE::SPE_ARRAY, (10-1), MTILE::WALL
    .byte MTILE::GROUND, MTILE::GROUND, MTILE::WALL, MTILE::WALL, MTILE::GROUND, MTILE::GROUND, MTILE::SPE_ARRAY, (10-1), MTILE::WALL
    .byte MTILE::SPE_ARRAY, (6-1), MTILE::GROUND
    .byte MTILE::SPE_ARRAY, (16*4+5-1), MTILE::WALL
    .byte $04, $00, $00, $00, $00, $00, $00, $00, $02, $03

level_03:
    .byte MTILE::SPE_ARRAY, (16*5+4-1), MTILE::WALL
    .byte MTILE::GROUND, MTILE::GROUND, MTILE::WALL, MTILE::MIRROR_1, MTILE::GROUND, MTILE::GROUND, MTILE::MIRROR_2, MTILE::SPE_ARRAY, (9-1), MTILE::WALL
    .byte MTILE::EMIT_RIGHT_ON, MTILE::GROUND, MTILE::WALL, MTILE::SPE_ARRAY, (4-1), MTILE::GROUND, MTILE::SPE_ARRAY, (9-1), MTILE::WALL
    .byte MTILE::SPE_ARRAY, (7-1), MTILE::GROUND, MTILE::SPE_ARRAY, (9-1), MTILE::WALL
    .byte MTILE::WALL, MTILE::GROUND, MTILE::WALL, MTILE::SPE_ARRAY, (4-1), MTILE::GROUND, MTILE::SPE_ARRAY, (9-1), MTILE::WALL
    .byte MTILE::RECEIVE_RIGHT, MTILE::MIRROR_2, MTILE::SPE_ARRAY, (5-1), MTILE::GROUND, MTILE::SPE_ARRAY, (9-1), MTILE::WALL
    .byte MTILE::WALL, MTILE::GROUND, MTILE::WALL, MTILE::SPE_ARRAY, (4-1), MTILE::GROUND, MTILE::SPE_ARRAY, (9-1), MTILE::WALL
    .byte MTILE::GROUND, MTILE::GROUND, MTILE::GROUND, MTILE::MIRROR_1, MTILE::WALL, MTILE::GROUND, MTILE::MIRROR_1
    .byte MTILE::SPE_ARRAY, (16*3+5-1), MTILE::WALL
    .byte $03, $00, $00, $00, $00, $00, $00, $00, $04, $05

level_04:
    .byte MTILE::SPE_ARRAY, (16*5+5-1), MTILE::WALL
    .byte MTILE::GROUND, MTILE::GROUND, MTILE::RECEIVE_DOWN, MTILE::GROUND, MTILE::GROUND, MTILE::SPE_ARRAY, (11-1), MTILE::WALL
    .byte MTILE::GROUND, MTILE::WALL, MTILE::GROUND, MTILE::GROUND, MTILE::GROUND, MTILE::SPE_ARRAY, (11-1), MTILE::WALL
    .byte MTILE::EMIT_RIGHT_ON, MTILE::GROUND, MTILE::MIRRORC_DR, MTILE::GROUND, MTILE::RECEIVE_LEFT, MTILE::SPE_ARRAY, (11-1), MTILE::WALL
    .byte MTILE::SPE_ARRAY, (5-1), MTILE::GROUND, MTILE::SPE_ARRAY, (11-1), MTILE::WALL
    .byte MTILE::GROUND, MTILE::GROUND, MTILE::EMIT_UP_ON, MTILE::GROUND, MTILE::GROUND
    .byte MTILE::SPE_ARRAY, (16*5+6-1), MTILE::WALL
    .byte $05, $00, $00, $00, $00, $00, $00, $00, $02, $03

level_05:
    .byte MTILE::SPE_ARRAY, (16*5+4-1), MTILE::WALL
    .byte MTILE::GROUND, MTILE::GROUND, MTILE::EMIT_DOWN_ON, MTILE::GROUND, MTILE::EMIT_DOWN_ON, MTILE::GROUND, MTILE::GROUND, MTILE::SPE_ARRAY, (5+4-1), MTILE::WALL
    .byte MTILE::SPE_ARRAY, (7-1), MTILE::GROUND, MTILE::SPE_ARRAY, (5+4-1), MTILE::WALL
    .byte MTILE::SPE_ARRAY, (7-1), MTILE::GROUND, MTILE::SPE_ARRAY, (5+4-1), MTILE::WALL
    .byte MTILE::RECEIVE_RIGHT, MTILE::SPE_ARRAY, (5-1), MTILE::GROUND, MTILE::RECEIVE_LEFT, MTILE::SPE_ARRAY, (5+4-1), MTILE::WALL
    .byte MTILE::SPE_ARRAY, (7-1), MTILE::GROUND, MTILE::SPE_ARRAY, (5+4-1), MTILE::WALL
    .byte MTILE::GROUND, MTILE::GROUND, MTILE::RECEIVE_UP, MTILE::EMIT_UP_ON, MTILE::GROUND, MTILE::GROUND, MTILE::GROUND
    .byte MTILE::SPE_ARRAY, (16*1+5+4-1), MTILE::WALL
    .byte MTILE::SPE_ARRAY, (7-1), MTILE::VOID
    .byte MTILE::SPE_ARRAY, (16*2+5-1), MTILE::WALL
    .byte $01, $00, $20, $00, $00, $00, $00, $00, $02, $03

level_06:
    .byte MTILE::SPE_ARRAY, (16*6+1-1), MTILE::WALL
    .byte MTILE::SPE_ARRAY, (14-1), MTILE::GROUND, MTILE::WALL
    .byte MTILE::WALL, MTILE::SPE_ARRAY, (13-1), MTILE::GROUND, MTILE::RECEIVE_LEFT, MTILE::WALL
    .byte MTILE::WALL, MTILE::SPE_ARRAY, (7-1), MTILE::GROUND, MTILE::SPLITTER_V, MTILE::SPE_ARRAY, (6-1), MTILE::GROUND, MTILE::WALL
    .byte MTILE::WALL, MTILE::EMIT_RIGHT_ON, MTILE::SPE_ARRAY, (12-1), MTILE::GROUND, MTILE::RECEIVE_LEFT, MTILE::WALL
    .byte MTILE::WALL, MTILE::SPE_ARRAY, (14-1), MTILE::GROUND
    .byte MTILE::SPE_ARRAY, (16*4+1-1), MTILE::WALL
    .byte $04, $00, $00, $00, $00, $00, $00, $00, $02, $03

level_07:
    .byte MTILE::SPE_ARRAY, (16*6+1-1), MTILE::WALL
    .byte MTILE::SPE_ARRAY, (14-1), MTILE::GROUND, MTILE::WALL
    .byte MTILE::WALL, MTILE::EMIT_RIGHT_ON, MTILE::SPE_ARRAY, (10-1), MTILE::GROUND, MTILE::SPE_ARRAY, (4-1), MTILE::WALL
    .byte MTILE::WALL, MTILE::SPE_ARRAY, (10-1), MTILE::GROUND, MTILE::MERGER_H, MTILE::GROUND, MTILE::GROUND, MTILE::RECEIVE_LEFT, MTILE::WALL
    .byte MTILE::WALL, MTILE::EMIT_RIGHT_ON, MTILE::SPE_ARRAY, (10-1), MTILE::GROUND, MTILE::SPE_ARRAY, (4-1), MTILE::WALL
    .byte MTILE::WALL, MTILE::SPE_ARRAY, (14-1), MTILE::GROUND
    .byte MTILE::SPE_ARRAY, (16*4+1-1), MTILE::WALL
    .byte $02, $00, $00, $00, $00, $00, $00, $00, $02, $03

level_08:
    .byte MTILE::SPE_ARRAY, (16*5+5-1), MTILE::WALL
    .byte MTILE::GROUND, MTILE::EMIT_DOWN_ON, MTILE::SPE_ARRAY, (4-1), MTILE::GROUND, MTILE::SPE_ARRAY, (10-1), MTILE::WALL
    .byte MTILE::GROUND, MTILE::GROUND, MTILE::GROUND, MTILE::GLASS, MTILE::GROUND, MTILE::EMIT_LEFT_ON, MTILE::SPE_ARRAY, (10-1), MTILE::WALL
    .byte MTILE::SPE_ARRAY, (4-1), MTILE::GROUND, MTILE::SPE_ARRAY, (12-1), MTILE::WALL
    .byte MTILE::GROUND, MTILE::GROUND, MTILE::GROUND, MTILE::DOOR_H, MTILE::GROUND, MTILE::RECEIVE_LEFT, MTILE::SPE_ARRAY, (10-1), MTILE::WALL
    .byte MTILE::SPE_ARRAY, (4-1), MTILE::GROUND
    .byte MTILE::SPE_ARRAY, (16*5+7-1), MTILE::WALL
    .byte $04, $00, $00, $00, $00, $00, $00, $00, $02, $03

level_09:
    .byte MTILE::SPE_ARRAY, (16*4+5-1), MTILE::WALL
    .byte MTILE::SPE_ARRAY, (4-1), MTILE::GROUND, MTILE::MIRROR_2, MTILE::SPE_ARRAY, (10-1), MTILE::WALL
    .byte MTILE::EMIT_RIGHT_ON, MTILE::GROUND, MTILE::GROUND, MTILE::MIRROR_2, MTILE::GROUND, MTILE::MIRROR_2, MTILE::RECEIVE_LEFT,MTILE::SPE_ARRAY, (9-1), MTILE::WALL
    .byte MTILE::SPE_ARRAY, (7-1), MTILE::GROUND, MTILE::SPE_ARRAY, (9-1), MTILE::WALL
    .byte MTILE::GROUND, MTILE::GROUND, MTILE::GROUND, MTILE::MIRROR_1, MTILE::GROUND, MTILE::GROUND, MTILE::GROUND, MTILE::SPE_ARRAY, (9-1), MTILE::WALL
    .byte MTILE::SPE_ARRAY, (7-1), MTILE::GROUND, MTILE::SPE_ARRAY, (9-1), MTILE::WALL
    .byte MTILE::EMIT_RIGHT_ON, MTILE::GROUND, MTILE::GROUND, MTILE::MIRROR_1, MTILE::GROUND, MTILE::MIRROR_1, MTILE::RECEIVE_LEFT,MTILE::SPE_ARRAY, (10-1), MTILE::WALL
    .byte MTILE::SPE_ARRAY, (4-1), MTILE::GROUND, MTILE::MIRROR_1
    .byte MTILE::SPE_ARRAY, (16*4+6-1), MTILE::WALL
    .byte $04, $00, $00, $00, $00, $00, $00, $00, $02, $03

level_0A:
    .byte MTILE::SPE_ARRAY, (16*4+6-1), MTILE::WALL
    .byte MTILE::RECEIVE_DOWN, MTILE::WALL, MTILE::WALL, MTILE::EMIT_DOWN_ON, MTILE::EMIT_DOWN_ON, MTILE::SPE_ARRAY, (11-1), MTILE::WALL
    .byte MTILE::GROUND, MTILE::WALL, MTILE::WALL, MTILE::GROUND, MTILE::GROUND, MTILE::SPE_ARRAY, (9-1), MTILE::WALL
    .byte MTILE::GROUND, MTILE::GROUND, MTILE::MIRROR_1, MTILE::WALL, MTILE::WALL, MTILE::GROUND, MTILE::GROUND, MTILE::SPE_ARRAY, (9-1), MTILE::WALL
    .byte MTILE::GROUND, MTILE::GROUND, MTILE::WALL, MTILE::MIRROR_1, MTILE::GROUND, MTILE::GROUND, MTILE::GROUND, MTILE::SPE_ARRAY, (9-1), MTILE::WALL
    .byte MTILE::SPE_ARRAY, (5-1), MTILE::GROUND, MTILE::MIRROR_1, MTILE::RECEIVE_LEFT, MTILE::SPE_ARRAY, (9-1), MTILE::WALL
    .byte MTILE::SPE_ARRAY, (4-1), MTILE::GROUND, MTILE::WALL, MTILE::GROUND, MTILE::SPE_ARRAY, (10-1), MTILE::WALL
    .byte MTILE::SPE_ARRAY, (6-1), MTILE::GROUND
    .byte MTILE::SPE_ARRAY, (16*4+6-1), MTILE::WALL
    .byte $05, $00, $00, $00, $00, $00, $00, $00, $02, $03

level_0B:
    .byte MTILE::SPE_ARRAY, (16*4+4-1), MTILE::WALL
    .byte MTILE::GROUND, MTILE::RECEIVE_DOWN, MTILE::GROUND, MTILE::GROUND, MTILE::GROUND, MTILE::RECEIVE_DOWN, MTILE::GROUND, MTILE::SPE_ARRAY, (9-1), MTILE::WALL
    .byte MTILE::SPE_ARRAY, (7-1), MTILE::GROUND, MTILE::SPE_ARRAY, (9-1), MTILE::WALL
    .byte MTILE::GROUND, MTILE::GROUND, MTILE::GROUND, MTILE::RECEIVE_UP, MTILE::GROUND, MTILE::GROUND, MTILE::GROUND, MTILE::SPE_ARRAY, (9-1), MTILE::WALL
    .byte MTILE::GROUND, MTILE::GROUND, MTILE::WALL, MTILE::WALL, MTILE::WALL, MTILE::GROUND, MTILE::GROUND, MTILE::SPE_ARRAY, (9-1), MTILE::WALL
    .byte MTILE::GROUND, MTILE::GROUND, MTILE::GROUND, MTILE::EMIT_DOWN_ON, MTILE::GROUND, MTILE::GROUND, MTILE::GROUND, MTILE::SPE_ARRAY, (9-1), MTILE::WALL
    .byte MTILE::SPE_ARRAY, (7-1), MTILE::GROUND, MTILE::SPE_ARRAY, (9-1), MTILE::WALL
    .byte MTILE::SPE_ARRAY, (7-1), MTILE::GROUND
    .byte MTILE::SPE_ARRAY, (16*4+5-1), MTILE::WALL
    .byte $05, $00, $02, $00, $00, $00, $00, $00, $02, $03

level_0C:
    .byte MTILE::SPE_ARRAY, (16*3+6-1), MTILE::WALL
    .byte MTILE::GROUND, MTILE::WALL, MTILE::EMIT_DOWN_ON, MTILE::SPE_ARRAY, (7+6-1), MTILE::WALL
    .byte MTILE::MIRROR_1, MTILE::SPE_ARRAY, (4-1), MTILE::GROUND, MTILE::SPE_ARRAY, (5+6-1), MTILE::WALL
    .byte MTILE::GROUND, MTILE::WALL, MTILE::GROUND, MTILE::WALL, MTILE::GROUND, MTILE::SPE_ARRAY, (5+3-1), MTILE::WALL
    .byte MTILE::RECEIVE_DOWN, MTILE::WALL, MTILE::GROUND, MTILE::MIRROR_1, MTILE::RECEIVE_DOWN, MTILE::GROUND, MTILE::WALL, MTILE::GROUND, MTILE::GROUND, MTILE::SPE_ARRAY, (4+3-1), MTILE::WALL
    .byte MTILE::SPE_ARRAY, (4-1), MTILE::GROUND, MTILE::MIRROR_2, MTILE::SPE_ARRAY, (4-1), MTILE::GROUND, MTILE::SPE_ARRAY, (4+3-1), MTILE::WALL
    .byte MTILE::GROUND, MTILE::WALL, MTILE::RECEIVE_UP, MTILE::WALL, MTILE::GROUND, MTILE::WALL, MTILE::WALL, MTILE::EMIT_UP_ON, MTILE::GROUND, MTILE::SPE_ARRAY, (4+7-1), MTILE::WALL
    .byte MTILE::GROUND, MTILE::GROUND, MTILE::SPE_ARRAY, (7+7-1), MTILE::WALL
    .byte MTILE::GROUND, MTILE::GROUND, MTILE::SPE_ARRAY, (7+6-1), MTILE::WALL
    .byte MTILE::EMIT_RIGHT_ON, MTILE::GROUND, MTILE::GROUND
    .byte MTILE::SPE_ARRAY, (16*3+7-1), MTILE::WALL
    .byte $05, $00, $00, $00, $00, $00, $00, $00, $02, $03

level_0D:
    .byte MTILE::SPE_ARRAY, (16*5+5-1), MTILE::WALL
    .byte MTILE::SPE_ARRAY, (6-1), MTILE::GROUND, MTILE::SPE_ARRAY, (10-1), MTILE::WALL
    .byte MTILE::SPE_ARRAY, (6-1), MTILE::GROUND, MTILE::SPE_ARRAY, (10-1), MTILE::WALL
    .byte MTILE::EMIT_RIGHT_ON, MTILE::GROUND, MTILE::GROUND, MTILE::CROSS, MTILE::GROUND, MTILE::RECEIVE_LEFT, MTILE::SPE_ARRAY, (10-1), MTILE::WALL
    .byte MTILE::SPE_ARRAY, (6-1), MTILE::GROUND, MTILE::SPE_ARRAY, (10-1), MTILE::WALL
    .byte MTILE::SPE_ARRAY, (6-1), MTILE::GROUND
    .byte MTILE::SPE_ARRAY, (16*5+5-1), MTILE::WALL
    .byte $04, $00, $00, $00, $00, $00, $00, $00, $02, $03

level_debug:
    .byte $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0A, $0B, $0C, $0D, $0E, $0F
    .byte $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $1A, $1B, $1C, $1D, $1E, $1F
    .byte $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $2A, $2B, $2C, $2D, $2E, $2F
    .byte $30, $31, $32, $33, $34, $35, $36, $37, $38, $39, $3A, $3B, $3C, $3D, $3E, $3F
    .byte MTILE::SPE_ARRAY, (16-1), MTILE::EMIT_DOWN_ON
    .byte MTILE::SPE_ARRAY, (16*9-1), MTILE::GROUND
    .byte MTILE::SPE_ARRAY, (16-1), MTILE::EMIT_UP_ON
    .byte $FF, $FF, $FF, $FF, $00, $00, $00, $00, $01, $01
