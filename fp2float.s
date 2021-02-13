        // CES30 FP2float assignment template
        // 
        // Your name: Melody Ruth
        // your pid: A16216002
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

        //r1 = mantissa, r2 = exponent, r3 = sign, r4 = temp

        //Test for +0/-0:
        LSL r4, r0, #25          //temp = input << 9 (Shift the sign bit off)
        CMP r4, #0              //If (temp == 0) {
        //(the mantissa and exponent were both 0)
        BNE NotZero             //.
        BL zeroFP2float         //      zeroFP2float();
        B Done                  //} else {

        NotZero:

        //Parse 8 bit floating point:
        
        //Mask non-mantissa bits:
        AND r1, r0, #15         //      mantissa = input & 15 (15 = 1111 in binary)

        //Mask non-exponent bits:
        AND r2, r0, #112        //      exponent = input & 112 (112 = 111000 in binary)
        LSR r2, r2, #4          //      exponent = exponent >> 4
        //(Shift so the exponent bits will be all the way on the right)
        //(arithmetic versus logical shouldn't matter since far left bit is 0)
        //Don't deal with bias yet since negatives would complicate things

        //Mask non-sign bits:
        AND r3, r0, #128        //      sign = input & 128 (128 = 10000000 in binary)
        LSR r3, r3, #7          //      sign = sign >> 7
        //(Shift so the sign bit will be all the way on the right)
        //(logical since we want the rest of the bits to be 0)

        //Create 32 bit floating point:

        //Adjust exponent bias:
        ADD r2, r2, #124        //      exponent += 124
        //(127 - 3 = 124)

        CMP r2, #124            //      if (exponent == 124) { (means 0 before adjusting bias)
        BNE NormalStuff
        //We have a denormal number
        ADD r2, r2, #1          //              exponent++;
        //(The exponent was slightly off since it was 2^-2 not 2^-3)
        loop:                   //              do {
        LSL r1, r1, #1          //                      mantissa = mantissa << 1;
        SUB r2, r2, #1          //                      exponent--;
        CMP r1, #16             //              } while (r1 < 16)
        BLT loop                //              .
        BIC r1, r1, #16         //              exponent = exponenet & ~16 (remove bit at 16)

        NormalStuff:            //      }

        //Set up mantissa:
        LSL r1, r1, #19         //      mantissa = mantissa << 19
        //(Puts far left of mantissa at far left of mantissa section in 32 bit fp)

        //Set up exponent:
        LSL r2, r2, #23         //      exponent = exponent << 23
        //(shift far right of exponent to far right of exponent section)

        //Set up sign:
        LSL r3, r3, #31         //      sign = sign << 31
        //(shift sign bit to 32 bit sign spot)

        //Put it all together:
        ORR r0, r1, r2          //      result = mantissa | exponent
        ORR r0, r0, r3          //      result = result | sign

        Done:                   //}

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

        LSL r0, r0, #24                  //output = input << 24 (shift sign bit over)

        /////////////////////////////////////////////////////////
        // do not edit the epilogue below
        sub     sp, fp, FP_OFF_ZER  // restore sp
        pop     {fp, lr}            // restore saved registers
        bx      lr                  // function return
        .size   zeroFP2float,(. - zeroFP2float)

.end
