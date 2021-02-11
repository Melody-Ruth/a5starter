        // CES30 FP2float assignment template
        // 
        // Your name:
        // your pid:
        //
        // Describe target Hardware to the assembler
        .arch   armv6
        .cpu    cortex-a53
        .syntax unified
        /////////////////////////////////////////////////////////

        .text                       // start of the text segment
        /////////////////////////////////////////////////////////
        // function FP2float
        /////////////////////////////////////////////////////////
        .type   FP2float, %function // define as a function
        .global FP2float            // export function name
        .equ    FP_OFF_FP2, 28      // (regs - 1) * 4
        /////////////////////////////////////////////////////////

        // put any .equ for FP2float here - delete this line

        /////////////////////////////////////////////////////////
FP2float:
        push    {r4-r9, fp, lr}     // use r4-r9 protected regs
        add     fp, sp, FP_OFF_FP2  // locate our frame pointer
        // do not edit the prologue above
        // You can use temporary r0-r3 and preserved r4-r9
        // Store return value (results) in r0
        /////////////////////////////////////////////////////////

        // put your code for FP2float here - delete this line

        /////////////////////////////////////////////////////////
        // do not edit the epilogue below
        sub     sp, fp, FP_OFF_FP2  // restore sp
        pop     {r4-r9,fp, lr}      // restore saved registers
        bx      lr                  // function return 
        .size   FP2float,(. - FP2float)

        /////////////////////////////////////////////////////////
        // function zeroFP2float
        /////////////////////////////////////////////////////////
        .type   zeroFP2float, %function // define as a function
        .global FP2float                // export function name
        .equ    FP_OFF_ZER, 4           // (regs - 1) * 4
        /////////////////////////////////////////////////////////

        // put any .equ for zeroFP2float here - delete this line

        /////////////////////////////////////////////////////////
zeroFP2float:
        push    {fp, lr}            // 
        add     fp, sp, FP_OFF_ZER  // locate our frame pointer
        // do not edit the prologue above
        // You can use temporary registers r0-r3
        // Store return value (results) in r0
        /////////////////////////////////////////////////////////

        // put your code for zeroFP2float here - delete this line

        /////////////////////////////////////////////////////////
        // do not edit the epilogue below
        sub     sp, fp, FP_OFF_ZER  // restore sp
        pop     {fp, lr}            // restore saved registers
        bx      lr                  // function return
        .size   zeroFP2float,(. - zeroFP2float)

.end
