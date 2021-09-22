IRQ:
    pushreg

    LDA APU_STATUS

    pullreg    
    RTI     ; Return
