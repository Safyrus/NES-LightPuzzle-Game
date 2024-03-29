
; text
txt_version: .byte $2F, $10, $34, $12, $34, $11, $FF
txt_win: .byte $30, $22, $27, $FF
txt_loose: .byte $25, $28, $28, $2C, $1E, $FF
txt_goal: .byte $04, $20, $28, $1A, $25, $FF
txt_btn_move_1: .byte $03, $FF
txt_btn_move_2: .byte $05, $00, $06, $00, $26, $28, $2F, $1E, $FF
txt_btn_move_3: .byte $04, $FF
txt_btn_start: .byte $39, $3A, $00, $00, $29, $25, $1A, $32, $FF
txt_btn_a_1: .byte $01, $00, $29, $25, $1A, $1C, $1E, $FF
txt_btn_a_2: .byte $2D, $2E, $2B, $27, $FF
txt_btn_b: .byte $02, $00, $2B, $1E, $26, $28, $2F, $1E, $FF
txt_btn_select: .byte $3B, $3C, $00, $2C, $30, $22, $2D, $1C, $21, $FF
txt_start: .byte $2C, $2D, $1A, $2B, $2D, $FF
txt_resume: .byte $2B, $1E, $2C, $2E, $26, $1E, $FF
txt_selectlevel: .byte $2C, $1E, $25, $1E, $1C, $2D, $00, $25, $1E, $2F, $1E, $25, $00, $05, $00, $00, $06, $FF


; selectable metatiles
select_tiles:
.byte MTILE::WALL, MTILE::MIRROR_1, MTILE::EMIT_UP_ON, MTILE::RECEIVE_DOWN
.byte MTILE::MIRRORC_DR, MTILE::SPLITTER_H, MTILE::MERGER_H, MTILE::DOOR_H
.byte MTILE::VOID, MTILE::VOID, MTILE::VOID, MTILE::VOID
.byte MTILE::VOID, MTILE::VOID, MTILE::VOID, MTILE::VOID


tile_table:
    .byte MTILE::WALL
    .byte MTILE::MIRROR_1
    .byte MTILE::MIRROR_2
    .byte MTILE::EMIT_UP_ON
    .byte MTILE::EMIT_DOWN_ON
    .byte MTILE::EMIT_LEFT_ON
    .byte MTILE::EMIT_RIGHT_ON
    .byte MTILE::RECEIVE_UP
    .byte MTILE::RECEIVE_DOWN
    .byte MTILE::RECEIVE_LEFT
    .byte MTILE::RECEIVE_RIGHT
    .byte MTILE::MIRRORC_UL
    .byte MTILE::MIRRORC_UR
    .byte MTILE::MIRRORC_DL
    .byte MTILE::MIRRORC_DR
    .byte MTILE::SPLITTER_H
    .byte MTILE::SPLITTER_V
    .byte MTILE::MERGER_H
    .byte MTILE::MERGER_V
    .byte MTILE::DOOR_H
    .byte MTILE::DOOR_V
newtile_table:
    .byte MTILE::WALL
    .byte MTILE::MIRROR_2
    .byte MTILE::MIRROR_1
    .byte MTILE::EMIT_RIGHT_ON
    .byte MTILE::EMIT_LEFT_ON
    .byte MTILE::EMIT_UP_ON
    .byte MTILE::EMIT_DOWN_ON
    .byte MTILE::RECEIVE_RIGHT
    .byte MTILE::RECEIVE_LEFT
    .byte MTILE::RECEIVE_UP
    .byte MTILE::RECEIVE_DOWN
    .byte MTILE::MIRRORC_UR
    .byte MTILE::MIRRORC_DR
    .byte MTILE::MIRRORC_UL
    .byte MTILE::MIRRORC_DL
    .byte MTILE::SPLITTER_V
    .byte MTILE::SPLITTER_H
    .byte MTILE::MERGER_V
    .byte MTILE::MERGER_H
    .byte MTILE::DOOR_V
    .byte MTILE::DOOR_H
select_tiles_index_table:
    .byte $00
    .byte $01
    .byte $01
    .byte $02
    .byte $02
    .byte $02
    .byte $02
    .byte $03
    .byte $03
    .byte $03
    .byte $03
    .byte $04
    .byte $04
    .byte $04
    .byte $04
    .byte $05
    .byte $05
    .byte $06
    .byte $06
    .byte $07
    .byte $07
tile_icon_table:
    .byte $08
    .byte $09
    .byte $0E
    .byte $0F
    .byte $0A
    .byte $0C
    .byte $0D
    .byte $0B
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
