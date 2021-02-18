INCLUDE macros.asm ; Incluye el archivo donde se encuentran todos los macros almacenados

.MODEL large ; Utiliza un espacio 'medium' de almacenamiento

;===========================================================
;=======================AREA DE STACK=======================
;===========================================================
.STACK 100H
;===========================================================
;=======================AREA DE STACK=======================
;===========================================================

;===========================================================
;=======================AREA DE DATA=======================
;===========================================================
.DATA
	encabezado DB 0AH, 0DH, 'UNIVERSIDAD DE SAN CARLOS DE GUATEMALA', 0AH, 0DH, 'FACULTAD DE INGENIERIA', 0AH, 0DH, 'CIENCIAS Y SISTEMAS', 0AH, 0DH, 'ARQUITECTURA DE COMPUTADORES Y ENSAMBLADORES 1', 0AH, 0DH, 'NOMBRE: ELEAZAR JARED LOPEZ OSUNA', 0AH, 0DH, 'CARNET: 201700893', 0AH, 0DH, 'SECCION: A', 0AH, 0DH, '$'
	menuTitle DB 0AH, 0DH, '1) Start New Game', 0AH, 0DH, '2) Load Game', 0AH, 0DH, '3) Exit', 0AH, 0DH, 'Selec your option', 0AH, 0DH, '$' ; Menu
 	opcion1 DB 0AH, 0DH, '--------You selected Start New Game--------', 0AH, 0DH, '$' ; Confirmacion de Nuevo Juego
 	opcion2 DB 0AH, 0DH, '--------You selected Load Game--------', 0AH, 0DH, '$' ; Confirmacion de Cargar Juego
 	gameEnd DB 0AH, 0DH, '--------Game Over--------', 0AH, 0DH, '$'
 	savedName DB 0AH, 0DH, 'Enter new File name with extension: ', '$'
 	openName DB 0AH, 0DH, 'Enter File name with extension: ', '$'
 	saveSuccess DB 0AH, 0DH, 'File Saved Successfully, Press any key to continue', '$'
 	saveFailure DB 0AH, 0DH, 'Error: File could not be saved, Press any key to continue', '$'
 	lugarOcupado DB 0AH, 0DH, 'Place is taken or is Suicidal, try again. Press any key to continue', 0AH, 0DH, '$'
  	lugarNoExiste DB 0AH, 0DH, 'Place does not exists, try again. Press any key to continue', 0AH, 0DH, '$'
  	black DB 0AH, 0DH, 'Black Turn: ', '$' ; Turno fichas negras
 	white DB 0AH, 0DH, 'White Turn: ', '$' ; Turno fichas blancas
 	reservedPass DB 'PASS$'; Palabra reservada PASS
 	reservedExit DB 'EXIT$' ; Palabra reservada EXIT
 	reservedSave DB 'SAVE$' ; Palabra reservada SAVE
 	reservedShow DB 'SHOW$' ; Palabra reservada SHOW
 	command DB 5 dup('$')
 	contadorCaracteres DB ?
 	pathSave DB 80 dup(' ')
 	pathAbrir DB 80 dup(0)
 	turno DB 004EH, '$'
 	blackPass DB 0000
 	whitePass DB 0000
 	comparation DB 0000
 	result DB 0000
 	filehandle DW ?
 	texto DB 69 dup('$')
 	contador DB 0000

 	numero1 DB 0AH, 0DH, '1 ', '$'
 	numero2 DB 0DH, '2 ', '$'
 	numero3 DB 0DH, '3 ', '$'
 	numero4 DB 0DH, '4 ', '$'
 	numero5 DB 0DH, '5 ', '$'
 	numero6 DB 0DH, '6 ', '$'
 	numero7 DB 0DH, '7 ', '$'
 	numero8 DB 0DH, '8 ', '$'
 	letras DB 0DH, '  ABCDEFGH', '$'

 	posicionInicialX DB 0000, '$'
 	posicionInicialY DB 0000, '$'

 	posicionActualX DB 0000, '$'
 	posicionActualY DB 0000, '$'

 	fichaBuscada DB 004EH, '$'

 	contadorLibertades DB 0001
 	contadorExtra DB 0000
 	columnaEvaluada DB 0000H, '$'
 	filaEvaluada DB 0000H, '$'
 	evaluado DB 0000

 	tmp DB 0000, '$'

 	mensajePuntosN DB 00AH, 00DH, 'Puntos fichas Negras: ', '$'
 	mensajePuntosB DB 00AH, 00DH, 'Puntos fichas Blancas: ', '$'
 	puntosNegro DB 0030H, 0030H, '$'
 	puntosBlanco DB 0030H, 0030H, '$'

 	nombreReporteActual DB 'state.', 'html', 0
 	nombreReporteFinal DB 'repor.', 'html', 0

 	reporteInicio DB '<html><table><tr><th></th>', '$'; 26
 	reporteFin DB 000AH, 000DH, '</h1></table></html>', '$' ; 22
 	reporteLetra1 DB 000AH, 000DH, '<th><img src="IMG/letra@.png" height=40 width=40></th>', '$' ; 56
 	reporteLetra2 DB 000AH, 000DH, '<th><img src="IMG/letra@.png" height=40 width=40></th>', '$' ; 56
 	reporteNumero DB 000AH, 000DH, '<td><img src="IMG/numero0.png" height=40 width=40></td>', '$' ; 57
 	reporteCierreCabecera DB 000AH, 000DH, '<th></th></tr>', '$'; 16
 	reporteInicioFila DB 000AH, 000DH, '<tr>', '$'; 6
 	reporteFinFila DB 000AH, 000DH, '</tr>', '$'; 7
 	reporteFicha DB 000AH, 000DH, '<td><img src="IMG/fichaNP.png" height=40 width=40></td>', '$'; 57
 	reporteLetraU DB 000AH, 000DH, '<th></th>', '$' ; 11
 	reporteH DB 000AH, 000DH, '<h1>', '$', 6

 	fecha DB 15 dup('$')



	; 007E->SIN FICHA; 004E->FICHA NEGRA; 0042->FICHA BLANCA; 002F->PUNTO NEGRO; 005C->PUNTO BLANCO
	;	   		=========================================================
	;      		|   0  |   1  |   2  |   3  |   4  |   5  |   6  |   7  |
	;	   		=========================================================
 		fila1 DB 007EH, 007EH, 007EH, 007EH, 007EH, 007EH, 007EH, 007EH, ' 1 ', 000AH, 000DH, '$'
 		fila2 DB 007EH, 007EH, 007EH, 007EH, 007EH, 007EH, 007EH, 007EH, ' 2 ', 000AH, 000DH, '$'
 		fila3 DB 007EH, 007EH, 007EH, 007EH, 007EH, 007EH, 007EH, 007EH, ' 3 ', 000AH, 000DH, '$'
 		fila4 DB 007EH, 007EH, 007EH, 007EH, 007EH, 007EH, 007EH, 007EH, ' 4 ', 000AH, 000DH, '$'
 		fila5 DB 007EH, 007EH, 007EH, 007EH, 007EH, 007EH, 007EH, 007EH, ' 5 ', 000AH, 000DH, '$'
 		fila6 DB 007EH, 007EH, 007EH, 007EH, 007EH, 007EH, 007EH, 007EH, ' 6 ', 000AH, 000DH, '$'
 		fila7 DB 007EH, 007EH, 007EH, 007EH, 007EH, 007EH, 007EH, 007EH, ' 7 ', 000AH, 000DH, '$'
 		fila8 DB 007EH, 007EH, 007EH, 007EH, 007EH, 007EH, 007EH, 007EH, ' 8 ', 000AH, 000DH, '$'


	; 007E->SIN FICHA; 004E->FICHA NEGRA; 0042->FICHA BLANCA; 002F->PUNTO NEGRO; 005C->PUNTO BLANCO
	;	        	 ================================================================
	;           	 |   0  |   1  |   2  |   3  |   4  |   5  |   6  |   7  |   8  |
	;	        	 ================================================================
 		imagenFila1 DB 007EH, 007EH, 007EH, 007EH, 007EH, 007EH, 007EH, 007EH, 000AH, 000DH, '$'
 		imagenFila2 DB 007EH, 007EH, 007EH, 007EH, 007EH, 007EH, 007EH, 007EH, 000AH, 000DH, '$'
 		imagenFila3 DB 007EH, 007EH, 007EH, 007EH, 007EH, 007EH, 007EH, 007EH, 000AH, 000DH, '$'
 		imagenFila4 DB 007EH, 007EH, 007EH, 007EH, 007EH, 007EH, 007EH, 007EH, 000AH, 000DH, '$'
 		imagenFila5 DB 007EH, 007EH, 007EH, 007EH, 007EH, 007EH, 007EH, 007EH, 000AH, 000DH, '$'
 		imagenFila6 DB 007EH, 007EH, 007EH, 007EH, 007EH, 007EH, 007EH, 007EH, 000AH, 000DH, '$'
 		imagenFila7 DB 007EH, 007EH, 007EH, 007EH, 007EH, 007EH, 007EH, 007EH, 000AH, 000DH, '$'
 		imagenFila8 DB 007EH, 007EH, 007EH, 007EH, 007EH, 007EH, 007EH, 007EH, 000AH, 000DH, '$'

	; 0000->SIN FICHA; 004E->FICHA NEGRA; 0042->FICHA BLANCA;
	;	          	 ==============================================
	;              	 | 0  | 1  | 2  | 3  | 4  | 5  | 6  | 7  | 8  |
	;	           	 ==============================================
 		revisadas1 DB 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 000AH, 000DH, '$'
 		revisadas2 DB 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 000AH, 000DH, '$'
 		revisadas3 DB 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 000AH, 000DH, '$'
 		revisadas4 DB 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 000AH, 000DH, '$'
 		revisadas5 DB 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 000AH, 000DH, '$'
 		revisadas6 DB 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 000AH, 000DH, '$'
 		revisadas7 DB 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 000AH, 000DH, '$'
 		revisadas8 DB 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 000AH, 000DH, '$'

	; 007E->SIN FICHA; 004E->FICHA NEGRA; 0042->FICHA BLANCA;
	;	             	 ==============================================
	;                	 | 0  | 1  | 2  | 3  | 4  | 5  | 6  | 7  | 8  |
	;	             	 ==============================================
 		revisarCadena1 DB 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 000AH, 000DH, '$'
 		revisarCadena2 DB 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 000AH, 000DH, '$'
 		revisarCadena3 DB 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 000AH, 000DH, '$'
 		revisarCadena4 DB 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 000AH, 000DH, '$'
 		revisarCadena5 DB 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 000AH, 000DH, '$'
 		revisarCadena6 DB 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 000AH, 000DH, '$'
 		revisarCadena7 DB 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 000AH, 000DH, '$'
 		revisarCadena8 DB 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 000AH, 000DH, '$'

;===========================================================
;======================AREA DE CODIGO=======================
;===========================================================
.CODE 

	main  PROC

		;===========================================================
		;========================MENU INICIAL=======================
		;===========================================================
			MENU:
				clearScreen ; Limpia la pantalla
				print encabezado
				print menuTitle ; Muestra el menu
				getChar ; Captura el caracter
				CMP AL, 49D ; caracter == 1
				JE START  ; Inicia el juego
				CMP AL, 50D ; caracter == 2
				JE LOAD ; Carga el juego
				CMP AL, 51D ; caracter == 3
				JE EXIT ; Sale del programa
				JMP MENU ; Regresa al menu
		;===========================================================
		;========================MENU INICIAL=======================
		;===========================================================



		;===========================================================
		;========================NUEVO JUEGO========================
		;===========================================================
			START:
				resetGame
				CALL updateImage
				resetSearch
				clearScreen ; Limpia la pantalla
				print opcion1 ; Muestra opcion1
				JMP TURNBLACK ; Empieza el Juego
		;===========================================================
		;========================NUEVO JUEGO========================
		;===========================================================



		;===========================================================
		;=======================GUARDAR JUEGO=======================
		;===========================================================
			SAVE:
				clearScreen ; Limpia la pantalla
				print savedName ; Muestra mensaje de guardar
				MOV contadorCaracteres, 0000 ; Resetear el contador de caracteres
				stringRead pathSave ; Lee la ruta
				CALL DELIMITAR
				fileCreate

			SAVEERROR:
				print saveFailure
				CALL PAUSA ; Hace pausa
				CMP turno[00], 004EH
				JE TURNBLACK
				JMP TURNWHITE

			SAVESUCC:
				fileOnlyReadOpen
				print saveSuccess
				CALL PAUSA ; Hace pausa
				CMP turno[00], 004EH
				JE TURNBLACK
				JMP TURNWHITE
		;===========================================================
		;=======================GUARDAR JUEGO=======================
		;===========================================================



		;===========================================================
		;===========================SHOW============================
		;===========================================================
			SHOW:
				clearScreen ; Limpia la pantalla
				print opcion2 ; Muestra opcion2
				crearHtml nombreReporteActual
				CMP turno[00], 004EH
				JE TURNBLACK
				JMP TURNWHITE
		;===========================================================
		;===========================SHOW============================
		;===========================================================



		;===========================================================
		;========================CARGAR JUEGO=======================
		;===========================================================
			LOAD:
				clearScreen ; Limpia la pantalla
				print opcion2 ; Muestra opcion2
				print openName
				stringRead pathAbrir
				fileReader
				fillRow
				CALL PAUSA
				CMP turno[00], 004EH
				JE TURNBLACK
				JMP TURNWHITE
		;===========================================================
		;========================CARGAR JUEGO=======================
		;===========================================================



		;===========================================================
		;===================Termino El Juego========================
		;===========================================================
			ENDGAME:
				clearScreen ; Limpia la pantalla
				print gameEnd ; Muestra gameEnd
				print mensajePuntosN
				print puntosNegro
				print mensajePuntosB
				print puntosBlanco
				crearHtml nombreReporteFinal
				CALL PAUSA ; Hace pausa
				JMP MENU
		;===========================================================
		;===================Termino El Juego========================
		;===========================================================



		;===========================================================
		;===========================SALIR===========================
		;===========================================================
			EXIT:
				clearScreen ; Limpia la pantalla
				MOV AX, 4C00H ; Interrupcion para finalizar el programa
				INT 21H ; Llama a la interrupcion
		;===========================================================
		;===========================SALIR===========================
		;===========================================================



		;===========================================================
		;===========================TURNO===========================
		;===========================================================
			TURNBLACK:
				MOV fichaBuscada[0000], 004EH
				MOV turno[00], 004EH
				clearScreen ; Limpia la pantalla
				printTable
				print black ; Muestra mensaje de turno negras
				MOV contadorCaracteres, 0000 ; Resetear el contador de caracteres
				stringRead command ; Lee el comando
				stringCompare reservedPass ; Compara si el comando es PASS
				JE PASSBLACK ; Comando == PASS
				stringCompare reservedExit ; Compara si el comando es EXIT
				JE MENU ; Comando == EXIT
				stringCompare reservedSave ; Compara si el comando es SAVE
				JE SAVE ; Comando == SAVE -> 0000 para regresar al turno de negras
				stringCompare reservedShow ; Compara si el comando es SHOW
				JE SHOW ; Comando == SHOW
				MOV fichaBuscada[0000], 0042H ; Buscara las fichas blancas
				JMP CHECKMOV

			PASSBLACK:
				MOV blackPass, 0001 ; negro paso
				CMP whitePass, 0001 ; verifica si el blanco pasó en turno anterior
				JE ENDGAME ; blanco = negro = paso -> termino el juego
				JMP TURNWHITE ; Turno blanco

			TURNWHITE:
				MOV turno[00], 0042H
				clearScreen ; Limpia la pantalla
				printTable
				print white ; Muestra mensaje de turno negras
				MOV contadorCaracteres, 0000 ; Resetear el contador de caracteres
				stringRead command ; Lee el comando
				stringCompare reservedPass ; Compara si el comando es PASS
				JE PASSWHITE ; Comando == PASS
				stringCompare reservedExit ; Compara si el comando es EXIT
				JE MENU ; Comando == EXIT
				stringCompare reservedSave ; Compara si el comando es SAVE
				JE SAVE ; Comando == SAVE -> 0001 para regresar al turno de blancas
				stringCompare reservedShow ; Compara si el comando es SHOW
				JE SHOW ; Comando == SHOW
				MOV fichaBuscada[0000], 004EH ; Buscara las fichas negras
				JMP CHECKMOV

			PASSWHITE:
				MOV whitePass, 0001 ; blanco paso
				CMP blackPass, 0001 ; verifica si el negro paso
				JE ENDGAME ; blanco = negro = paso -> termino el juego
				JMP TURNBLACK ; turno negro

			NOEXISTE:
				print lugarNoExiste
				CALL PAUSA
				CMP turno, 004EH
				JE TURNBLACK
				JMP TURNWHITE

			OCUPADO:
				print lugarOcupado
				CALL PAUSA
				CMP turno, 004EH
				JE TURNBLACK
				JMP TURNWHITE

			CHECKMOV:
				CALL ANALIZARNUMERO
				JNZ NOEXISTE
				CALL ANALIZARLETRA
				JNZ NOEXISTE
				CMP turno, 004EH
				JE REALIZARTURNOB
				JMP REALIZARTURNOW

			REALIZARTURNOB:
				move 004EH
				CMP comparation, 0001
				JE OCUPADO

				;Verificar cadena
				CALL updateImage
				resetSearch ; Se reinicia el buscador.
				CALL mostrarOpuestos
				CALL buscarLibertadInicial
				MOV blackPass, 0000 ; Comando != PASS
				JMP TURNWHITE ; Turno blanco

			REALIZARTURNOW:
				move 0042H
				CMP comparation, 0001
				JE OCUPADO

				;Verificar cadena
				resetSearch ; Se reinicia el buscador.
				CALL updateImage 
				CALL mostrarOpuestos
				CALL buscarLibertadInicial
				MOV whitePass, 0000 ; Comando != PASS
				JMP TURNBLACK ; Turno blanco
		;===========================================================
		;===========================TURNO===========================
		;===========================================================


		;===========================================================
		;======================PROCEDIMIENTOS=======================
		;===========================================================

			evaluarAbajoArriba PROC
				pushear
				XOR BX, BX
				MOV BL, CH
				MOV SI, BX

				; filaEvaluada contiene la posicion en Y, SI contiene la posicion en X
				CMP CL, 0000
				JE F1
				CMP CL, 0001
				JE F2
				CMP CL, 0002
				JE F3
				CMP CL, 0003
				JE F4
				CMP CL, 0004
				JE F5
				CMP CL, 0005
				JE F6
				CMP CL, 0006
				JE F7
				CMP CL, 0007
				JE F8
				JMP SALIR

				F1:
					MOV filaEvaluada[0000], 0001
					evaluarLibertad revisadas2[SI], revisarCadena2[SI]
					JMP SALIR

				F2:
					MOV filaEvaluada[0000], 0000
					evaluarLibertad revisadas1[SI], revisarCadena1[SI]
					MOV filaEvaluada[0000], 0002
					evaluarLibertad revisadas3[SI], revisarCadena3[SI]
					JMP SALIR

				F3:
					MOV filaEvaluada[0000], 0001
					evaluarLibertad revisadas2[SI], revisarCadena2[SI]
					MOV filaEvaluada[0000], 0003
					evaluarLibertad revisadas4[SI], revisarCadena4[SI]
					JMP SALIR

				F4:
					MOV filaEvaluada[0000], 0002
					evaluarLibertad revisadas3[SI], revisarCadena3[SI]
					MOV filaEvaluada[0000], 0004
					evaluarLibertad revisadas5[SI], revisarCadena5[SI]
					JMP SALIR

				F5:
					MOV filaEvaluada[0000], 0003
					evaluarLibertad revisadas4[SI], revisarCadena4[SI]
					MOV filaEvaluada[0000], 0005
					evaluarLibertad revisadas6[SI], revisarCadena6[SI]
					JMP SALIR

				F6:
					MOV filaEvaluada[0000], 0004
					evaluarLibertad revisadas5[SI], revisarCadena5[SI]
					MOV filaEvaluada[0000], 0006
					evaluarLibertad revisadas7[SI], revisarCadena7[SI]
					JMP SALIR

				F7:
					MOV filaEvaluada[0000], 0005
					evaluarLibertad revisadas6[SI], revisarCadena6[SI]
					MOV filaEvaluada[0000], 0007
					evaluarLibertad revisadas8[SI], revisarCadena8[SI]
					JMP SALIR

				F8:
					MOV filaEvaluada[0000], 0006
					evaluarLibertad revisadas7[SI], revisarCadena7[SI]
					JMP SALIR

				SALIR:
					poppear
					RET
			evaluarAbajoArriba ENDP

			evaluarDerecha PROC NEAR
				pushear

				CMP columnaEvaluada[0000], 0007
				JE SALIR

				INC columnaEvaluada[0000]
				XOR BX, BX
				MOV BL, columnaEvaluada[0000]
				MOV SI, BX

				; filaEvaluada contiene la posicion en Y, SI contiene la posicion en X
				CMP filaEvaluada[0000], 0000
				JE F1
				CMP filaEvaluada[0000], 0001
				JE F2
				CMP filaEvaluada[0000], 0002
				JE F3
				CMP filaEvaluada[0000], 0003
				JE F4
				CMP filaEvaluada[0000], 0004
				JE F5
				CMP filaEvaluada[0000], 0005
				JE F6
				CMP filaEvaluada[0000], 0006
				JE F7
				CMP filaEvaluada[0000], 0007
				JE F8
				JMP SALIR

				F1:
					evaluarLibertad revisadas1[SI], revisarCadena1[SI]
					JMP SALIR

				F2:
					evaluarLibertad revisadas2[SI], revisarCadena2[SI]
					JMP SALIR

				F3:
					evaluarLibertad revisadas3[SI], revisarCadena3[SI]
					JMP SALIR

				F4:
					evaluarLibertad revisadas4[SI], revisarCadena4[SI]
					JMP SALIR

				F5:
					evaluarLibertad revisadas5[SI], revisarCadena5[SI]
					JMP SALIR

				F6:
					evaluarLibertad revisadas6[SI], revisarCadena6[SI]
					JMP SALIR

				F7:
					evaluarLibertad revisadas7[SI], revisarCadena7[SI]
					JMP SALIR

				F8:
					evaluarLibertad revisadas8[SI], revisarCadena8[SI]
					JMP SALIR

				SALIR:
					poppear
					RET
			evaluarDerecha ENDP

			evaluarIzquierda PROC NEAR
				pushear

				CMP columnaEvaluada[0000], 0001
				JE SALIR

				DEC columnaEvaluada[0000]
				XOR BX, BX
				MOV BL, columnaEvaluada[0000]
				MOV SI, BX

				; filaEvaluada contiene la posicion en Y, SI contiene la posicion en X
				CMP filaEvaluada[0000], 0000
				JE F1
				CMP filaEvaluada[0000], 0001
				JE F2
				CMP filaEvaluada[0000], 0002
				JE F3
				CMP filaEvaluada[0000], 0003
				JE F4
				CMP filaEvaluada[0000], 0004
				JE F5
				CMP filaEvaluada[0000], 0005
				JE F6
				CMP filaEvaluada[0000], 0006
				JE F7
				CMP filaEvaluada[0000], 0007
				JE F8
				JMP SALIR

				F1:
					evaluarLibertad revisadas1[SI], revisarCadena1[SI]
					JMP SALIR

				F2:
					evaluarLibertad revisadas2[SI], revisarCadena2[SI]
					JMP SALIR

				F3:
					evaluarLibertad revisadas3[SI], revisarCadena3[SI]
					JMP SALIR

				F4:
					evaluarLibertad revisadas4[SI], revisarCadena4[SI]
					JMP SALIR

				F5:
					evaluarLibertad revisadas5[SI], revisarCadena5[SI]
					JMP SALIR

				F6:
					evaluarLibertad revisadas6[SI], revisarCadena6[SI]
					JMP SALIR

				F7:
					evaluarLibertad revisadas7[SI], revisarCadena7[SI]
					JMP SALIR

				F8:
					evaluarLibertad revisadas8[SI], revisarCadena8[SI]
					JMP SALIR

				SALIR:
					poppear
					RET
			evaluarIzquierda ENDP

			buscarLibertadInicial PROC
				pushear
				XOR SI, SI ; Aca se guardara la posicion actual
					
				CICLO:
					XOR AX, AX
					MOV AX, SI 

					MOV columnaEvaluada[0000], AL
					MOV evaluado, 0000
					MOV filaEvaluada[0000], 0000
					evaluarLibertad revisadas1[SI], revisarCadena1[SI]
					CALL verificarLibertad
					resetChain
					MOV columnaEvaluada[0000], AL
					MOV evaluado, 0000
					MOV filaEvaluada[0000], 0001
					evaluarLibertad revisadas2[SI], revisarCadena2[SI]
					CALL verificarLibertad
					resetChain
					MOV columnaEvaluada[0000], AL
					MOV evaluado, 0000
					MOV filaEvaluada[0000], 0002
					evaluarLibertad revisadas3[SI], revisarCadena3[SI]
					CALL verificarLibertad
					resetChain
					MOV columnaEvaluada[0000], AL
					MOV evaluado, 0000
					MOV filaEvaluada[0000], 0003
					evaluarLibertad revisadas4[SI], revisarCadena4[SI]
					CALL verificarLibertad
					resetChain
					MOV columnaEvaluada[0000], AL
					MOV evaluado, 0000
					MOV filaEvaluada[0000], 0004
					evaluarLibertad revisadas5[SI], revisarCadena5[SI]
					CALL verificarLibertad
					resetChain
					MOV columnaEvaluada[0000], AL
					MOV evaluado, 0000
					MOV filaEvaluada[0000], 0005
					evaluarLibertad revisadas6[SI], revisarCadena6[SI]
					CALL verificarLibertad
					resetChain
					MOV columnaEvaluada[0000], AL
					MOV evaluado, 0000
					MOV filaEvaluada[0000], 0006
					evaluarLibertad revisadas7[SI], revisarCadena7[SI]
					CALL verificarLibertad
					resetChain
					MOV columnaEvaluada[0000], AL
					MOV evaluado, 0000
					MOV filaEvaluada[0000], 0007
					evaluarLibertad revisadas8[SI], revisarCadena8[SI]
					CALL verificarLibertad
					resetChain
					INC SI
					CMP SI, 07
					JLE CICLO
				SALIR:
					poppear
					RET
			buscarLibertadInicial ENDP

			verificarLibertad PROC
				pushear
				XOR SI, SI ; Reinicio SI para hacer un recorrido
				
				CICLO:

					CMP SI, 00 ; Compara SI con 00 para ver si es una posicion mas izquierda
					JE IZQUIERDO

					CMP SI, 07 ; Compara SI con 07 para ver si es una posicion mas derecha
					JE DERECHO

					; SI representa una posicion central 1,2,3,4,5,6 por lo que se le puede

					; aplicar busqueda con los vectores que tienen posicion arriba, abajo, izquierda y derecha
					verificarLibertadG imagenFila1[SI], imagenFila3[SI], imagenFila2[SI - 1], imagenFila2[SI + 1], revisarCadena2[SI] ; Fila2
					verificarLibertadG imagenFila2[SI], imagenFila4[SI], imagenFila3[SI - 1], imagenFila3[SI + 1], revisarCadena3[SI] ; Fila3
					verificarLibertadG imagenFila3[SI], imagenFila5[SI], imagenFila4[SI - 1], imagenFila4[SI + 1], revisarCadena4[SI] ; Fila4
					verificarLibertadG imagenFila4[SI], imagenFila6[SI], imagenFila5[SI - 1], imagenFila5[SI + 1], revisarCadena5[SI] ; Fila5
					verificarLibertadG imagenFila5[SI], imagenFila7[SI], imagenFila6[SI - 1], imagenFila6[SI + 1], revisarCadena6[SI] ; Fila6
					verificarLibertadG imagenFila6[SI], imagenFila8[SI], imagenFila7[SI - 1], imagenFila7[SI + 1], revisarCadena7[SI] ; Fila7
					

					; aplicar busqueda con los vectores que tienen posicion (arriba o abajo), izquierda y derecha
					verificarLibertadAA imagenFila2[SI], imagenFila1[SI - 1], imagenFila1[SI + 1], revisarCadena1[SI] ; Fila1
					verificarLibertadAA imagenFila7[SI], imagenFila8[SI - 1], imagenFila8[SI + 1], revisarCadena8[SI] ; Fila8
					JMP CONTINUAR

					IZQUIERDO: 
						; aplicar busqueda con los vectores que tienen posicion arriba, abajo y derecha
						verificarLibertadGL imagenFila1[SI], imagenFila3[SI], imagenFila2[SI + 1], revisarCadena2[SI] ; Fila2
						verificarLibertadGL imagenFila2[SI], imagenFila4[SI], imagenFila3[SI + 1], revisarCadena3[SI] ; Fila3
						verificarLibertadGL imagenFila3[SI], imagenFila5[SI], imagenFila4[SI + 1], revisarCadena4[SI] ; Fila4
						verificarLibertadGL imagenFila4[SI], imagenFila6[SI], imagenFila5[SI + 1], revisarCadena5[SI] ; Fila5
						verificarLibertadGL imagenFila5[SI], imagenFila7[SI], imagenFila6[SI + 1], revisarCadena6[SI] ; Fila6
						verificarLibertadGL imagenFila6[SI], imagenFila8[SI], imagenFila7[SI + 1], revisarCadena7[SI] ; Fila7

						; aplicar busqueda con los vectores que tienen posicion (arriba o abajo) y derecha
						verificarLibertadAAL imagenFila2[SI], imagenFila1[SI + 1], revisarCadena1[SI] ; Fila1
						verificarLibertadAAL imagenFila7[SI], imagenFila8[SI + 1], revisarCadena8[SI] ; Fila8
						JMP CONTINUAR

					DERECHO: 
						; aplicar busqueda con los vectores que tienen posicion arriba, abajo e izquierda
						verificarLibertadGL imagenFila1[SI], imagenFila3[SI], imagenFila2[SI - 1], revisarCadena2[SI] ; Fila2
						verificarLibertadGL imagenFila2[SI], imagenFila4[SI], imagenFila3[SI - 1], revisarCadena3[SI] ; Fila3
						verificarLibertadGL imagenFila3[SI], imagenFila5[SI], imagenFila4[SI - 1], revisarCadena4[SI] ; Fila4
						verificarLibertadGL imagenFila4[SI], imagenFila6[SI], imagenFila5[SI - 1], revisarCadena5[SI] ; Fila5
						verificarLibertadGL imagenFila5[SI], imagenFila7[SI], imagenFila6[SI - 1], revisarCadena6[SI] ; Fila6
						verificarLibertadGL imagenFila6[SI], imagenFila8[SI], imagenFila7[SI - 1], revisarCadena7[SI] ; Fila7

						; aplicar busqueda con los vectores que tienen posicion (arriba o abajo) e izquierda
						verificarLibertadAAL imagenFila2[SI], imagenFila1[SI - 1], revisarCadena1[SI] ; Fila1
						verificarLibertadAAL imagenFila7[SI], imagenFila8[SI - 1], revisarCadena8[SI] ; Fila8
						JMP CONTINUAR

					CONTINUAR:
						INC SI
						CMP SI, 07
						JLE CICLO ; Si SI <= 07 continua con el ciclo
						JMP SALIR ; Sale del ciclo

				SALIR:
					poppear
					RET
			verificarLibertad ENDP

			DELIMITAR PROC 
				MOV BH, 00
				MOV BL, contadorCaracteres ; Delimita cadena introducida a tama¤o namelen
				MOV pathSave[BX],00h ; Termina cadena con 00h para poder renombrar 
				MOV pathSave[BX+1],'$' ; Pone delimitador de exhibici¢n de caracteres
				RET
			DELIMITAR ENDP

			PAUSA PROC 
				MOV AH, 00H ; Leer pulsaci¢n
			    INT 16H
			    RET
			PAUSA ENDP

			ANALIZARLETRA PROC 
				CMP command[0000], 0041H
				JE SALIR
				CMP command[0000], 0042H
				JE SALIR
				CMP command[0000], 0043H
				JE SALIR
				CMP command[0000], 0044H
				JE SALIR
				CMP command[0000], 0045H
				JE SALIR
				CMP command[0000], 0046H
				JE SALIR
				CMP command[0000], 0047H
				JE SALIR
				CMP command[0000], 0048H
				JE SALIR
				CMP command[0000], 0049H
				JMP SALIR
				SALIR:
					RET
			ANALIZARLETRA ENDP

			ANALIZARNUMERO PROC 
				CMP command[0001], 0031H
				JE SALIR
				CMP command[0001], 0032H
				JE SALIR
				CMP command[0001], 0033H
				JE SALIR
				CMP command[0001], 0034H
				JE SALIR
				CMP command[0001], 0035H
				JE SALIR
				CMP command[0001], 0036H
				JE SALIR
				CMP command[0001], 0037H
				JE SALIR
				CMP command[0001], 0038H
				JE SALIR
				CMP command[0001], 0039H
				JMP SALIR
				SALIR:
					RET
			ANALIZARNUMERO ENDP

			mostrarOpuestos PROC
				pushear
				XOR SI, SI
				MOV AL, turno[0000]
				CICLO:
					cambiarCelda fila1[SI], revisadas1
					cambiarCelda fila2[SI], revisadas2
					cambiarCelda fila3[SI], revisadas3
					cambiarCelda fila4[SI], revisadas4
					cambiarCelda fila5[SI], revisadas5
					cambiarCelda fila6[SI], revisadas6
					cambiarCelda fila7[SI], revisadas7
					cambiarCelda fila8[SI], revisadas8
					INC SI
					CMP SI, 07
					JLE CICLO
				poppear
				RET
			mostrarOpuestos ENDP

			updateImage PROC
				pushear
				XOR SI,SI

				CICLO:
					verificarMover imagenFila1[SI], fila1[SI]
					verificarMover imagenFila2[SI], fila2[SI]
					verificarMover imagenFila3[SI], fila3[SI]
					verificarMover imagenFila4[SI], fila4[SI]
					verificarMover imagenFila5[SI], fila5[SI]
					verificarMover imagenFila6[SI], fila6[SI]
					verificarMover imagenFila7[SI], fila7[SI]
					verificarMover imagenFila8[SI], fila8[SI]
					INC SI
					CMP SI, 07
					JLE CICLO

				poppear
				RET
			updateImage ENDP

			eliminarCeldas PROC
				pushear
				XOR SI, SI

				CICLO:
					eliminarPieza fila1[SI], imagenFila1[SI], revisarCadena1[SI]
					eliminarPieza fila2[SI], imagenFila2[SI], revisarCadena2[SI]
					eliminarPieza fila3[SI], imagenFila3[SI], revisarCadena3[SI]
					eliminarPieza fila4[SI], imagenFila4[SI], revisarCadena4[SI]
					eliminarPieza fila5[SI], imagenFila5[SI], revisarCadena5[SI]
					eliminarPieza fila6[SI], imagenFila6[SI], revisarCadena6[SI]
					eliminarPieza fila7[SI], imagenFila7[SI], revisarCadena7[SI]
					eliminarPieza fila8[SI], imagenFila8[SI], revisarCadena8[SI]
					INC SI
					CMP SI, 07
					JLE CICLO
				poppear
				RET
			eliminarCeldas ENDP

			sumarNegro PROC
				pushear
				CMP puntosNegro[0001], 0038H
				JLE UNIDAD
				JMP DECENA

				UNIDAD:
					INC puntosNegro[0001]
					JMP SALIR 
				DECENA:
					INC puntosNegro[0000]
					MOV puntosNegro[0001], 0030H
				SALIR:
					poppear
					RET
			sumarNegro ENDP

			sumarBlanco PROC
				pushear
				CMP puntosBlanco[0001], 0038H
				JLE UNIDAD
				JMP DECENA

				UNIDAD:
					INC puntosBlanco[0001]
					JMP SALIR 
				DECENA:
					INC puntosBlanco[0000]
					MOV puntosBlanco[0001], 0030H
				SALIR:
					poppear
					RET
			sumarBlanco ENDP
		;===========================================================
		;======================PROCEDIMIENTOS=======================
		;===========================================================
		
	main  ENDP

END	main