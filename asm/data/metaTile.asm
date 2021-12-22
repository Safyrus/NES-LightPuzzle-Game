; Array
metatile_array_lo:
    .byte <metatile_VOID
    .byte <metatile_WALL
    .byte <metatile_GROUND
    .byte <metatile_UI_BOT
    .byte <metatile_GLASS
    .byte <metatile_LASER_HOR
    .byte <metatile_LASER_VER
    .byte <metatile_LASER_CROSS
    .byte <metatile_CROSS
    .byte <metatile_CROSS_H
    .byte <metatile_CROSS_V
    .byte <metatile_CROSS
    .byte <metatile_VOID
    .byte <metatile_VOID
    .byte <metatile_VOID
    .byte <metatile_VOID

    .byte <metatile_EMIT_UP
    .byte <metatile_EMIT_DOWN
    .byte <metatile_EMIT_LEFT
    .byte <metatile_EMIT_RIGHT
    .byte <metatile_EMIT_UP
    .byte <metatile_EMIT_DOWN
    .byte <metatile_EMIT_LEFT
    .byte <metatile_EMIT_RIGHT
    .byte <metatile_RECEIVE_UP
    .byte <metatile_RECEIVE_DOWN
    .byte <metatile_RECEIVE_LEFT
    .byte <metatile_RECEIVE_RIGHT
    .byte <metatile_RECEIVE_UP
    .byte <metatile_RECEIVE_DOWN
    .byte <metatile_RECEIVE_LEFT
    .byte <metatile_RECEIVE_RIGHT

    .byte <metatile_MIRROR_UL
    .byte <metatile_MIRROR_UR
    .byte <metatile_MIRROR_CROSS1
    .byte <metatile_MIRROR_CROSS2
    .byte <metatile_MIRROR_UL
    .byte <metatile_MIRROR_UR
    .byte <metatile_MIRROR_DL
    .byte <metatile_MIRROR_DR
    .byte <metatile_MIRRORC_UL
    .byte <metatile_MIRRORC_UR
    .byte <metatile_MIRRORC_DL
    .byte <metatile_MIRRORC_DR
    .byte <metatile_VOID
    .byte <metatile_VOID
    .byte <metatile_VOID
    .byte <metatile_VOID

    .byte <metatile_DOOR_H
    .byte <metatile_DOOR_V
    .byte <metatile_DOOR_H_ON
    .byte <metatile_DOOR_V_ON
    .byte <metatile_SPLITTER_H
    .byte <metatile_SPLITTER_V
    .byte <metatile_SPLITTER_H
    .byte <metatile_SPLITTER_V
    .byte <metatile_MERGER_H
    .byte <metatile_MERGER_V
    .byte <metatile_MERGER_H
    .byte <metatile_MERGER_V
    .byte <metatile_MERGER_H
    .byte <metatile_MERGER_V
    .byte <metatile_MERGER_H
    .byte <metatile_MERGER_V

metatile_array_hi:
    .byte >metatile_VOID
    .byte >metatile_WALL
    .byte >metatile_GROUND
    .byte >metatile_UI_BOT
    .byte >metatile_GLASS
    .byte >metatile_LASER_HOR
    .byte >metatile_LASER_VER
    .byte >metatile_LASER_CROSS
    .byte >metatile_CROSS
    .byte >metatile_CROSS_H
    .byte >metatile_CROSS_V
    .byte >metatile_CROSS
    .byte >metatile_VOID
    .byte >metatile_VOID
    .byte >metatile_VOID
    .byte >metatile_VOID

    .byte >metatile_EMIT_UP
    .byte >metatile_EMIT_DOWN
    .byte >metatile_EMIT_LEFT
    .byte >metatile_EMIT_RIGHT
    .byte >metatile_EMIT_UP
    .byte >metatile_EMIT_DOWN
    .byte >metatile_EMIT_LEFT
    .byte >metatile_EMIT_RIGHT
    .byte >metatile_RECEIVE_UP
    .byte >metatile_RECEIVE_DOWN
    .byte >metatile_RECEIVE_LEFT
    .byte >metatile_RECEIVE_RIGHT
    .byte >metatile_RECEIVE_UP
    .byte >metatile_RECEIVE_DOWN
    .byte >metatile_RECEIVE_LEFT
    .byte >metatile_RECEIVE_RIGHT

    .byte >metatile_MIRROR_UL
    .byte >metatile_MIRROR_UR
    .byte >metatile_MIRROR_CROSS1
    .byte >metatile_MIRROR_CROSS2
    .byte >metatile_MIRROR_UL
    .byte >metatile_MIRROR_UR
    .byte >metatile_MIRROR_DL
    .byte >metatile_MIRROR_DR
    .byte >metatile_MIRRORC_UL
    .byte >metatile_MIRRORC_UR
    .byte >metatile_MIRRORC_DL
    .byte >metatile_MIRRORC_DR
    .byte >metatile_VOID
    .byte >metatile_VOID
    .byte >metatile_VOID
    .byte >metatile_VOID

    .byte >metatile_DOOR_H
    .byte >metatile_DOOR_V
    .byte >metatile_DOOR_H_ON
    .byte >metatile_DOOR_V_ON
    .byte >metatile_SPLITTER_H
    .byte >metatile_SPLITTER_V
    .byte >metatile_SPLITTER_H
    .byte >metatile_SPLITTER_V
    .byte >metatile_MERGER_H
    .byte >metatile_MERGER_V
    .byte >metatile_MERGER_H
    .byte >metatile_MERGER_V
    .byte >metatile_MERGER_H
    .byte >metatile_MERGER_V
    .byte >metatile_MERGER_H
    .byte >metatile_MERGER_V



; Data
metatile_VOID:          .byte $00, $00, $00, $00   ; VOID
metatile_WALL:          .byte $50, $50, $40, $50   ; WALL
metatile_GROUND:        .byte $5D, $00, $00, $5C   ; GROUND
metatile_UI_BOT:        .byte $00, $00, $52, $52   ; UI_BOT
metatile_GLASS:         .byte $4D, $4D, $4D, $4D   ; GLASS
metatile_CROSS:         .byte $62, $63, $72, $73   ; CROSS
metatile_CROSS_H:       .byte $64, $65, $74, $75   ; CROSS_H
metatile_CROSS_V:       .byte $66, $67, $76, $77   ; CROSS_V

metatile_EMIT_UP:       .byte $42, $43, $44, $45   ; EMIT_UP
metatile_EMIT_DOWN:     .byte $54, $55, $42, $43   ; EMIT_DOWN
metatile_EMIT_LEFT:     .byte $52, $46, $53, $56   ; EMIT_LEFT
metatile_EMIT_RIGHT:    .byte $47, $52, $57, $53   ; EMIT_RIGHT
metatile_RECEIVE_UP:    .byte $42, $43, $48, $49   ; RECEIVE_UP
metatile_RECEIVE_DOWN:  .byte $58, $59, $42, $43   ; RECEIVE_DOWN
metatile_RECEIVE_LEFT:  .byte $52, $4A, $53, $5A   ; RECEIVE_LEFT
metatile_RECEIVE_RIGHT: .byte $4B, $52, $5B, $53   ; RECEIVE_RIGHT

metatile_LASER_HOR:     .byte $42, $43, $42, $43   ; LASER_HOR
metatile_LASER_VER:     .byte $52, $52, $53, $53   ; LASER_VER
metatile_LASER_CROSS:   .byte $60, $61, $70, $71   ; LASER_CROSS

metatile_MIRROR_UL:     .byte $60, $67, $74, $7F   ; MIRROR_UL
metatile_MIRROR_UR:     .byte $66, $61, $7E, $75   ; MIRROR_UR
metatile_MIRROR_DL:     .byte $64, $6F, $70, $77   ; MIRROR_DL
metatile_MIRROR_DR:     .byte $6E, $65, $76, $71   ; MIRROR_DR
metatile_MIRROR_CROSS1: .byte $62, $61, $70, $73   ; MIRROR_CROSS1
metatile_MIRROR_CROSS2: .byte $60, $63, $72, $71   ; MIRROR_CROSS2
metatile_MIRRORC_UL:    .byte $60, $6D, $7A, $79   ; MIRRORC_UL
metatile_MIRRORC_UR:    .byte $6C, $61, $78, $7B   ; MIRRORC_UR
metatile_MIRRORC_DL:    .byte $6A, $69, $70, $7D   ; MIRRORC_DL
metatile_MIRRORC_DR:    .byte $68, $6B, $7C, $71   ; MIRRORC_DR

metatile_DOOR_H:        .byte $80, $81, $90, $91   ; DOOR_H
metatile_DOOR_V:        .byte $82, $83, $92, $93   ; DOOR_V
metatile_DOOR_H_ON:     .byte $84, $85, $94, $95   ; DOOR_H_ON
metatile_DOOR_V_ON:     .byte $86, $87, $96, $97   ; DOOR_V_ON
metatile_SPLITTER_H:    .byte $88, $89, $98, $99   ; SPLITTER_H
metatile_SPLITTER_V:    .byte $8A, $8B, $9A, $9B   ; SPLITTER_V
metatile_MERGER_H:      .byte $8C, $8D, $9C, $9D   ; MERGER_H
metatile_MERGER_V:      .byte $8E, $8F, $9E, $9F   ; MERGER_V
