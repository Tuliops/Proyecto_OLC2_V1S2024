{
  // Código de inicio opcional (puedes declarar variables y funciones aquí)
}

// La regla inicial para nuestro parser
start
  = (comment / instruction / blank_line)*

// Definición de una instrucción
instruction
  = add_instruction
  / sub_instruction
  / and_instruction
  / ldr_instruction
  / str_instruction
  / b_instruction
  / bl_instruction
  / nop_instruction
  / wfi_instruction
  / mov_instruction
  /fmov_instruction
  /svc_instruction
  /globalStart
  /Start
  /sectionText

//Instruccion FMOV
fmov_instruction
		= "fmov"ws reg1:registerFloat ws? "," ws? val:valFloat  ws* end?
        {return {
        		type:"fmov",
               	destination: reg1,
      			valor: val
        };}
        
    
        
//Intruccion MOV 

mov_instruction
	=ws? ("MOV"/"mov") ws reg1:register ws? "," ws? val:valInteger  ws* end?
   {return {
        		type:"MOV",
               	destination: reg1,
      			valor: val
        };}
    
    /ws? ("MOV"/"mov") "MOV" ws reg1:register ws? "," ws? val:label  ws* end? 
    

    {
    	return {
        		type:"MOV",
               	destination: reg1,
      			label: val
        };
    }

// Instrucciones ADD
add_instruction
  = "ADD" ws reg1:register "," ws reg2:register "," ws op:operand ws* end?
  {
    return {
      type: "ADD",
      destination: reg1,
      source1: reg2,
      source2: op
    };
  }

// Instrucciones SUB
sub_instruction
  = "SUB" ws reg1:register "," ws reg2:register "," ws op:operand ws* end?
  {
    return {
      type: "SUB",
      destination: reg1,
      source1: reg2,
      source2: op
    };
  }

// Instrucciones AND
and_instruction
  = "AND" ws reg1:register "," ws reg2:register "," ws op:operand ws* end?
  {
    return {
      type: "AND",
      destination: reg1,
      source1: reg2,
      source2: op
    };
  }

// Instrucciones LDR
ldr_instruction
  = "LDR" ws reg1:register "," ws "[" reg2:register ("," ws offset:integer)? "]" ws* end?
  {
    return {
      type: "LDR",
      destination: reg1,
      base: reg2,
      offset: offset || 0
    };
  }

// Instrucciones STR
str_instruction
  = "STR" ws reg1:register "," ws "[" reg2:register ("," ws offset:integer)? "]" ws* end?
  {
    return {
      type: "STR",
      source: reg1,
      base: reg2,
      offset: offset || 0
    };
  }

// Instrucción B
b_instruction
  = "B" ws lbl:label ws* end?
  {
    return {
      type: "B",
      label: lbl
    };
  }

// Instrucción BL
bl_instruction
  = ws? ("BL"/"bl") ws lbl:label ws* end?
  {
    return {
      type: "BL",
      label: lbl
    };
  }

// Instrucción NOP
nop_instruction
  = "NOP" ws* end?
  {
    return {
      type: "NOP"
    };
  }

// Instrucción WFI
wfi_instruction
  = "WFI" ws* end?
  {
    return {
      type: "WFI"
    };
  }

// Comentario de una línea
comment
  = (comment_slash / comment_semicolon) ws* end?
  {
    return {
      type: "comment",
      text: text()
    };
  }

// Comentario iniciado con //
comment_slash
  = "//" (!end .)+ ws? end?

// Comentario iniciado con ;
comment_semicolon
  = ";" (!end .)+ ws? end?

// Línea en blanco
blank_line
  = ws* end {
    return {
      type: "blank_line"
    };
  }

// Registros (ejemplo simplificado)
register
  = ("X"/"x") [0-9]+
  {
    return text();
  }

// Operando puede ser un registro o un número inmediato
operand
  = register
  / integer

// Número entero
integer
  = [0-9]+
  {
    return parseInt(text(), 10);
  }

// Identificador de etiqueta
label
  = [a-zA-Z_][a-zA-Z0-9_]*

// Salto de línea 
end "newline"
  = "\n"

// Espacios en blanco
ws
  = [ \\t]+

//valor entero

valInteger = "#" integer{
    return text();
  }
  
 //para un valor float
Float
  = '-'? integer '.' [0-9]+
  / integer
  
valFloat =  "#" Float{
    return text();
  }
  
 // Registros Punto Flotante (ejemplo simplificado)
registerFloat
  = ("d"/"D") [0-9]+
  {
    return text();
  }
  
  // Definición de '.global _start'
globalStart
  = ws? ".global _start" ws* end?
          {
            return {
              type: "global start"

            }
          }


// inicio del start 

Start
  = ws? "_start:" ws* end?  lst:instruction  
  	 	{
        	return {
            	type:"start",
              description:"instruction List",
                lst : lst
            }
        
        }
  // Definición de '.section .text'
sectionText
  = ws? ".section .text" ws* end?
      {
        return {

              type:"section text"
        }
      }

// svc#0realiza la llamada al sistema para terminar el programa.
svc_instruction
		= ws? "svc" ws "#0" ws* end?
          {
            return{
              type:'svc'
            }

          }

// para creacion de fuenciones 

