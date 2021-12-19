stage_level_load:
    LDX level_index

    JSR draw_level  ; Draw the level
    JSR load_level  ; Load the level into main memory
    JSR draw_ui     ; Draw the UI

    ; load background palettes
    LDX #$01
    LDY #$00
    JSR set_palette
    LDX level_palette
    LDY #$01
    JSR set_palette
    LDX level_palette+1
    LDY #$02
    JSR set_palette

    ; load sprite palettes
    LDX #$01
    LDY #$04
    JSR set_palette

    LDA #10         ; Set level_max_frame
    STA level_max_frame

    LDX #$00        ; reset laser count
    STX level_laser_count

    STX selected    ; reset selected object

    ; set attribute table
    LDY #$01
    LDX #$00
    @plt_loop:
        JSR change_attribute
        ;INY
        ;TYA
        ;AND #%00000011
        ;TAY
        INX
        CPX #$F0
        BNE @plt_loop
    @plt_loop_end:

    ; set cursor position
    LDA #$70
    STA curs_x
    STA curs_y

    LDA #STG::LEVEL_EDIT   ; Change game_stage to LevelEdit
    STA game_stage

    RTS
