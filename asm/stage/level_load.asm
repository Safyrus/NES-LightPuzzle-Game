stage_level_load:
    LDX #$00        ; Level 0
    STX level_index
    JSR draw_level  ; Draw the level
    JSR load_level  ; Load the level into main memory

    ; load background palettes
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

    LDA #30         ; Set level_MaxFrame
    STA level_MaxFrame

    LDX #$00        ; reset laser count
    STX level_LaserCount

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
    STA cursX
    STA cursY

    bit PPUSTATUS   ; reset adress latch
    LDA #$20        ; set the vram address to start from
    STA PPUADDR
    LDA #$50
    STA PPUADDR

    ; display txt_pressplay
    LDX #$00
    @text:
        LDA txt_pressplay, X
        STA PPUDATA
        INX

        CPX #$0D
        BNE @text

    LDA #STG::LEVEL_EDIT   ; Change gameStage to LevelEdit
    STA gameStage

    RTS
