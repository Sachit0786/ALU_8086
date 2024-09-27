; The location of this template is c:\emu8086\inc\0_com_template.txt

INCLUDE EMU8086.INC     ;Including Library

org 100h

.data       ;Data Segment

msg_intro db '  1. Addition', 0dh,0ah, '  2. Subtration', 0dh,0ah, '  3. Multiplication', 0dh,0ah, '  4. Division', 0dh,0ah, '  5. Negation', 0dh,0ah, '  6. OR', 0dh,0ah, '  7. AND ', 0dh,0ah, '  8. XOR', 0dh,0ah, '  9. Modulus',0dh,0ah, '  0. EXIT', '$'

msg_A db 'The SUM of two Numbers is = $', 0dh,0ah       ;Printing Strings
msg_S db 'The SUBTRACTION of two Numbers is = $', 0dh,0ah
msg_M db 'The MULTIPLICATION of two Numbers is = $', 0dh,0ah
msg_D db 'The DIVISION of two Numbers = $', 0dh,0ah 
msg_N db 'The NEG value of a Number = $', 0dh,0ah 
msg_OR db 'The OR operation of two Numbers = $', 0dh,0ah
msg_AND db 'The AND operation of two  Numbers = $', 0dh,0ah 
msg_XOR db 'The XOR operation of two Numbers = $', 0dh,0ah 
msg_MD db 'The MODULUS of Two Numbers = $', 0dh,0ah

cont db 10,13,'Do you want ALU to Calculate Again ? $'
bye db '            !!! Thank You !!!  :) **** $'
      
val1 dw ?       ;Uninitialize
val2 dw ?       ;Uninitialize  
res dw ?
agn dw ?

.code       ;Code Segment
MAIN PROC
    
MOV AX, @data
MOV DS, AX

Start:                  ;Start Lable

print '                  --- WORKING OF CALCULATOR ---    '  
printn      ;New Line

printn
MOV AH,9
MOV DX, OFFSET msg_intro
INT 21h                                          

printn
printn
print 'Select Any Option : '
CALL scan_num
printn
printn

CMP CX, 0
JE _Bye         ;Jumps to Exit Func if input is equal to 0             


CMP CX, 1
JE Addition     ;Jumps to Addition Func if input is equal to 1


CMP CX, 2
JE Subtraction     ;Jumps to Substraction Func if input is equal to 2
   
   
CMP CX, 3
JE Multiplication     ;Jumps to Multiplication Func if input is equal to 3


CMP CX, 4
JE Division     ;Jumps to Division Func if input is equal to 4


CMP CX, 5
JE Negation     ;Jumps to Absolute Func if input is equal to 5


CMP CX, 6
JE _OR       ;Jumps to _OR Func if input is equal to 6


CMP CX, 7
JE _AND       ;Jumps to _AND Func if input is equal to 7


CMP CX, 8
JE _XOR       ;Jumps to _XOR Func if input is equal to 8



CMP CX, 9
JE Modulus    ;Jumps to Modulus Func if input is equal to 9

                       ;FUNCTIONS

Addition:       ;Addition Function

print '     *--Addition Operation--*'
printn
printn
print 'Enter the First Number: '
CALL scan_num       ;First no. input
MOV val1, CX        ;Moving first no. to val1   

printn      ;New Line 

print 'Enter the Second Number: '
CALL scan_num       ;Second no. input
MOV val2, CX        ;Moving second no. to val2
printn

MOV AX, val1        ;Moving val1 to AX register
ADD AX, val2        ;Adding AX to val2
MOV res, AX         ;Storing AX in res as result

printn
MOV AH,9
MOV DX, OFFSET msg_A    ;Displaying Message
INT 21h                 ;Calling Interrupt

MOV AX, res             ;Moving res to AX
CALL print_num          ;Printing AX reg
                        
JMP Con                 ;Goes to Con Func               


Subtraction:        ;Subtraction Function

print '     *--Subtraction Operation--*'
printn
printn
print 'Enter the First Number: '
CALL scan_num       ;First no. input
MOV val1, CX        ;Moving first no. to val1   

printn      ;New Line 

print 'Enter the Second Number: '
CALL scan_num       ;Second no. input
MOV val2, CX        ;Moving second no. to val2
printn

MOV AX, val1        ;Moving val1 to AX reg
SUB AX, val2        ;Subtracting AX with val2
MOV res, AX         ;Storing AX in res as result

printn
MOV AH,9
MOV DX, OFFSET msg_S    ;Displaying Message
INT 21h                 ;Calling Interrupt

MOV AX, res             ;Moving res to AX
CALL print_num          ;Printing AX register

JMP Con                 ;Goes to Con Func             


Multiplication:        ;Multiplication Function

print '     *--Multiplication Operation--*'
printn  
printn
print 'Enter the First Number: '
CALL scan_num       ;First no. input
MOV val1, CX        ;Moving first no. to val1   

printn      ;New Line 

print 'Enter the Second Number: '
CALL scan_num       ;Second no. input
MOV val2, CX        ;Moving second no. to val2
printn

MOV AX, val1        ;Moving val1 to AX reg
MUL val2            ;Multiplying AX with val2
MOV res, AX         ;Storing AX in res as result

printn
MOV AH,9
MOV DX, OFFSET msg_M    ;Displaying Message
INT 21h                 ;Calling Interrupt

MOV AX, res             ;Moving res to AX
CALL print_num          ;Printing AX register

JMP Con                 ;Goes to Con Function


Division:        ;Division Function

print '     *--Division Operation--*' 
printn
printn
print 'Enter the First Number: '
CALL scan_num       ;First no. input
MOV val1, CX        ;Moving first no. to val1 
MOV AX, val1        ;Moving val1 to AX register  

printn      ;New Line 

print 'Enter the Second Number: '
CALL scan_num       ;Second no. input
MOV val2, CX        ;Moving second no. to val2    
MOV BX, val2
printn

CMP BX, 0      ;if divisor = 2 then 
JE Error        ;overflow

MOV DX, 0           ;Moving 0 in DX to avoid overflow

DIV BX            ;Dividing AX with val2
MOV res, AX         ;Storing AX in res

printn
MOV AH,9
MOV DX, OFFSET msg_D    ;Displaying Message
INT 21h                 ;Calling Interrupt

MOV AX, res             ;Moving res to AX
CALL print_num          ;Printing AX register

JMP Con                 ;Goes to Con Func


Negation:        ;Negation Function

print '     *--Negation Operation--*' 
printn
printn
print 'Enter Number: '
CALL scan_num       ;First no. input
MOV val1, CX        ;Moving first no. to val1   

printn      ;New Line 

MOV AX, val1        ;Moving val1 to AX register
NEG AX              ;Taking Neg of AX
MOV res, AX         ;Storing AX in res

printn
MOV AH,9
MOV DX, OFFSET msg_N    ;Displaying Message
INT 21h                 ;Calling Interrupt

MOV AX, res             ;Moving res to AX
CALL print_num          ;Printing AX register

JMP Con                 ;Goes to Con Function




_OR:            ;OR Function

print '     *--Binary OR--*'
printn
printn
print 'Enter the First Number: '
CALL scan_num       ;First no. input
MOV val1, CX        ;Moving first no. to val1   

printn      ;New Line 

print 'Enter the Second Number: '
CALL scan_num       ;Second no. input
MOV val2, CX        ;Moving second no. to val2
printn

MOV AX, val1
OR AX, val2
MOV res, AX

printn
MOV AH,9
MOV DX, OFFSET msg_OR    ;Displaying Message
INT 21h                 ;Calling Interrupt

MOV AX, res
CALL print_num          ;Prints result on screen

JMP Con


_AND:               ;AND Function

print '     *--Binary AND--*'
printn
printn
print 'Enter the First Number: '
CALL scan_num       ;First no. input
MOV val1, CX        ;Moving first no. to val1   

printn      ;New Line 

print 'Enter the Second Number: '
CALL scan_num       ;Second no. input
MOV val2, CX        ;Moving second no. to val2
printn

MOV AX, val1
AND AX, val2
MOV res, AX

printn
MOV AH,9
MOV DX, OFFSET msg_AND    ;Displaying Message
INT 21h                 ;Calling Interrupt

MOV AX, res
CALL print_num          ;Prints result on screen

JMP Con
 
 
_XOR:               ;XOR Function

print '     *--Binary XOR--*'
printn
printn
print 'Enter the First Number: '
CALL scan_num       ;First no. input
MOV val1, CX        ;Moving first no. to val1   

printn      ;New Line 

print 'Enter the Second Number: '
CALL scan_num       ;Second no. input
MOV val2, CX        ;Moving second no. to val2
printn

MOV AX, val1
XOR AX, val2
MOV res, AX

printn
MOV AH,9
MOV DX, OFFSET msg_XOR    ;Displaying Message
INT 21h                 ;Calling Interrupt

MOV AX, res
CALL print_num          ;Prints result on screen
                                
JMP Con
 


Modulus:

print '     *--Modulus Operation--*' 
printn
printn
print 'Enter the First Number: '
CALL scan_num       ;First no. input
MOV val1, CX        ;Moving first no. to val1 
MOV AX, val1        ;Moving val1 to AX reg  

printn      ;New Line 

print 'Enter the Second Number: '
CALL scan_num       ;Second no. input
MOV val2, CX        ;Moving second no. to val2    
MOV BX, val2
printn

MOV DX, 0           ;Moving 0 in DX to avoid overflow

DIV BX              ;Dividing AX with val2
MOV res, DX         ;Storing AX in res as result

printn
MOV AH,9
MOV DX, OFFSET msg_MD    ;Displaying Message
INT 21h                  ;Calling Interrupt

MOV AX, res             ;Moving res to AX
CALL print_num          ;Printing AX register

JMP Con                 ;Goes to Con Func


Error:    

printn
print 'Number Cannot be divided by 0. ' 
printn
print 'Undefined Math Error'
printn    
printn

JMP Division


Con:            ;Continue Functions
 
printn
MOV AH,9
MOV DX, OFFSET cont    ;Displaying Message
INT 21h                 ;Calling Interrupt
print '(Yes = 1 / No = 0) : '
CALL scan_num           ;Enter 1 for Yes and 0 for No
MOV agn, CX
printn
printn

CMP agn, 1
JE Start            ;Jumps to Start Func if input is equal to 1                    

CMP agn, 0
JE _Bye             ;Jumps to Bye Func if input is equal to 0
printn


_Bye:       ;EXIT Function

printn
printn
MOV AH,9
MOV DX, OFFSET bye    ;Displaying Message
INT 21h                        


MAIN ENDP        


DEFINE_SCAN_NUM
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS


END main

HLT         ;Halting the function                                            
ret         ;Return
