
//ESTO ES UN COMENTARIO 
; PRUEBA DE COMENTARIOS 2

ADD X0, X1, X2  //comentario entre lina 
SUB X3, X4, X5
AND X6, X7, X8      ; otro comentario pero con punto y com ; ..//''[234254-098]
LDR X9, [X10, 4]
STR X11, [X12, 8]
B my_label
NOP

// Cargar un entero en el registro x10
mov X10,  #42
//Cargar una dirección de memoria en el registro x11
mov X11, mi_etiqueta
// Cargar los números de punto flotante en los registros
fmov d0, #10.5 // v0 = 10.5
fmov d1, #20.75 // v1 = 20.75