.MODEL SMALL

.DATA
    welcomeMsg DB "Welcome to the guessing game!", 0Ah, "$"
    promptMsg DB "Guess a number between 0 and 9: ", "$"
    tooLowMsg DB 0Ah, "Too low! Try again.", "$"
    tooHighMsg DB 0Ah, "Too high! Try again.", "$"
    correctMsg DB 0Ah, "Congratulations! You guessed it right.", "$"
    randomNum DW ?

.CODE
MAIN PROC
    .STARTUP

    
    ; Generate random number using milliseconds modulo 10
    MOV AH, 2Ch  ; Get system time
    INT 21h
    MOV DH, 0    
    MOV AX, DX  
    MOV DX, 0    ; Clear DX for division
    MOV WORD PTR BX, 10
    DIV BX   ; Divide AX by 10, remainder in DX
    MOV randomNum, DX  ; Store remainder (modulo 10) as random number

    ; Display welcome message
    MOV AH, 9
    LEA DX, welcomeMsg
    INT 21h

GUESS_LOOP:
    MOV AH, 9
    LEA DX, promptMsg
    INT 21h

    ; Get user's guess
    MOV AH, 1
    INT 21h
    SUB AL, '0'  ; Convert ASCII digit to numeric value
    MOV AH, 0

    ; Compare guess with random number
    CMP AX, randomNum
    JE CORRECT
    JB TOO_LOW

TOO_HIGH:
    MOV AH, 9
    LEA DX, tooHighMsg
    INT 21h
    JMP GUESS_LOOP

TOO_LOW:
    MOV AH, 9
    LEA DX, tooLowMsg
    INT 21h
    JMP GUESS_LOOP

CORRECT:
    MOV AH, 9
    LEA DX, correctMsg
    INT 21h

    .EXIT
MAIN ENDP
END MAIN
