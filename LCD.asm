#include "p16F628a.inc"    
 __CONFIG _FOSC_INTOSCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_ON & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF    

RES_VECT  CODE    0x0000            ; processor reset vector
    
    BCF PORTA,0		;reset
    MOVLW 0x01
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
  
    GOTO    START                   ; go to beginning of program
; TODO ADD INTERRUPTS HERE IF USED
MAIN_PROG CODE                      ; let linker place main program

i EQU 0x20
j EQU 0x21

l equ 0x30
n equ 0x31
k equ 0x32
m equ 0x33
 
s equ 0x34
r equ 0x35 
a equ 0x36
START
    MOVLW 0x07
    MOVWF CMCON
    BCF STATUS, RP1
    BSF STATUS, RP0 
    CLRF TRISB
    CLRF TRISA
    BCF STATUS, RP0
    
    BCF PORTA,1
    BCF PORTA,0
    
INITLCD
    BCF PORTA,0		;reset
    MOVLW 0x01
    MOVWF PORTB
    
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
    
    MOVLW 0x0C		;first line
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
         
    MOVLW 0x3C		;cursor mode
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
    
    
INICIO
    MOVLW b'10010000'		;LCD position
    MOVWF s
    MOVLW s
    MOVWF PORTB
    MOVLW b'11010000'		;LCD position
    MOVWF r
    MOVLW b'10000'		;LCD position
    MOVWF a
INICIO_PROG
    BCF PORTA,0		;command mode
    CALL time
   
    DECF s,0
    MOVWF PORTB
    MOVWF s
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    call Nombre
    
    call tiempo
    
    ;call Limpiar
        
    GOTO INICIO_PROG

exec

    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
    RETURN
    
time
    CLRF i
    MOVLW d'10'
    MOVWF j
ciclo    
    MOVLW d'80'
    MOVWF i
    DECFSZ i
    GOTO $-1
    DECFSZ j
    GOTO ciclo
    RETURN

Limpiar:
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x01		;reset
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    return
   
    
Nombre: 
    
    MOVLW 'S'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'a'
    MOVWF PORTB
    CALL exec
   
    MOVLW 'r'
    MOVWF PORTB
    CALL exec

    MOVLW 'a'
    MOVWF PORTB
    CALL exec
    
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    
    MOVLW 'R'
    MOVWF PORTB
    CALL exec
   
    MOVLW 'o'
    MOVWF PORTB
    CALL exec

    MOVLW 'd'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'r'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'i'
    MOVWF PORTB
    CALL exec
   
    MOVLW 'g'
    MOVWF PORTB
    CALL exec

    MOVLW 'u'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'e'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'z'
    MOVWF PORTB
    CALL exec
    
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    
    MOVLW 'G'
    MOVWF PORTB
    CALL exec
   
    BCF PORTA,0		;command mode
    CALL time
    
    DECF r,0
    MOVWF PORTB
    MOVWF r
    CALL exec
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW 'M'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'I'
    MOVWF PORTB
    CALL exec
   
    MOVLW 'C'
    MOVWF PORTB
    CALL exec

    MOVLW 'R'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'O'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'S'
    MOVWF PORTB
    CALL exec
   
    MOVLW ' '
    MOVWF PORTB
    CALL exec

    MOVLW ' '
    MOVWF PORTB
    CALL exec
    
    MOVLW 'M'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'C'
    MOVWF PORTB
    CALL exec
   
    MOVLW 'T'
    MOVWF PORTB
    CALL exec

    MOVLW ' '
    MOVWF PORTB
    CALL exec
    
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    
    MOVLW '7'
    MOVWF PORTB
    CALL exec
    
    MOVLW '0'
    MOVWF PORTB
    CALL exec
    
    MOVLW '0'
    MOVWF PORTB
    CALL exec
    
    call CHECK
    
    
    return
    
CHECK:
    DECFSZ a,1
    RETURN
    GOTO $
    
tiempo:
nop
    NOP
movlw d'25' ;establecer valor de la variable k
movwf m
mloop:
decfsz m,f
goto mloop
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
movlw d'25' ;establecer valor de la variable i
movwf l
iloop:
nop ;NOPs de relleno (ajuste de tiempo)

 movlw d'35' ;establecer valor de la variable j
movwf n
jloop:
nop ;NOPs de relleno (ajuste de tiempo)
movlw d'80' ;establecer valor de la variable k
movwf k
kloop:
decfsz k,f
goto kloop
decfsz n,f
goto jloop
decfsz l,f
goto iloop
return
			
    END