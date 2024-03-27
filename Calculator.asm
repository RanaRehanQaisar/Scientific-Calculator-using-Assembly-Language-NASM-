[org 0x0100]
jmp start
;We have declared our variables here.
;Whatever operation you perform, the result will always be saved in "total".
total: dw 0
;|***|Change the value of codeDriver to whatever arithmetic operation you want to perform,
;|*1*|For Sum, set codeDriver to 0.
;|*3*|For Subtraction, set codeDriver to 1.
;|*4*|For Product, set codeDriver to 2.
;|*5*|For Modulus, set codeDriver to 3.
;|*6*|For Power, set codeDriver to 4.
;|*7*|For Average of numbers, set codeDriver to 5.
;|*8*|For Percentage out of 100, set codeDriver to 6.
;|*7*|For Quick Multiplication by 2, set codeDriver to 7.
codeDriver: dw 1
;|***|"num1" and "num2" are the numbers which you will use.
;|***|Go ahead and assign values to the following variables.
num1: dw 2
num2: dw 2

;for percentage we need some extra variable 
;in num1 will be the total amount will be stored 
;in num2 obtain amount will be stored 
;in total percentage will be stored 
;in answer num2 * 100 will be stored 
answer: dw 0

;are the subroutines, which the code will 
;automatically use by checking the "codeDriver".
sum:
        add     ax, bx
        ret
subtract:
        sub     ax, bx
        ret
product:
        imul    ax, bx
        ret
division:
        div     bx
        ret
modulus:
        div     bx
        mov     ax, dx
        ret
power:
        mov     cx,bx
        mov     dx,ax
        Powerloop:
        imul    ax,dx
        dec     cx
        jnz     Powerloop
        ret
average:
        add     ax,bx
        mov     bx,2
        div     bx
        ret
percentage:
        ;multiply obtained with 100
        mov     dx , 0
        mov     ax , [num2] ;obtain value 
        mov     bx , 100
        mul     bx
        mov     [answer] , ax
        ;divide answer by total
        mov     dx , 0
        mov     ax , [answer]
        mov     bx , [num1] ;total value 
        div     bx
        ret
SHL_2:
        shl     ax , 1
        ret 

start:
    xor ax,ax
    xor bx,bx
    xor cx,cx
    xor dx,dx
    xor si,si

        mov     ax, [num1]
        mov     bx, [num2]

        cmp     word[codeDriver], 0
        jne     subFragment
        call    sum
        mov     [total], ax
        jmp     end
subFragment:
        cmp     word[codeDriver], 1
        jne     productFragment
        call    subtract
        mov     [total], ax
        jmp     end
productFragment:
        cmp     word[codeDriver], 2
        jne     divisionFragment
        call    product
        mov     [total], ax
        jmp     end
divisionFragment:
        cmp     word[codeDriver], 3
        jne     modulusFragment
        call    division
        mov     [total], ax
        jmp     end
modulusFragment:
        cmp     word[codeDriver], 4
        jne     powerFragment
        call    modulus
        mov     [total], ax
        jmp     end
powerFragment:
        cmp     word[codeDriver], 5
        jne     averageFragment
        call    power
        mov     [total], ax
        jmp     end
averageFragment:
        cmp     word[codeDriver],6
        jne     percentageFragment
        call    average
        mov    [total],ax
        jmp     end
percentageFragment:
        cmp     word[codeDriver],7
        jne     SHL_2_fragment
        call    percentage
        mov     [total],al
        jmp     end
SHL_2_fragment:
        cmp     word[codeDriver],8
        jne     end
        call    SHL_2
        mov     [total],ax
        jmp     end

end:
        mov     ax,0x4c00
        int     0x21