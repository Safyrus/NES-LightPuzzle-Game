stage_level_load:
    LDX #$00        ; Level 0
    STX level_index
    JSR draw_level  ; Draw the level
    JSR load_level  ; Load the level into main memory

    LDA #30         ; Set level_MaxFrame
    STA level_MaxFrame

    LDX #$00
    STX level_LaserCount

    JSR level_place_lasers
    
    LDA #$70
    STA cursX
    STA cursY

    bit PPUSTATUS   ; reset adress latch
    LDA #$20        ; set the vram address to start from
    STA PPUADDR
    LDA #$50
    STA PPUADDR

    LDX #$00
    @text:
        LDA txt_pressplay, X
        STA PPUDATA
        INX

        CPX #$0D
        BNE @text


    LDA #STG::LEVEL_EDIT   ; Change gameStage to LevelEdit
    STA gameStage

    LDA drawStates  ; tell the NMI to render background and sprites
    ORA #%00000011
    STA drawStates

    LDA #%00011110  ; Activate sprites and background and the left 8 pixels
    STA PPUMASK

    RTS
