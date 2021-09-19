IRQ:
    PHA     ; back up registers
    TXA
    PHA
    TYA
    PHA

    LDA APU_STATUS

    PLA     ; restore regs
    TAY
    PLA
    TAX
    PLA
    
    RTI     ; Return
