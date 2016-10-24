; *******************************************************************
; PICkit 1 Lesson 1 - "Hello World"
;
; First lesson showing how to make an LED turn on.
;
; *******************************************************************
; *    See 44-pin Demo Board User's Guide for Lesson Information    *
; *******************************************************************

#include "prologue.inc"

Start:

     bsf       STATUS,RP0     ; select Register Bank 1
;     bcf       TRISD,TRISD0   ; make IO Pin RD0 an output
;     bcf       TRISD,TRISD2   ; make IO Pin RD2 an output
     movlw  b'10010101'
     movwf  TRISD   
     
     bcf       STATUS,RP0     ; back to Register Bank 0
     movlw   0xff
     movwf  PORTD   
;     bsf       PORTD,RD0     ; turn on LED RD0
;     bsf       PORTD,RD2      ; turn on LED RD2
     
     goto      $       		  ; Stop here...
; IMPORTANT SIDE NOTE:
; $ means the address of the present instruction that assembler knows
;   as it places the instructions in the memory. This assembler variable
;   can be used for some programming tricks that are not recommended to you.
;   Here it was left to show how the program can be forced to indefinetely
;   repeate the same goto. Despite the microcontroller is still running at
;   the clock speed, it will neither respond to any input changes (e.g., on
;   buttons that are pressed) nor change its outputs (e.g., connected to LEDs).
;   You can see this variable in some examples on the internet - that was the
;   reason not to change it here.
;   Please better use the following instruction that I
;   believe is much more understandable:
;		Stop	goto	Stop
;   (you can use any other label here if you wish - Finish etc)
;   This instruction is useful for programs that run from start to finish like 
;   most programs you used for introductory programming modules.
; END OF NOTE

; required by the end of file, still generates a warning
     end
     
