.data
mensaje: .ascii "Ingrese el texto que desea enviar: "
longitudMensaje = . - mensaje

mensaje2: .ascii "Su mensaje codificado es: "
longitudMensaje2 = . - mensaje2

mensaje3: .ascii "Se procesaron: "
longitudMensaje3 = . - mensaje3

enter: .ascii "\n"

inputUsuario:  .asciz "                                                                                                " @por defecto puede ser arriba w
longitudInputUsuario = . - inputUsuario

cantidadLetrasCambiadas: .ascii "   caracteres."
longLetras = . - cantidadLetrasCambiadas
clave: .ascii "   "
longClave = . - clave
opcion: .ascii "    "
longOpcion = . - opcion
mensaje1: .asciz "                                            "
longMensaje1 = . - mensaje1
mensajeFinal: .ascii "Su mensaje decodificado :  "
longMensajeFinal = . - mensajeFinal
.text
@-----------------------------
leerMensaje:
        .fnstart
         @Parametros inputs: no tiene
         @Parametros output:
         @r0=char leido
         mov r7, #3    @ Lectura x teclado
         mov r0, #0      @ Ingreso de cadena

         ldr r2, =longitudInputUsuario @ Leer # caracteres
         ldr r1, =inputUsuario @ donde se guarda la cadena ingresada
         swi 0        @ SWI, Software interrup
         ldr r0, [r1]

         bx lr @volvemos a donde nos llamaron
        .fnend
@----------------------------------------------------------
newLine:
	.fnstart
     	 push {lr}
     	 mov r2, #1 @Tamaño de la cadena
     	 ldr r1, =enter   @Cargamos en r1 la direccion del mensaje
     	 bl imprimirString
     	 pop {lr}
     	 bx lr @salimos de la funcion mifuncion            
      	.fnend
@----------------------------------------------------------
imprimirString:
      .fnstart
      @Parametros inputs:
      @r1=puntero al string que queremos imprimir
      @r2=longitud de lo que queremos imprimir
      mov r7, #4 @ Salida por pantalla
      mov r0, #1      @ Indicamos a SWI que sera una cadena
      swi 0    @ SWI, Software interrup
      bx lr @salimos de la funcion mifuncion
      .fnend
@----------------------------------------------------------
extraer_mensaje:
        .fnstart
        mov r3, #0
recorrer:
        ldrb r2,[r0, r3]
        cmp r2, #59             @ comparo r2 con 59 (valor del caracter ';' en ascii)
        beq salir
        strb r2,[r1], #1        @ guardo el contenido de r2 en la etiqueta donde se guarda el mensaje
        add r3, #1
        b recorrer
salir:
        bx lr
        .fnend
@-----------------------------------------------------------------------------------------------------
@ recibe en r0 el puntero del mensaje
@ recibe en r1 el puntero del string donde se va a guardar la clave
extraer_clave:
        .fnstart
        mov r3,#0
ciclo1: 
        ldrb r2,[r0,r3]
        cmp r2, #59      @ comparo r2 con 59= ';'
        beq guardar
        add r3,#1
        b ciclo1

guardar:
        strb r2,[r1]    @guardo r2 en la memoria
        add r3,#1
        ldrb r2,[r0,r3]
        cmp r2, #59
        beq salir1
        b guardar
salir1:
        bx lr
        .fnend
@----------------------------------------------------------------------------------------------------------
@ recibe en r0 el puntero del mensaje
@ recibe en r1 
extraer_opcion:
        .fnstart
        mov r4, #1
        mov r5, #0     @ contador de caracter ;
ciclo2:
        ldrb r3,[r0,r4]
        cmp r3, #59
        beq continuar2
        cmp r5, #3
        beq salir2
        strb r3,[r1]
        add r4, #1
        b ciclo2
continuar2:
        add r5, #1
        add r4, #1
        b ciclo2
salir2:
        bx lr
        .fnend
@-----------------------------------------------------------------------------------------------------------
@ recibe en r0 el puntero del mensaje
@ recibe en r1 la clave
@ output:  en r4 devuelve la cant de letras convertidas
codificar:
        .fnstart
        mov r3, #0
	mov r4, #0
ciclo3:
        ldrb r2,[r0, r3]
        cmp r2, #0
        beq salir3
        cmp r2, #32       @ comparo r2 con el valor ascii de la tecla espacio, si son iguales la salteo
        beq continuar
        add r2, r2, r1    @ le sumo a r2 el valor de la clave
        add r4, #1
	strb r2,[r0,r3]   @ guardo r2 en memoria
continuar:
        add r3, #1
        b ciclo3
salir3:
        bx lr
        .fnend
@------------------------------------------------------------------------------------------------------------
@recibe en r0 el puntero del mensaje
@recibe en r1 la clave
decodificar:
	.fnstart
	mov r3,#0  @contador del ciclo
ciclo4:
	ldrb r2,[r0,r3]
	cmp r2,#0
	beq salir4
	cmp r2,#32    @comparo r2 con el valor ascci de la tecla espacio , si son iguales la salteo
	beq continuar3
	sub r2,r2,r1  @le resto a r2 el valor de la clave
	strb r2,[r0,r3]	 @guardo r2 en memoria
continuar3:
	add r3,#1
	b ciclo4
salir4:
	bx lr
	.fnend
@-------------------------------------------------------------------------------------------------------------
@recibe en r0 el puntero de la clave
@ output: r1 contiene el entero
ascii_a_entero:
        .fnstart

        ldrb r2,[r0]
        sub r1, r2, #'0'
        bx lr
        .fnend
@-----------------------------------------------------------------
@ input: en r0 recibe el entero a convertir
entero_a_ascii:
    .fnstart
    push {lr}
    mov r1, r0
    mov r2, #100
    bl division
    mov r3, r0  @ r3 = las centenas
    mov r0, r1  @ r0 = resto
    mov r1, r0
    mov r2, #10
    bl division

    mov r2, r0  @r2 = las decenas
    mov r0, r1
    mov r1, r0   @ r1 las unidades

    add r1, #48
    add r2, #48
    add r3, #48
    pop {lr}
    bx lr
    .fnend
@--------------------------------------------------------------
@ input: en r1 tiene el dividendo, en r2 el divisor
division:
        .fnstart
        mov r0, #0
ciclo5:
        cmp r1, r2
        bcc finciclo

        sub r1, r1, r2
        add r0, r0, #1
        b ciclo5
finciclo:
        bx lr
        .fnend
@--------------------------------------------------------------
.global main
main:
         @Imprimir por pantalla "Ingresar mensaje"
         ldr r2, =longitudMensaje @Tamaño de la cadena
         ldr r1, =mensaje   @Cargamos en r1 la direccion del mensaje

         bl imprimirString

         @leemos la tecla
         bl leerMensaje

	 push {r1}         @ guardo en r1 la direccion de memoria del mensaje
	 mov r0, r1

         ldr r1, =mensaje1
         bl extraer_mensaje   @ extrae el mensaje y lo guarda en r1

         pop {r1}

	 mov r0, r1
	 push {r1}
	 ldr r1, =clave
    	 bl extraer_clave   @extraemos la clave y la guarda en r1

	 pop {r1}

	 mov r0, r1        @ ldr r0, =mensaje !!!!
         ldr r1, =opcion
         bl extraer_opcion  @extraer la opcion y la guarda en la etiqueta opcion

       	 push {r1}	    @guardo el puntero de la etiqueta "opcion"
	 ldr r0, =clave
	 bl ascii_a_entero  @ devuelve en r1 la clave

	 mov r2, r1         @ guardo en r2 la clave pasada a entero
	 pop {r1}
	 ldrb r3, [r1]      @ traigo de la memoria el contenido del string "opcion"
 
	 cmp r3, #99        @ 99 = 'c'
	 bne decodificar1
	 mov r1,r2
	 ldr r0, =mensaje1
	 bl codificar

	 mov r0,r4		@ r0 tiene la cantidad de letras procesadas
	 bl entero_a_ascii
	 ldr r5, =cantidadLetrasCambiadas
	 strb r2, [r5]
	 strb r1, [r5, #+1]
	 b fin

decodificar1:
	 cmp r3, #100
	 bne fin
	 mov r1,r2
 	 ldr r0, =mensaje1
	 bl decodificar
	 ldr r2, =longMensajeFinal @Tamaño de la cadena
         ldr r1, =mensajeFinal   @Cargamos en r1 la direccion del mensaje
         bl imprimirString
	 ldr r1, =mensaje1
         ldr r2, =longMensaje1
         bl imprimirString
	 bl newLine
	 mov r7,#1
	 swi #0
fin:
	 bl newLine
	 @Imprimir por pantalla "Ud. ha ingresado:"
   	 ldr r2, =longitudMensaje2 @Tamaño de la cadena
   	 ldr r1, =mensaje2   @Cargamos en r1 la direccion del mensaje
   	 bl imprimirString

      	@Imprimir por pantalla
         ldr r2, =longMensajeFinal @Tamaño de la cadena
         ldr r1, =mensajeFinal   @Cargamos en r1 la direccion del mensaje
         bl imprimirString
	
  	 ldr r1, =mensaje1
         ldr r2, =longMensaje1
         bl imprimirString
	
	 bl newLine

	 @Imprimir por pantalla  "Se procesaron:"
         ldr r2, =longitudMensaje3  @Tamaño de la cadena
         ldr r1, =mensaje3   @Cargamos en r1 la direccion del mensaje
         bl imprimirString

	 @Imprimir por pantalla
         ldr r2, =longLetras @Tamaño de la cadena
         ldr r1, =cantidadLetrasCambiadas   @Cargamos en r1 la direccion del mensaje
         bl imprimirString

	bl newLine
	mov r7, #1
	swi #0
