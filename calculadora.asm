.data

msg: .asciiz "PROJETO - CALCULADORA\n"
aluno: .asciiz "Autor: Luiz Gustavo Erthal\n"
ver: .asciiz "Ver. 1.0\n"

menu: .asciiz "\nPara prosseguir, digite o número da opção\n"
menu1: .asciiz "1. Exibir Acumulador\n"
menu2: .asciiz "2. Zerar Acumulador\n"
menu3: .asciiz "3. Realizar Soma\n"
menu4: .asciiz "4. Realizar Subtracao\n"
menu5: .asciiz "5. Realizar Divisao\n"
menu6: .asciiz "6. Realizar Multiplicacao\n"
menu7: .asciiz "7. Encerrar calculadora\n"

opt1: .asciiz "-- SOMA --\n"
opt2: .asciiz "-- SUBTRACAO --\n"
opt3: .asciiz "-- DIVISAO --\n"
opt4: .asciiz "-- MULTIPLICACAO\n"
num1: .asciiz "Digite o primeiro numero\n"
num2: .asciiz "Digite o segundo numero\n"
num3: .asciiz "Digite o número\n"

res: .asciiz "RESULTADO: \n"
enc: .asciiz "ENCERRADO"
acm: .asciiz "ACUMULADOR: \n"
zero: .asciiz "ACUMULADOR ZERADO\n"
number: .double 0.0

.text

# CABECALHO

	li $v0, 4
	la $a0, msg
	syscall
	
	li $v0, 4
	la $a0, aluno
	syscall
	
	li $v0, 4
	la $a0, ver
	syscall
	
# MENU

calc:

	li $v0, 4
	la $a0, menu
	syscall
	
	li $v0, 4
	la $a0, menu1
	syscall
	
	li $v0, 4
	la $a0, menu2
	syscall
	
	li $v0, 4
	la $a0, menu3
	syscall
	
	li $v0, 4
	la $a0, menu4
	syscall
	
	li $v0, 4
	la $a0, menu5
	syscall
	
	li $v0, 4
	la $a0, menu6
	syscall
	
	li $v0, 4
	la $a0, menu7
	syscall
	
# USUARIO DIGITA OPCAO

	li $v0, 5
	syscall

# JUMPERS PARA OPCOES

	beq $v0, 1, acumulador
	beq $v0, 2, zerar
	beq $v0, 3, Soma
	beq $v0, 4, Sub
	beq $v0, 5, Div
	beq $v0, 6, Mul
	beq $v0, 7, Enc
	
acumulador:

# Printa o titulo

	li $v0, 4
	la $a0, acm
	syscall
	
# Printa o valor do acumulador

	li $v0, 3
	mov.d $f12, $f12
	syscall
	
	j calc

zerar:

# Printa Titulo
	li $v0, 4
	la $a0, zero
	syscall
	
# Multiplica o acumulador por zero

	mul.d $f12, $f12 $f8
	
	j calc

Soma:

# Verifica se o acumulador está zerado
# Carrega o valor zero para $f14, compara se o acumulador é igual a ele. Se for (True = 0, False = 1), caso verdade, ele da um jump.

	ldc1  $f14, number
	mul.d $f0, $f14, $f12
	c.eq.d $f12, $f0
	bc1t  SomaZero
	
# Se o acumulador for diferente de zero, continua daqui
# Printa mensagem de número

	li $v0, 4
	la $a0, num3
	syscall
	
	li $v0, 7
	syscall
	
	mov.d $f4, $f0

# Realiza soma do acumulador com o novo numero. acumulador = acumulador + $f4
	
	add.d $f12, $f12, $f4
	
	li $v0, 4
	la $a0, res
	syscall
	
	li $v0, 3
	mov.d $f12, $f12
	syscall
	
	j calc
	
# Se o acumulador estiver zerado, inicia daqui
SomaZero:

# Printa o titulo
	li $v0, 4
	la $a0, opt1
	syscall
	
# Printa número 1
	li $v0, 4
	la $a0, num1
	syscall
	
	li $v0, 7
	syscall
	
	mov.d $f4, $f0

# Printa número 2

	li $v0, 4
	la $a0, num2
	syscall
	
	li $v0, 7
	syscall
	
	mov.d $f6, $f0
	
# num1 = num1 + num2

	add.d $f4, $f4, $f6
	
# Printa resultado

	li $v0, 4
	la $a0, res
	syscall
	
	li $v0, 3
	mov.d $f12, $f4
	syscall
	
	j calc
	
Sub:
# Verifica se o acumulador está zerado
# Carrega o valor zero para $f14, compara se o acumulador é igual a ele. Se for (True = 0, False = 1), caso verdade, ele da um jump.

	ldc1  $f14, number
	mul.d $f0, $f14, $f12
	c.eq.d $f12, $f0
	bc1t  SubZero
	
# Se o acumulador for diferente de zero, continua daqui
# Printa mensagem de número

	li $v0, 4
	la $a0, num3
	syscall
	
	li $v0, 7
	syscall
	
	mov.d $f4, $f0

# Realiza subtracao do acumulador com o novo numero. acumulador = acumulador - $f4
	
	sub.d $f12, $f12, $f4
	
	li $v0, 4
	la $a0, res
	syscall
	
	li $v0, 3
	mov.d $f12, $f12
	syscall
	
	j calc
	
SubZero:
# Se o acumulador estiver zerado, inicia daqui
# Printa o titulo

	li $v0, 4
	la $a0, opt2
	syscall
	
# Printa número 1

	li $v0, 4
	la $a0, num1
	syscall
	
	li $v0, 7
	syscall
	
	mov.d $f4, $f0

# Printa número 2

	li $v0, 4
	la $a0, num2
	syscall
	
	li $v0, 7
	syscall
	
	mov.d $f6, $f0
	
# num1 = num1 - num2

	sub.d $f4, $f4, $f6
	
# Printa resultado

	li $v0, 4
	la $a0, res
	syscall
	
	li $v0, 3
	mov.d $f12, $f4
	syscall
	
	j calc
	
Div:
# Verifica se o acumulador está zerado
# Carrega o valor zero para $f14, compara se o acumulador é igual a ele. Se for (True = 0, False = 1), caso verdade, ele da um jump.

	ldc1  $f14, number
	mul.d $f0, $f14, $f12
	c.eq.d $f12, $f0
	bc1t  DivZero
	
# Se o acumulador for diferente de zero, continua daqui
# Printa mensagem de número

	li $v0, 4
	la $a0, num3
	syscall
	
	li $v0, 7
	syscall
	
	mov.d $f4, $f0

# Realiza soma do acumulador com o novo numero. acumulador = acumulador / $f4
	
	div.d $f12, $f12, $f4
	
	li $v0, 4
	la $a0, res
	syscall
	
	li $v0, 3
	mov.d $f12, $f12
	syscall
	
	j calc
	
DivZero:
# Se o acumulador estiver zerado, inicia daqui
# Printa o titulo

	li $v0, 4
	la $a0, opt3
	syscall
	
# Printa número 1

	li $v0, 4
	la $a0, num1
	syscall
	
	li $v0, 7
	syscall
	
	mov.d $f4, $f0

# Printa número 2

	li $v0, 4
	la $a0, num2
	syscall
	
	li $v0, 7
	syscall
	
	mov.d $f6, $f0
	
# num1 = num1 / num2

	div.d $f4, $f4, $f6
	
# Printa resultado

	li $v0, 4
	la $a0, res
	syscall
	
	li $v0, 3
	mov.d $f12, $f4
	syscall
	
	j calc
Mul:
# Verifica se o acumulador está zerado
# Carrega o valor zero para $f14, compara se o acumulador é igual a ele. Se for (True = 0, False = 1), caso verdade, ele da um jump.

	ldc1  $f14, number
	mul.d $f0, $f14, $f12
	c.eq.d $f12, $f0
	bc1t  MulZero
	
# Se o acumulador for diferente de zero, continua daqui
# Printa mensagem de número

	li $v0, 4
	la $a0, num3
	syscall
	
	li $v0, 7
	syscall
	
	mov.d $f4, $f0

# Realiza soma do acumulador com o novo numero. acumulador = acumulador * $f4
	
	mul.d $f12, $f12, $f4
	
	li $v0, 4
	la $a0, res
	syscall
	
	li $v0, 3
	mov.d $f12, $f12
	syscall
	
	j calc
	
MulZero:
# Se o acumulador estiver zerado, inicia daqui
# Printa o titulo

	li $v0, 4
	la $a0, opt4
	syscall
	
# Printa número 1

	li $v0, 4
	la $a0, num1
	syscall
	
	li $v0, 7
	syscall
	
	mov.d $f4, $f0

# Printa número 2

	li $v0, 4
	la $a0, num2
	syscall
	
	li $v0, 7
	syscall
	
	mov.d $f6, $f0
	
# num1 = num1 * num2

	mul.d $f4, $f4, $f6
	
# Printa resultado

	li $v0, 4
	la $a0, res
	syscall
	
	li $v0, 3
	mov.d $f12, $f4
	syscall
	
	j calc
Enc:

# Printa o titulo

	li $v0, 4
	la $a0, enc
	syscall
	
	
	

				
	
	

	
	


