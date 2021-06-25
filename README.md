#### CodigoCesar es un programa creado en ensamblador para procesadores ARM con el objetivo de cifrar cualquier tipo de documento utilizando cifrado CESAR.

Introducción El Cifrado Cesár, que lleva su nombre en honor a Julio César, es un tipo de cifrado que fue usado en los tiempos del emperador Cayo Julio Cesar (100 - 44 AC) para enviar mensajes secretos a sus generales en los confines del imperio romano.

El método consiste en hacer un corrimiento de las letras, por ejemplo, la letra A se convierte en la letra D, la letra B se convierte en la letra E.

Por ejemplo:

>Texto original:   ABCDEFGHIJKLMNÑOPQRSTUVWXYZ
>
>Texto codificado: GHIJKLMNÑOPQRSTUVWXYZABCDEF

Por otro lado para poder descodificar el mensaje lo que se hace es tomar cada letra del mensaje cifrado y mover seis lugares hacia la izquierda lo que nos devolverá el mensaje origianl.

Por ejemplo:

>Texto codificado :  GHIJKLMNÑOPQRSTUVWXYZABCDEF
>
>Texto original:     ABCDEFGHIJKLMNÑOPQRSTUVWXYZ

### Vulnerabilidades 
Si bien el cifrado César es un método muy básico y fácil de quebrar en comparación con otros algoritmos de cifrado de la actualidad, este mecanismo de cifrar los mensajes fue muy efectivo en su tiempo y ayudó a mantener en secreto las estrategias militares del César.

De esta manera no lleva mucho timepo decodificar el cifrado y obtener el mensaje.

### Objetivos
En este trabajo se van a desarrollar y poner en práctica los conceptos de arquitectura ARM que se ven durante la segunda parte de la materia . En particular se presta atención a los siguientes conceptos:

1. Datos almacenados en registros, pila, memoria

2. Modos de direccionamiento 

3. Llamada a procedimientos del usuario e interrupciones del sistema

Estos puntos se ponen en práctica en el contexto de un juego de consola o terminal. Este contexto también permitirá implementar algunos conceptos vistos durante la primera parte de la materia, por ejemplo:

1. Codificación de caracteres ASCII

2. Conversión entre bases Decimal -> Binario, Binario -> Decimal 

3. Operaciones en Complemento A2

### Compilación
Una vez en una [Raspberry Pi](https://duckduckgo.com/?q=Raspberry+pi+&t=newext&atb=v250-1&ia=web) Fisica o ya sea Usando [QEMU](https://www.qemu.org/) que es un emulador

Primero debemos ensamblar y compilar el programa 

> as -g -o nombredelarchivo.o nombredelarchivoquehicieron.s   
> 
> gcc -o nombreconelquequierenejecutar nombredelarchivo.o

Y ya podemos ejecutar nuestro archivo .S y utilizar el cifrado cesar

> ./nombreconelquequierenejecutar

### Equipo
 + Micaela Benitez
 + Pablo Ybarra
 + Facundo Saldaña
 
 
