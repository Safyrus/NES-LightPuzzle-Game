stage_play_load:
    LDX #$00        ; Level 0
    STX level_index
    JSR drawLevel   ; Draw the level
    JSR loadLevel   ; Load the level into main memory

    LDA #60         ; Set level_MaxFrame
    STA level_MaxFrame

    LDX level_LaserCount    ; put a test laser
    LDA #$95                ; at Y=9 and X=5
    STA laserArray_pos, X   ;
    LDA #$00                ; and going up
    STA laserArray_meta, X  ;
    INX                     ;
    STX level_LaserCount    ;

    LDA #STG_PLAY   ; Change gameStage to Play
    STA gameStage

    LDA drawStates  ; tell the NMI to render background and sprites
    ORA #%00000011
    STA drawStates

    LDA #%00011110  ; Activate sprites and background and the left 8 pixels
    STA PPUMASK

    RTS
