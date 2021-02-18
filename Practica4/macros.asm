print MACRO cadena
	pushear
	MOV AX, @data
	MOV DS, AX
	MOV AH, 09H
	MOV DX, offset cadena
	INT 21H
	poppear
ENDM

getChar MACRO
	MOV AH, 01H
	INT 21H
ENDM

clearScreen MACRO
	MOV AH, 0000H
	MOV AL, 0002H
	INT 10H
ENDM

stringRead MACRO texto
	LOCAL CAPTURAR, SALIR
	pushear
	MOV AH, 1
	XOR SI, SI
	CAPTURAR:
		INT 21H
		CMP AL, 13
		JZ SALIR
		MOV texto[SI], AL
		INC SI
		INC contadorCaracteres
		JMP CAPTURAR
	SALIR:
		poppear
ENDM

pushear MACRO 
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	PUSH SI
	PUSH DI
ENDM

poppear MACRO
	POP DI
	POP SI
	POP DX
	POP CX
	POP BX
	POP AX
ENDM

fileCreate MACRO
	pushear
	MOV AX,@data  ;Cargamos el segmento de datos para sacar el nombre del archivo.
	MOV DS, AX
	MOV AH,3CH ;instrucción para crear el archivo.
	MOV CX, 0
	MOV DX, offset pathSave ;crea el archivo con el nombre ingresado
	INT 21H
	JC SAVEERROR ;si no se pudo crear el archivo arroja un error, se captura con jc.
	MOV BX, AX
	MOV AH,3EH ;cierra el archivo
	INT 21H
	poppear
	JMP SAVESUCC
ENDM

fileOnlyReadOpen MACRO
	pushear
	MOV AH, 3DH
	MOV AL, 01H ; Abrimos en solo lectura
	MOV DX, offset pathSave
	INT 21H
	fileWrite
	poppear
ENDM

crearHtml MACRO arch
	pushear
	MOV AX,@data  ;Cargamos el segmento de datos para sacar el nombre del archivo.
	MOV DS, AX
	MOV AH,3CH ;instrucción para crear el archivo.
	MOV CX, 0
	MOV DX, offset arch ;crea el archivo con el nombre ingresado
	INT 21H
	
	MOV BX, AX
	MOV AH,3EH ;cierra el archivo
	INT 21H

	abrirHtml arch
	regresarHtml
	poppear
ENDM

abrirHtml MACRO arch
	pushear
	MOV AH, 3DH
	MOV AL, 01H
	MOV DX, offset arch
	INT 21H
	escribirHtml
	poppear
ENDM

escFila MACRO celda
	LOCAL VACIA, PNEGRA, PBLANCA, BLANCA, NEGRA, SALIR
	CMP celda, 007EH
	JE VACIA
	CMP celda, 004EH
	JE NEGRA
	CMP celda, 0042H
	JE BLANCA
	CMP celda, 002FH
	JE PNEGRA
	JMP PBLANCA

	VACIA:
		MOV reporteFicha[0025], 004EH
		MOV reporteFicha[0026], 0050H
		JMP SALIR
	NEGRA:
		MOV reporteFicha[0025], 0044H
		MOV reporteFicha[0026], 004EH
		JMP SALIR
	BLANCA:
		MOV reporteFicha[0025], 0044H
		MOV reporteFicha[0026], 0042H
		JMP SALIR
	PNEGRA:
		MOV reporteFicha[0025], 0050H
		MOV reporteFicha[0026], 004EH
		JMP SALIR
	PBLANCA:
		MOV reporteFicha[0025], 0050H
		MOV reporteFicha[0026], 0042H
		JMP SALIR

	SALIR:
		MOV CX, 0057 ; numero de caracteres a guardar
		MOV DX, offset reporteFicha
		MOV AH, 40H ; escribe la fila 1
		INT 21H
ENDM

verFicha MACRO
	LOCAL F1, F2, F3, F4, F5, F6, F7, F8, SALIR

		CMP SI, 0000
		JE F1
		CMP SI, 0001
		JE F2
		CMP SI, 0002
		JE F3
		CMP SI, 0003
		JE F4
		CMP SI, 0004
		JE F5
		CMP SI, 0005
		JE F6
		CMP SI, 0006
		JE F7
		CMP SI, 0007
		JE F8

		F1:
			escFila imagenFila1[0000]
			escFila imagenFila1[0001]
			escFila imagenFila1[0002]
			escFila imagenFila1[0003]
			escFila imagenFila1[0004]
			escFila imagenFila1[0005]
			escFila imagenFila1[0006]
			escFila imagenFila1[0007]
			JMP SALIR
		F2:
			escFila imagenFila2[0000]
			escFila imagenFila2[0001]
			escFila imagenFila2[0002]
			escFila imagenFila2[0003]
			escFila imagenFila2[0004]
			escFila imagenFila2[0005]
			escFila imagenFila2[0006]
			escFila imagenFila2[0007]
			JMP SALIR
		F3:
			escFila imagenFila3[0000]
			escFila imagenFila3[0001]
			escFila imagenFila3[0002]
			escFila imagenFila3[0003]
			escFila imagenFila3[0004]
			escFila imagenFila3[0005]
			escFila imagenFila3[0006]
			escFila imagenFila3[0007]
			JMP SALIR
		F4:
			escFila imagenFila4[0000]
			escFila imagenFila4[0001]
			escFila imagenFila4[0002]
			escFila imagenFila4[0003]
			escFila imagenFila4[0004]
			escFila imagenFila4[0005]
			escFila imagenFila4[0006]
			escFila imagenFila4[0007]
			JMP SALIR
		F5:
			escFila imagenFila5[0000]
			escFila imagenFila5[0001]
			escFila imagenFila5[0002]
			escFila imagenFila5[0003]
			escFila imagenFila5[0004]
			escFila imagenFila5[0005]
			escFila imagenFila5[0006]
			escFila imagenFila5[0007]
			JMP SALIR
		F6:
			escFila imagenFila6[0000]
			escFila imagenFila6[0001]
			escFila imagenFila6[0002]
			escFila imagenFila6[0003]
			escFila imagenFila6[0004]
			escFila imagenFila6[0005]
			escFila imagenFila6[0006]
			escFila imagenFila6[0007]
			JMP SALIR
		F7:
			escFila imagenFila7[0000]
			escFila imagenFila7[0001]
			escFila imagenFila7[0002]
			escFila imagenFila7[0003]
			escFila imagenFila7[0004]
			escFila imagenFila7[0005]
			escFila imagenFila7[0006]
			escFila imagenFila7[0007]
			JMP SALIR
		F8:
			escFila imagenFila8[0000]
			escFila imagenFila8[0001]
			escFila imagenFila8[0002]
			escFila imagenFila8[0003]
			escFila imagenFila8[0004]
			escFila imagenFila8[0005]
			escFila imagenFila8[0006]
			escFila imagenFila8[0007]
			JMP SALIR

		SALIR:
ENDM

escribirHtml MACRO
	LOCAL CICLOLETRAI, CICLOFILA, CICLOLETRAF
	pushear
	MOV BX, AX ; mover hadfile
	MOV CX, 0026 ; numero de caracteres a guardar
	MOV DX, offset reporteInicio
	MOV AH, 40H ; escribe la fila 1
	INT 21H

	XOR SI, SI
	CICLOLETRAI:
		MOV CX, 0056 ; numero de caracteres a guardar
		INC reporteLetra1[0025]
		MOV DX, offset reporteLetra1
		MOV AH, 40H ; escribe la fila 1
		INT 21H

		INC SI
		CMP SI, 0007
		JLE CICLOLETRAI

	MOV CX, 0016 ; numero de caracteres a guardar
	MOV DX, offset reporteCierreCabecera
	MOV AH, 40H ; escribe la fila 1
	INT 21H

	XOR SI, SI
	CICLOFILA:
		MOV CX, 0006 ; numero de caracteres a guardar
		MOV DX, offset reporteInicioFila
		MOV AH, 40H ; escribe la fila 1
		INT 21H

		INC reporteNumero[0026]
		MOV CX, 0057 ; numero de caracteres a guardar
		MOV DX, offset reporteNumero
		MOV AH, 40H ; escribe la fila 1
		INT 21H

		verFicha

		MOV CX, 0057 ; numero de caracteres a guardar
		MOV DX, offset reporteNumero
		MOV AH, 40H ; escribe la fila 1
		INT 21H

		MOV CX, 0007 ; numero de caracteres a guardar
		MOV DX, offset reporteFinFila
		MOV AH, 40H ; escribe la fila 1
		INT 21H

		INC SI
		CMP SI, 0007
		JLE CICLOFILA

	MOV CX, 00011 ; numero de caracteres a guardar
	MOV DX, offset reporteLetraU
	MOV AH, 40H ; escribe la fila 1
	INT 21H

	XOR SI, SI
	CICLOLETRAF:
		MOV CX, 0056 ; numero de caracteres a guardar
		INC reporteLetra2[0025]
		MOV DX, offset reporteLetra2
		MOV AH, 40H ; escribe la fila 1
		INT 21H

		INC SI
		CMP SI, 0007
		JLE CICLOLETRAF

	MOV CX, 0016 ; numero de caracteres a guardar
	MOV DX, offset reporteCierreCabecera
	MOV AH, 40H ; escribe la fila 1
	INT 21H

	MOV CX, 0006 ; numero de caracteres a guardar
	MOV DX, offset reporteH
	MOV AH, 40H ; escribe la fila 1
	INT 21H

	Obtener_Fecha_Hora fecha

	MOV CX, 0015 ; numero de caracteres a guardar
	MOV DX, offset fecha
	MOV AH, 40H ; escribe la fila 1
	INT 21H

	MOV CX, 0006 ; numero de caracteres a guardar
	MOV DX, offset reporteH
	MOV AH, 40H ; escribe la fila 1
	INT 21H

	MOV CX, 0022 ; numero de caracteres a guardar
	MOV DX, offset reporteFin
	MOV AH, 40H ; escribe la fila 1
	INT 21H

	CMP CX, AX
	MOV AH, 3EH ; cerrar el archivo
	INT 21H
	poppear
ENDM

fileWrite MACRO
	pushear
	MOV BX, AX ; mover hadfile
	MOV CX, 0008 ; numero de caracteres a guardar
	MOV DX, offset imagenFila1
	MOV AH, 40H ; escribe la fila 1
	INT 21H
	MOV CX, 0008 ; numero de caracteres a guardar
	MOV DX, offset imagenFila2
	MOV AH, 40H ; escribe la fila 2
	INT 21H
	MOV CX, 0008 ; numero de caracteres a guardar
	MOV DX, offset imagenFila3
	MOV AH, 40H ; escribe la fila 3
	INT 21H
	MOV CX, 0008 ; numero de caracteres a guardar
	MOV DX, offset imagenFila4
	MOV AH, 40H ; escribe la fila 4
	INT 21H
	MOV CX, 0008 ; numero de caracteres a guardar
	MOV DX, offset imagenFila5
	MOV AH, 40H ; escribe la fila 5
	INT 21H
	MOV CX, 0008 ; numero de caracteres a guardar
	MOV DX, offset imagenFila6
	MOV AH, 40H ; escribe la fila 6
	INT 21H
	MOV CX, 0008 ; numero de caracteres a guardar
	MOV DX, offset imagenFila7
	MOV AH, 40H ; escribe la fila 7
	INT 21H
	MOV CX, 0008 ; numero de caracteres a guardar
	MOV DX, offset imagenFila8
	MOV AH, 40H ; escribe la fila 8
	INT 21H
	MOV CX, 0002 ; numero de caracteres a guardar
	MOV DX, offset puntosNegro
	MOV AH, 40H ; Guarda los puntos negros
	INT 21H
	MOV CX, 0002 ; numero de caracteres a guardar
	MOV DX, offset puntosBlanco
	MOV AH, 40H ; Guarda los puntos blancos
	INT 21H
	MOV CX, 0002 ; numero de caracteres a guardar
	MOV DX, offset turno
	MOV AH, 40H ; escribe el jugador que tiene el turno
	INT 21H
	CMP CX, AX
	MOV AH, 3EH ; cerrar el archivo
	INT 21H
	poppear
ENDM

stringCompare MACRO reservada	
	LOCAL COMPARAR, IGUAL, DIFERENTE, FIN
	pushear
	XOR SI,SI ; Resetea SI
	COMPARAR:
		MOV BH, command[SI] ; almacena en BH el caracter en la posicion SI del comando
		MOV BL, reservada[SI] ; almacena en BL el caracter en la posicion SI de la reservada
		CMP BH, BL ; compara los contenidos de BH y BL
		JNE DIFERENTE ; Son diferentes
		CMP BH, '$' ; Son iguales -> verifica si es fin de cadena
		JE IGUAL ; Es fin de cadena -> son iguales
		INC SI ; incrementa SI
		JMP COMPARAR ; compara el siguiente caracter
	DIFERENTE:
		MOV comparation, 0000 ; comprobacion es negativa
		JMP FIN
	IGUAL:
		MOV comparation, 0001 ; comprobacion es positiva
		JMP FIN
	FIN:
		poppear
ENDM

move MACRO t
	LOCAL F1, F2, F3, F4, F5, F6, F7, F8, OCUPADO, SALIR
	pushear
	XOR SI, SI
	MOV comparation, 0000
	getSI command[0000]

	CMP command[0001], 0031H
	JE F1
	CMP command[0001], 0032H
	JE F2
	CMP command[0001], 0033H
	JE F3
	CMP command[0001], 0034H
	JE F4
	CMP command[0001], 0035H
	JE F5
	CMP command[0001], 0036H
	JE F6
	CMP command[0001], 0037H
	JE F7
	CMP command[0001], 0038H
	JE F8
	
	F1:
		CMP imagenFila1[SI], 007EH
		JNE OCUPADO
		MOV fila1[SI], t
		MOV posicionActualX[0000], AL
		MOV posicionInicialX[0000], AL
		MOV posicionActualY[0000], 0001
		MOV posicionInicialY[0000], 0001
		JMP SALIR

	F2:
		CMP imagenFila2[SI], 007EH
		JNE OCUPADO
		MOV fila2[SI], t
		MOV posicionActualX[0000], AL
		MOV posicionInicialX[0000], AL
		MOV posicionActualY[0000], 0002
		MOV posicionInicialY[0000], 0002
		JMP SALIR

	F3:
		CMP imagenFila3[SI], 007EH
		JNE OCUPADO
		MOV fila3[SI], t
		MOV posicionActualX[0000], AL
		MOV posicionInicialX[0000], AL
		MOV posicionActualY[0000], 0003
		MOV posicionInicialY[0000], 0003
		JMP SALIR

	F4:
		CMP imagenFila4[SI], 007EH
		JNE OCUPADO
		MOV fila4[SI], t
		MOV posicionActualX[0000], AL
		MOV posicionInicialX[0000], AL
		MOV posicionActualY[0000], 0004
		MOV posicionInicialY[0000], 0004
		JMP SALIR

	F5:
		CMP imagenFila5[SI], 007EH
		JNE OCUPADO
		MOV fila5[SI], t
		MOV posicionActualX[0000], AL
		MOV posicionInicialX[0000], AL
		MOV posicionActualY[0000], 0005
		MOV posicionInicialY[0000], 0005
		JMP SALIR

	F6:
		CMP imagenFila6[SI], 007EH
		JNE OCUPADO
		MOV fila6[SI], t
		MOV posicionActualX[0000], AL
		MOV posicionInicialX[0000], AL
		MOV posicionActualY[0000], 0006
		MOV posicionInicialY[0000], 0006
		JMP SALIR

	F7:
		CMP imagenFila7[SI], 007EH
		JNE OCUPADO
		MOV fila7[SI], t
		MOV posicionActualX[0000], AL
		MOV posicionInicialX[0000], AL
		MOV posicionActualY[0000], 0007
		MOV posicionInicialY[0000], 0007
		JMP SALIR

	F8:
		CMP imagenFila8[SI], 007EH
		JNE OCUPADO
		MOV fila8[SI], t
		MOV posicionActualX[0000], AL
		MOV posicionInicialX[0000], AL
		MOV posicionActualY[0000], 0008
		MOV posicionInicialY[0000], 0008
		JMP SALIR

	OCUPADO:
		MOV comparation, 0001
		JMP SALIR

	SALIR:
	 poppear
ENDM

getSI MACRO char
	LOCAL L1, L2, L3, L4, L5, L6, L7, L8, SALIR
	CMP char, 0041H
	JE L1
	CMP char, 0042H
	JE L2
	CMP char, 0043H
	JE L3
	CMP char, 0044H
	JE L4
	CMP char, 0045H
	JE L5
	CMP char, 0046H
	JE L6
	CMP char, 0047H
	JE L7
	CMP char, 0048H
	JE L8
	JMP SALIR

	L1:
		MOV SI, 0000
		MOV AL, 0000
		JMP SALIR
	L2:
		MOV SI, 0001
		MOV AL, 0001
		JMP SALIR
	L3:
		MOV SI, 0002
		MOV AL, 0002
		JMP SALIR
	L4:
		MOV SI, 0003
		MOV AL, 0003
		JMP SALIR
	L5:
		MOV SI, 0004
		MOV AL, 0004
		JMP SALIR
	L6:
		MOV SI, 0005
		MOV AL, 0005
		JMP SALIR
	L7:
		MOV SI, 0006
		MOV AL, 0006
		JMP SALIR
	L8:
		MOV SI, 0007
		MOV AL, 0007
		JMP SALIR

	SALIR:
ENDM

fileReader MACRO
	pushear
	MOV AH, 3DH ; abre el archivo
   	MOV AL, 0 ; abre para lectura
   	LEA DX, pathAbrir
   	INT 21H ; interrupcion
   	MOV [filehandle], AX ; carga el handler

   	MOV AH, 3FH ; leer
   	LEA DX, texto ; se almacena en texto
   	MOV CX, 69 ; lee 65 caracteres
   	MOV BX, [filehandle] ; recorre buffer
   	INT 21H ; interrupcion

   	MOV BX, [filehandle]
   	MOV AH, 3EH ; cierra el archivo
   	INT 21H	; interrupcion
	poppear
ENDM

printTable MACRO
	print letras
	print numero1
	print fila1
	print numero2
	print fila2
	print numero3
	print fila3
	print numero4
	print fila4
	print numero5
	print fila5
	print numero6
	print fila6
	print numero7
	print fila7
	print numero8
	print fila8
	print letras
ENDM

imprimirImagen MACRO
	print letras
	print numero1
	print imagenFila1
	print numero2
	print imagenFila2
	print numero3
	print imagenFila3
	print numero4
	print imagenFila4
	print numero5
	print imagenFila5
	print numero6
	print imagenFila6
	print numero7
	print imagenFila7
	print numero8
	print imagenFila8
	print letras
ENDM

verF MACRO celda, compro
	LOCAL CAMBIAR, NOCAMBIAR, SALIR

	CMP compro, 002FH
	JE CAMBIAR
	CMP compro, 005CH
	JE CAMBIAR
	JMP NOCAMBIAR

	CAMBIAR:
		MOV celda, 007EH
		JMP SALIR

	NOCAMBIAR:
		MOV celda, compro
		JMP SALIR

	SALIR:
ENDM

fillRow MACRO
	LOCAL CICLO
	pushear
	XOR BX, BX
	XOR SI, SI
	XOR CH, CH
	CICLO:
		MOV CH, texto[BX]
		MOV imagenFila1[SI], CH
		verF fila1[SI], CH

		MOV CH, texto[BX + 08D]
		MOV imagenFila2[SI], CH
		verF fila2[SI], CH

		MOV CH, texto[BX + 16D]
		MOV imagenFila3[SI], CH
		verF fila3[SI], CH 

		MOV CH, texto[BX + 24D]
		MOV imagenFila4[SI], CH
		verF fila4[SI], CH

		MOV CH, texto[BX + 32D]
		MOV imagenFila5[SI], CH
		verF fila5[SI], CH 

		MOV CH, texto[BX + 40D]
		MOV imagenFila6[SI], CH
		verF fila6[SI], CH 

		MOV CH, texto[BX + 48D]
		MOV imagenFila7[SI], CH
		verF fila7[SI], CH

		MOV CH, texto[BX + 56D]
		MOV imagenFila8[SI], CH
		verF fila8[SI], CH

		INC SI
		INC BX
		CMP SI, 07
		JLE CICLO

	MOV CH, texto[64]
	MOV puntosNegro[00], CH
	MOV CH, texto[65]
	MOV puntosNegro[01], CH

	MOV CH, texto[66]
	MOV puntosBlanco[00], CH
	MOV CH, texto[67]
	MOV puntosBlanco[01], CH

	MOV CH, texto[68]
	MOV turno[00], CH

	MOV blackPass, 0000
	MOV whitePass, 0000
	poppear
ENDM

resetGame MACRO
	LOCAL CICLO
	XOR SI, SI

	CICLO:
		MOV fila1[SI], 007EH
		MOV fila2[SI], 007EH
		MOV fila3[SI], 007EH
		MOV fila4[SI], 007EH
		MOV fila5[SI], 007EH
		MOV fila6[SI], 007EH
		MOV fila7[SI], 007EH
		MOV fila8[SI], 007EH
		MOV imagenFila1[SI], 007EH
		MOV imagenFila2[SI], 007EH
		MOV imagenFila3[SI], 007EH
		MOV imagenFila4[SI], 007EH
		MOV imagenFila5[SI], 007EH
		MOV imagenFila6[SI], 007EH
		MOV imagenFila7[SI], 007EH
		MOV imagenFila8[SI], 007EH
		MOV revisadas1[SI], 0000
		MOV revisadas2[SI], 0000
		MOV revisadas3[SI], 0000
		MOV revisadas4[SI], 0000
		MOV revisadas5[SI], 0000
		MOV revisadas6[SI], 0000
		MOV revisadas7[SI], 0000
		MOV revisadas8[SI], 0000
		INC SI
		CMP SI, 07
		JLE CICLO

	MOV turno[0000], 0030H
ENDM

resetSearch MACRO
	LOCAL CICLO
	XOR SI, SI

	CICLO:
		MOV revisadas1[SI], 0000
		MOV revisadas2[SI], 0000
		MOV revisadas3[SI], 0000
		MOV revisadas4[SI], 0000
		MOV revisadas5[SI], 0000
		MOV revisadas6[SI], 0000
		MOV revisadas7[SI], 0000
		MOV revisadas8[SI], 0000
		INC SI
		CMP SI, 07
		JLE CICLO
ENDM

resetChain MACRO
	LOCAL CICLO, CAPTURA
	pushear
	XOR SI, SI

	CMP evaluado, 0000
	JE CICLO
	CMP contadorLibertades, 0000
	JE CAPTURA
	JMP CICLO

	CAPTURA:
		CALL eliminarCeldas
		JMP CICLO

	CICLO:
		MOV revisarCadena1[SI], 0000
		MOV revisarCadena2[SI], 0000
		MOV revisarCadena3[SI], 0000
		MOV revisarCadena4[SI], 0000
		MOV revisarCadena5[SI], 0000
		MOV revisarCadena6[SI], 0000
		MOV revisarCadena7[SI], 0000
		MOV revisarCadena8[SI], 0000
		INC SI
		CMP SI, 07
		JLE CICLO
	MOV contadorLibertades, 0000
	poppear
ENDM

evaluarLibertad MACRO revisadas, cadenas
	LOCAL CONTINUAR, F1, F2, F3, F4, F5, F6, F7, F8, SALIR
	pushear
	CMP revisadas, 0000 ; Verifica si en la posicion de revisadasN[SI] exista un dato
	JE SALIR ; No existe dato -> Sale
	CMP cadenas, 0000 ; Verifica si la posicion de revisarCadenasN[SI] no exista un dato
	JE CONTINUAR ; No existe dato -> Continua
	JMP SALIR ; Si exista un dato -> Sale
	CONTINUAR:
		MOV evaluado, 0001
		MOV BL, fichaBuscada[0000]
		MOV cadenas, BL
		MOV revisadas, 0000
		MOV CL, filaEvaluada[0000]
		MOV CH, columnaEvaluada[0000]
		CALL evaluarDerecha
		MOV filaEvaluada[0000], CL
		MOV columnaEvaluada[0000], CH
		CALL evaluarIzquierda
		MOV filaEvaluada[0000], CL
		MOV columnaEvaluada[0000], CH
		CALL evaluarAbajoArriba
		JMP SALIR

	SALIR:
		poppear
ENDM

cambiarCelda MACRO celda, vector
	LOCAL COMPARAR, SALIR
	pushear
	MOV AL, fichaBuscada[0000]
	CMP celda, 007EH
	JE SALIR
	CMP celda, AL
	JE COMPARAR
	JMP SALIR

	COMPARAR:
		MOV vector[SI], AL
		JMP SALIR

	SALIR:
		poppear
ENDM

verificarValor MACRO dato, pos
	LOCAL SUMAR, SALIR

	CMP pos, 0000 ; Verifica si existe algo en el arreglo temporal
	JE SALIR
	; 007EH representa espacio vacio -> hay libertad
	CMP dato, 007EH
	JE SUMAR
	JMP SALIR

	SUMAR:
		INC contadorLibertades
		JMP SALIR

	SALIR:
ENDM

verificarLibertadG MACRO cAr, cAb, cI, cD, posTemp
	verificarValor cAr, posTemp
	verificarValor cAb, posTemp
	verificarValor cI, posTemp
	verificarValor cD, posTemp
ENDM

verificarLibertadAA MACRO cAA, cI, cD, posTemp
	verificarValor cAA, posTemp
	verificarValor cI, posTemp
	verificarValor cD, posTemp
ENDM

verificarLibertadGL MACRO cAr, cAb, cID, posTemp
	verificarValor cAr, posTemp
	verificarValor cAb, posTemp
	verificarValor cID, posTemp
ENDM

verificarLibertadAAL MACRO cAA, cID, posTemp
	verificarValor cAA, posTemp
	verificarValor cID, posTemp
ENDM

verificarMover MACRO celda, val
	LOCAL ACTUALIZAR, SALIR
	pushear
	CMP val, 0000
	JNE ACTUALIZAR
	JMP SALIR

	ACTUALIZAR:
		MOV AL, val
		MOV celda, AL

	SALIR:
		poppear
ENDM

eliminarPieza MACRO real, imagen, temporal
	LOCAL PNEGRAS, PBLANCAS, SALIR
	CMP temporal, 0000
	JE SALIR
	CMP turno[0000], 004EH ; Turno de las Negras, puntos Negras
	JE PNEGRAS
	JMP PBLANCAS

	PNEGRAS:
		MOV imagen, 002FH
		MOV real, 007EH
		CALL sumarNegro
		JMP SALIR

	PBLANCAS:
		MOV imagen, 005CH
		MOV real, 007EH
		CALL sumarBlanco
		JMP SALIR

	SALIR:
ENDM

Obtener_Fecha_Hora MACRO bufferFecha
	PUSH ax
	PUSH bx
	PUSH cx
	PUSH dx
	PUSH si
	xor si, si
	xor bx, bx

	mov ah,2ah
	int 21h
	;REGISTRO DL = DIA 	 REGISTRO DH = MES

	Establer_Numero bufferFecha, dl  		;ESTABLECIENDO UN NUMERO PARA DIA
	mov bufferFecha[si],2fh ;HEXA DE /
	inc si
	Establer_Numero bufferFecha, dh 		;ESTABLECIENDO UN NUMERO PARA MES
	mov bufferFecha[si],2fh ;HEXA DE /
	inc si
	mov bufferFecha[si],31h	; = 1
	inc si
	mov bufferFecha[si],39h	; = 9
	inc si
	mov bufferFecha[si],20h	; = espacio
	inc si
	mov bufferFecha[si],20h	; = espacio
	inc si

	mov ah,2ch
	int 21h
	;REGISTRO CH = HORA 	 REGISTRO CL = MINUTOS
	Establer_Numero bufferFecha, ch  		;ESTABLECIENDO UN NUMERO PARA HORA
	mov bufferFecha[si],3ah 				;HEXA DE :
	inc si
	Establer_Numero bufferFecha, cl 		;ESTABLECIENDO UN NUMERO PARA MINUTOS

	POP si
	POP dx
	POP cx
	POP bx
	POP ax
ENDM

Establer_Numero MACRO bufferFecha, registro
	PUSH ax
	PUSH bx
	xor ax,ax
	xor bx,bx	;PASO MI REGISTRO PARA DIVIDIR
	mov bl,0ah
	mov al,registro
	div bl

	 Obtener_Numero bufferFecha, al 	;PRIMERO EL CONCIENTE
	 Obtener_Numero bufferFecha, ah 	;SEGUNDO EL MODULO

	POP bx
	POP ax
ENDM

Obtener_Numero MACRO bufferFecha, registro
	LOCAL cero,uno,dos,tres,cuatro,cinco,seis,siete,ocho,nueve,Salir
	cmp registro , 00h
	je cero
	cmp registro, 01h
	je uno
	cmp registro, 02h
	je dos
	cmp registro, 03h
	je tres
	cmp registro, 04h
	je cuatro
	cmp registro, 05h
	je cinco
	cmp registro, 06h
	je seis
	cmp registro, 07h
	je siete
	cmp registro, 08h
	je ocho
	cmp registro, 09h
	je nueve
	jmp Salir

	cero:
		mov bufferFecha[si],30h 	;0
		inc si
		jmp Salir
	uno:
		mov bufferFecha[si],31h 	;1
		inc si
		jmp Salir
	dos:
		mov bufferFecha[si],32h 	;2
		inc si
		jmp Salir
	tres:
		mov bufferFecha[si],33h 	;3
		inc si
		jmp Salir
	cuatro:
		mov bufferFecha[si],34h 	;4
		inc si
		jmp Salir
	cinco:
		mov bufferFecha[si],35h 	;5
		inc si
		jmp Salir
	seis:
		mov bufferFecha[si],36h 	;6
		inc si
		jmp Salir
	siete:
		mov bufferFecha[si],37h 	;7
		inc si
		jmp Salir
	ocho:
		mov bufferFecha[si],38h 	;8
		inc si
		jmp Salir
	nueve:
		mov bufferFecha[si],39h 	;9
		inc si
		jmp Salir
	Salir:
ENDM

regresarHtml MACRO
	MOV reporteLetra1[0025], 0064D
	MOV reporteNumero[0026], 0048D
	MOV reporteLetra2[0025], 0064D
ENDM