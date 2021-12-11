; Array
metaTileArrayLo:
    .byte <metaTile_VOID
    .byte <metaTile_WALL
    .byte <metaTile_GROUND
    .byte <metaTile_UI_BOT
    .byte <metaTile_LOCK
    .byte <metaTile_LASER_HOR
    .byte <metaTile_LASER_VER
    .byte <metaTile_LASER_CROSS
    .byte <metaTile_VOID
    .byte <metaTile_VOID
    .byte <metaTile_VOID
    .byte <metaTile_VOID
    .byte <metaTile_VOID
    .byte <metaTile_VOID
    .byte <metaTile_VOID
    .byte <metaTile_VOID

    .byte <metaTile_EMIT_UP
    .byte <metaTile_EMIT_DOWN
    .byte <metaTile_EMIT_LEFT
    .byte <metaTile_EMIT_RIGHT
    .byte <metaTile_EMIT_UP
    .byte <metaTile_EMIT_DOWN
    .byte <metaTile_EMIT_LEFT
    .byte <metaTile_EMIT_RIGHT
    .byte <metaTile_RECEIVE_UP
    .byte <metaTile_RECEIVE_DOWN
    .byte <metaTile_RECEIVE_LEFT
    .byte <metaTile_RECEIVE_RIGHT
    .byte <metaTile_RECEIVE_UP
    .byte <metaTile_RECEIVE_DOWN
    .byte <metaTile_RECEIVE_LEFT
    .byte <metaTile_RECEIVE_RIGHT

    .byte <metaTile_MIRROR_UL
    .byte <metaTile_MIRROR_UR
    .byte <metaTile_MIRROR_CROSS1
    .byte <metaTile_MIRROR_CROSS2
    .byte <metaTile_MIRROR_UL
    .byte <metaTile_MIRROR_UR
    .byte <metaTile_MIRROR_DL
    .byte <metaTile_MIRROR_DR
    .byte <metaTile_MIRRORC_UL
    .byte <metaTile_MIRRORC_UR
    .byte <metaTile_MIRRORC_DL
    .byte <metaTile_MIRRORC_DR
    .byte <metaTile_TIMEWALL_OFF
    .byte <metaTile_TIMEWALL_ON
    .byte <metaTile_VOID
    .byte <metaTile_VOID

    .byte <metaTile_DOOR_H
    .byte <metaTile_DOOR_V
    .byte <metaTile_DOORL_H
    .byte <metaTile_DOORL_V
    .byte <metaTile_SPLITTER_H
    .byte <metaTile_SPLITTER_V
    .byte <metaTile_SPLITTER_H
    .byte <metaTile_SPLITTER_V
    .byte <metaTile_MERGER_H
    .byte <metaTile_MERGER_V
    .byte <metaTile_MERGER_H
    .byte <metaTile_MERGER_V
    .byte <metaTile_MERGER_H
    .byte <metaTile_MERGER_V
    .byte <metaTile_MERGER_H
    .byte <metaTile_MERGER_V

metaTileArrayHi:
    .byte >metaTile_VOID
    .byte >metaTile_WALL
    .byte >metaTile_GROUND
    .byte >metaTile_UI_BOT
    .byte >metaTile_LOCK
    .byte >metaTile_LASER_HOR
    .byte >metaTile_LASER_VER
    .byte >metaTile_LASER_CROSS
    .byte >metaTile_VOID
    .byte >metaTile_VOID
    .byte >metaTile_VOID
    .byte >metaTile_VOID
    .byte >metaTile_VOID
    .byte >metaTile_VOID
    .byte >metaTile_VOID
    .byte >metaTile_VOID

    .byte >metaTile_EMIT_UP
    .byte >metaTile_EMIT_DOWN
    .byte >metaTile_EMIT_LEFT
    .byte >metaTile_EMIT_RIGHT
    .byte >metaTile_EMIT_UP
    .byte >metaTile_EMIT_DOWN
    .byte >metaTile_EMIT_LEFT
    .byte >metaTile_EMIT_RIGHT
    .byte >metaTile_RECEIVE_UP
    .byte >metaTile_RECEIVE_DOWN
    .byte >metaTile_RECEIVE_LEFT
    .byte >metaTile_RECEIVE_RIGHT
    .byte >metaTile_RECEIVE_UP
    .byte >metaTile_RECEIVE_DOWN
    .byte >metaTile_RECEIVE_LEFT
    .byte >metaTile_RECEIVE_RIGHT

    .byte >metaTile_MIRROR_UL
    .byte >metaTile_MIRROR_UR
    .byte >metaTile_MIRROR_CROSS1
    .byte >metaTile_MIRROR_CROSS2
    .byte >metaTile_MIRROR_UL
    .byte >metaTile_MIRROR_UR
    .byte >metaTile_MIRROR_DL
    .byte >metaTile_MIRROR_DR
    .byte >metaTile_MIRRORC_UL
    .byte >metaTile_MIRRORC_UR
    .byte >metaTile_MIRRORC_DL
    .byte >metaTile_MIRRORC_DR
    .byte >metaTile_TIMEWALL_OFF
    .byte >metaTile_TIMEWALL_ON
    .byte >metaTile_VOID
    .byte >metaTile_VOID

    .byte >metaTile_DOOR_H
    .byte >metaTile_DOOR_V
    .byte >metaTile_DOORL_H
    .byte >metaTile_DOORL_V
    .byte >metaTile_SPLITTER_H
    .byte >metaTile_SPLITTER_V
    .byte >metaTile_SPLITTER_H
    .byte >metaTile_SPLITTER_V
    .byte >metaTile_MERGER_H
    .byte >metaTile_MERGER_V
    .byte >metaTile_MERGER_H
    .byte >metaTile_MERGER_V
    .byte >metaTile_MERGER_H
    .byte >metaTile_MERGER_V
    .byte >metaTile_MERGER_H
    .byte >metaTile_MERGER_V



; Data
metaTile_VOID:          .byte $00, $00, $00, $00   ; VOID
metaTile_WALL:          .byte $50, $50, $40, $50   ; WALL
metaTile_GROUND:        .byte $5D, $00, $00, $5C   ; GROUND
metaTile_UI_BOT:        .byte $00, $00, $52, $52   ; UI_BOT
metaTile_LOCK:          .byte $05, $05, $05, $05   ; LOCK

metaTile_EMIT_UP:       .byte $42, $43, $44, $45   ; EMIT_UP
metaTile_EMIT_DOWN:     .byte $54, $55, $42, $43   ; EMIT_DOWN
metaTile_EMIT_LEFT:     .byte $52, $46, $53, $56   ; EMIT_LEFT
metaTile_EMIT_RIGHT:    .byte $47, $52, $57, $53   ; EMIT_RIGHT
metaTile_RECEIVE_UP:    .byte $42, $43, $48, $49   ; RECEIVE_UP
metaTile_RECEIVE_DOWN:  .byte $58, $59, $42, $43   ; RECEIVE_DOWN
metaTile_RECEIVE_LEFT:  .byte $52, $4A, $53, $5A   ; RECEIVE_LEFT
metaTile_RECEIVE_RIGHT: .byte $4B, $52, $5B, $53   ; RECEIVE_RIGHT

metaTile_LASER_HOR:     .byte $42, $43, $42, $43   ; LASER_HOR
metaTile_LASER_VER:     .byte $52, $52, $53, $53   ; LASER_VER
metaTile_LASER_CROSS:   .byte $60, $61, $70, $71   ; LASER_CROSS

metaTile_MIRROR_UL:     .byte $60, $67, $74, $7F   ; MIRROR_UL
metaTile_MIRROR_UR:     .byte $66, $61, $7E, $75   ; MIRROR_UR
metaTile_MIRROR_DL:     .byte $64, $6F, $70, $77   ; MIRROR_DL
metaTile_MIRROR_DR:     .byte $6E, $65, $76, $71   ; MIRROR_DR
metaTile_MIRROR_CROSS1: .byte $62, $61, $70, $73   ; MIRROR_CROSS1
metaTile_MIRROR_CROSS2: .byte $60, $63, $72, $71   ; MIRROR_CROSS2
metaTile_MIRRORC_UL:    .byte $60, $6D, $7A, $79   ; MIRRORC_UL
metaTile_MIRRORC_UR:    .byte $6C, $61, $78, $7B   ; MIRRORC_UR
metaTile_MIRRORC_DL:    .byte $6A, $69, $70, $7D   ; MIRRORC_DL
metaTile_MIRRORC_DR:    .byte $68, $6B, $7C, $71   ; MIRRORC_DR

metaTile_DOOR_H:        .byte $80, $81, $90, $91   ; DOOR_H
metaTile_DOOR_V:        .byte $82, $83, $92, $93   ; DOOR_V
metaTile_DOORL_H:       .byte $84, $85, $94, $95   ; DOORL_H
metaTile_DOORL_V:       .byte $86, $87, $96, $97   ; DOORL_V
metaTile_SPLITTER_H:    .byte $88, $89, $98, $99   ; SPLITTER_H
metaTile_SPLITTER_V:    .byte $8A, $8B, $9A, $9B   ; SPLITTER_V
metaTile_MERGER_H:      .byte $8C, $8D, $9C, $9D   ; MERGER_H
metaTile_MERGER_V:      .byte $8E, $8F, $9E, $9F   ; MERGER_V
metaTile_TIMEWALL_OFF:  .byte $A0, $A1, $B0, $B1   ; TIMEWALL_OFF
metaTile_TIMEWALL_ON:   .byte $A2, $A3, $B2, $B3   ; TIMEWALL_ON
