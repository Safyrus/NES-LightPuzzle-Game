; Y = pos
add_laser_up:
    PHA
    TXA
    PHA

    LDX #$00
    JSR add_laser

    PLA
    TAX
    PLA
    RTS


; Y = pos
add_laser_down:
    PHA
    TXA
    PHA

    LDX #$01
    JSR add_laser

    PLA
    TAX
    PLA
    RTS

; Y = pos
add_laser_left:
    PHA
    TXA
    PHA

    LDX #$02
    JSR add_laser

    PLA
    TAX
    PLA
    RTS

; Y = pos
add_laser_right:
    PHA
    TXA
    PHA

    LDX #$03
    JSR add_laser

    PLA
    TAX
    PLA
    RTS


; Y = pos
; X = direction
add_laser:
    pushreg

    ; save X
    TXA
    PHA

    ; change metatile palette
    TYA
    TAX
    LDY #$02
    JSR change_attribute
    TXA
    TAY

    ; add a laser at Y with the direction pull from stack (old X value)
    LDX level_laser_count
    TYA
    STA laser_array_pos, X
    PLA
    STA laser_array_state, X

    ; increment laser count
    INX
    STX level_laser_count

    pullreg
    RTS