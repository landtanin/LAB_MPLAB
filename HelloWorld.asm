; *******************************************************************
; PICkit 1 Lesson 1 - "Hello World"
;
; First lesson showing how to make an LED turn on.
;
; *******************************************************************
; *    See 44-pin Demo Board User's Guide for Lesson Information    *
; *******************************************************************

;#include "prologue.inc"
;
;Start:
;
;     bsf       STATUS,RP0     ; select Register Bank 1
;     
;;     exercise 1
;;     bcf       TRISD,TRISD0   ; make IO Pin RD0 an output
;;     bcf       TRISD,TRISD2   ; make IO Pin RD2 an output
;     
;;    exercise 3
;;     movlw  b'10010101'
;;     movwf  TRISD   
;     
;;     exercise 2
;     movlw b'00000000'
;     movwf TRISD
;     
;     bcf       STATUS,RP0     ; back to Register Bank 0
;     
;;     exercise 2
;     movlw 0xff
;     movwf PORTD
;     
;;    exercise 3
;;     movlw   0xff
;;     movwf  PORTD   
;
;;     exercise 1
;;     bsf       PORTD,RD0     ; turn on LED RD0
;;     bsf       PORTD,RD1      ; turn on LED RD2
;;     bsf       PORTD,RD2      ; turn on LED RD2
;;     bsf       PORTD,RD3      ; turn on LED RD2
;;     
;     goto      $       		  ; Stop here...
;; IMPORTANT SIDE NOTE:
;; $ means the address of the present instruction that assembler knows
;;   as it places the instructions in the memory. This assembler variable
;;   can be used for some programming tricks that are not recommended to you.
;;   Here it was left to show how the program can be forced to indefinetely
;;   repeate the same goto. Despite the microcontroller is still running at
;;   the clock speed, it will neither respond to any input changes (e.g., on
;;   buttons that are pressed) nor change its outputs (e.g., connected to LEDs).
;;   You can see this variable in some examples on the internet - that was the
;;   reason not to change it here.
;;   Please better use the following instruction that I
;;   believe is much more understandable:
;;		Stop	goto	Stop
;;   (you can use any other label here if you wish - Finish etc)
;;   This instruction is useful for programs that run from start to finish like 
;;   most programs you used for introductory programming modules.
;; END OF NOTE
;
;; required by the end of file, still generates a warning
;     end
;    
    
; -------------------------------- lesson3 -----------------------------------------

    #include "prologue.inc"

     cblock 0x20
Delay1           ; Assign an address to label Delay1
Delay2
Display          ; define a variable to hold the diplay
     endc
     
Start:

;------------------------------------------------------------
;* normal and exercise 1 initialisation
;     bsf       STATUS,RP0     ; select Register Bank 1
;     clrf      TRISD          ; make IO PortD all output
;     bcf       STATUS,RP0     ; back to Register Bank 0
;     movlw     0x80
;     movwf     Display		  ; switch on LD7 at the start
     
 ;* exercise 2 initialisation
     bsf       STATUS,RP0     ; select Register Bank 1
     bcf       TRISD, TRISD0  ; make IO PortD all output
     bcf       TRISD, TRISD1  ; make IO PortD all output
     bcf       TRISD, TRISD2  ; make IO PortD all output
     bcf       TRISD, TRISD3  ; make IO PortD all output
     bcf       STATUS,RP0     ; back to Register Bank 0
     movlw     0x00
     movwf     Display		  ; switch on LD7 at the start

;------------------------;------------------------------------
;* superloop - do forever
MainLoop:

     movf      Display,w      ; Copy the display to the LEDs
     movwf     PORTD	      ; '1000 0000' for normal and exercise 1

; delay
OndelayLoop:
     decfsz    Delay1,f       ; Waste time.  
     goto      OndelayLoop    ; The Inner loop takes 3 instructions per loop * 256 loopss = 768 instructions
     decfsz    Delay2,f       ; The outer loop takes and additional 3 instructions per lap * 256 loops
     goto      OndelayLoop    ; (768+3) * 256 = 197376 instructions / 1M instructions per second = 0.197 sec.
                              ; call it two-tenths of a second.

;----------------------choose normal, exercise 1, exercise 2---------------------------------------			      
			      
			      
;; Normal: switch on the next LED on the right     
;     bcf       STATUS,C       ; ensure the carry bit is clear
;     rrf       Display,f
;     
;; if it was the rightmost LED (LD0), switch on LD7
;     btfsc     STATUS,C       ; Did the bit rotate into the carry?
;     bsf       Display,RD7    ; yes, put it into bit 7.
     
;-------------------------------------------------------------
     
;; exercise 1, rotate left
;     bcf       STATUS,C       ; ensure the carry bit is clear
;     rlf       Display,f
;     
;; if it was the leftmost LED (LD7), switch on LD0
;     btfsc     STATUS,C       ; Did the bit rotate into the carry?
;     bsf       Display,RD0    ; yes, put it into bit 0.

;-------------------------------------------------------------
     
; exercise 2, rotate left
     bcf       STATUS,C       ; ensure the carry bit is clear
     rlf       Display,f
     
; if it was the leftmost LED (LD3), switch on LD0
     btfsc     STATUS,C       ; Did the bit rotate into the carry?
     bsf       Display,RD0    ; yes, put it into bit 0.

;-------------------------------------------------------------
     goto      MainLoop
;* end of the superloop
;------------------------------------------------------------
     end