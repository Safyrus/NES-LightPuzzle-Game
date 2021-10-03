; level size 14*12 meta tiles

; level table
levelArrayLo:
    .byte <level_00
    .byte <level_01
levelArrayHi:
    .byte >level_00
    .byte >level_01


level_00:
    .byte MTILE::SPE_ARRAY, (16*4+4-1), MTILE::WALL
    .byte MTILE::SPE_ARRAY, (6-1), MTILE::GROUND, MTILE::RECEIVE_DOWN, MTILE::GROUND, MTILE::SPE_ARRAY, (8-1), MTILE::WALL
    .byte MTILE::SPE_ARRAY, (8-1), MTILE::GROUND, MTILE::SPE_ARRAY, (8-1), MTILE::WALL
    .byte MTILE::SPE_ARRAY, (8-1), MTILE::GROUND, MTILE::SPE_ARRAY, (8-1), MTILE::WALL
    .byte MTILE::SPE_ARRAY, (8-1), MTILE::GROUND, MTILE::SPE_ARRAY, (8-1), MTILE::WALL
    .byte MTILE::SPE_ARRAY, (8-1), MTILE::GROUND, MTILE::SPE_ARRAY, (8-1), MTILE::WALL
    .byte MTILE::GROUND, MTILE::EMIT_UP_ON, MTILE::SPE_ARRAY, (6-1), MTILE::GROUND
    .byte MTILE::SPE_ARRAY, (16*3+4-1), MTILE::WALL
    .byte MTILE::SPE_ARRAY, (16-1), MTILE::UITOP
    .byte MTILE::SPE_ARRAY, (16-1), MTILE::VOID
    .byte $01, $23, $45, $67, $89, $AB, $CD, $EF, $02, $03

level_01:
    .byte $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0A, $0B, $0C, $0D, $0E, $0F
    .byte $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $1A, $1B, $1C, $1D, $1E, $1F
    .byte $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $2A, $2B, $2C, $2D, $2E, $2F
    .byte $30, $31, $32, $33, $34, $35, $36, $37, $38, $39, $3A, $3B, $3C, $3D, $3E, $3F
    .byte MTILE::SPE_ARRAY, (16*11-1), MTILE::GROUND
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $01, $01
