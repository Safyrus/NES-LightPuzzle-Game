;
readjoy:
    LDA #$01
    STA JOYPAD1
    STA buttons2  ; player 2's buttons double as a ring counter
    LSR A         ; now A is 0
    STA JOYPAD1
    loop:
        LDA JOYPAD1
        AND #%00000011  ; ignore bits other than controller
        CMP #$01        ; Set carry if and only if nonzero
        ROL buttons1    ; Carry -> bit 0; bit 7 -> Carry
        LDA JOYPAD2     ; Repeat
        AND #%00000011
        CMP #$01
        ROL buttons2    ; Carry -> bit 0; bit 7 -> Carry
        BCC loop
    RTS
