stage_play_load:
    LDX #$00        ; Level 0
    STX level_index
    JSR drawLevel   ; Draw the level
    JSR loadLevel   ; Load the level into main memory

    LDA #30         ; Set level_MaxFrame
    STA level_MaxFrame

    LDX #$00
    STX level_LaserCount
    LDX level_LaserCount    ; put a test laser
    LDA #$95                ; at Y=9 and X=5
    STA laserArray_pos, X   ;
    LDA #$00                ; and going up
    STA laserArray_state, X  ;
    INX                     ;
    STX level_LaserCount    ;

    LDX level_LaserCount    ; put a test laser
    LDA #$35                ; at Y=3 and X=5
    STA laserArray_pos, X   ;
    LDA #$01                ; and going down
    STA laserArray_state, X  ;
    INX                     ;
    STX level_LaserCount    ;

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


    LDA #STG_PLAY   ; Change gameStage to Play
    STA gameStage

    LDA drawStates  ; tell the NMI to render background and sprites
    ORA #%00000011
    STA drawStates

    LDA #%00011110  ; Activate sprites and background and the left 8 pixels
    STA PPUMASK

    RTS
