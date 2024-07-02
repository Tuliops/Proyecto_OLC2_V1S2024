const TYPE = {
    EMPTY: 'Vacio',                             // Espacios en blanco
    COMMA: 'Coma',                              // Coma "," comunmente usada para separar elementos
    EXCLA: 'Signo de Exclamacion',              // Signo de Exclamacion "!" utilizadon en address
    RB: 'Llave Derecha',                        // Llave Derecha "]" utilizada en address
    LB: 'Llave Izquierda',                      // Llave Izquierda "[" utilizada en address
    PLUS: 'Mas',                                // Signo de Suma "+" utilizado en operaciones Atomicas
    Y: 'Simbolo &',                             // Simbolo & utilizado en operaciones Atomicas
    O: 'Simbolo |',                             // Simbolo | utilizado en operaciones Atomicas
    NEG: 'Simbolo ~',                           // Simbolo ~ utilizado en operaciones Atomicas
    XOR: 'Simbolo ⊕',                          // Simbolo ⊕ utilizado en operaciones Atomicas
    COMMENT: 'Comentario',                      // Comentario para el lenguaje ARM64
    BLANK: 'Linea en Blanco',                   // Linea en Blanco permitida para el lenguaje ARM64
    INT: 'Numero Entero',                       // Numero Entero tanto positivo como negativo
    BIN: 'Numero Binario',                      // Numero Binario (quitar "0b" de la cadena)
    HEX: 'Numero Hexadecimal',                  // Numero Hexadecimal
    OCT: 'Numero Octal',                      // Numero Octal
    DOUBLE: 'Numero Decimal',                   // Numero Decimal
    BOOLEAN: 'Booleano',                        // Booleano "true" o "false"
    ARRAY: 'Arreglo',                           // Arreglo de elementos
    STRING: 'Cadena de Caracteres',             // Cadena de Caracteres
    CHAR: 'Caracter',                           // Caracter
    IDENTIFIER: 'Identificador',                // Identificador de una variable
    CONSTANT: 'Constante',                      // Constante de una variable (puede ser un numero o un identificador)
    EQUAL: 'Igual',                             // Signo de Igual "="
    LABEL: 'Etiqueta',                          // Etiqueta de una instruccion
    NUMERAL: 'Numeral',                         // Numeral "#" utilizado en la llamada o utilización de inmediatos
    SIGN: 'Signo',                              // Signo de una operacion
    IMM: 'Inmediato',                           // Inmediato de una instruccion #imm
    Q: 'Sufijo de Condicion',                   // Sufijo de Condicion de una instruccion
    CC: 'Codigo de Condicion',                  // Codigo de Condicion de una instruccion
    SYSREG: 'Registro de Sistema',              // Registro de Sistema
    SY: 'Sufijo de Sistema',                    // Sufijo de Sistema "SY"
    R64: 'Registro de 64 bits',                 // Registro de 64 bits "Xn"
    R32: 'Registro de 32 bits',                 // Registro de 32 bits "Wn"
    SP64: 'Puntero de Pila de 64 bits',         // Puntero de Pila de 64 bits "SP"
    SP32: 'Puntero de Pila de 32 bits',         // Puntero de Pila de 32 bits "WSP"
    ZR64: 'Registro Cero de 64 bits',           // Registro Cero de 64 bits
    ZR32: 'Registro Cero de 32 bits',           // Registro Cero de 32 bits
    PC: 'Contador de Programa',                 // Contador de Programa "PC"
    LR: 'Registro de Enlace',                   // Registro de Enlace "LR"
    FP: 'Registro de Marco',                    // Registro de Marco "FP"
    EXTEND: 'Extendido',                        // Extendido de una instruccion "EXTEND"                        
    OPEXTEND: 'Operando Extendido',             // Operando Extendido de una instruccion
    SHIFT: 'Desplazamiento',                    // Desplazamiento de una instruccion "SHIFT"
    OPSHIFT: 'Operando de Desplazamiento',      // Operando de Desplazamiento de una instruccion
    BARRIEROP: 'Operacion de Barrera',          // Operacion de Barrera de una instruccion
    PRFOP: 'Operacion de Prefetch',             // Operacion de Prefetch de una instruccion
    ADDR: 'Direccion de Memoria',               // Direccion de Memoria de una instruccion
    SH: 'Sufijo de Desplazamiento',             // Sufijo de Desplazamiento de una instruccion
    MASK: 'Mascara',                            // Mascara de una instruccion
    REL: 'Etiqueta de Salto',                   // Etiqueta de Salto de una instruccion
    OP2A: 'Operando 2 Aritmetico',              // Operando 2 Aritmetico de una instruccion
    OP2L: 'Operando 2 Logico',                  // Operando 2 Logico de una instruccion
    OP: 'Operador',                             // Operador de una instruccion
    ARGS: 'Argumentos',                         // Argumentos de una instruccion
    INST_SECTION: 'Seccion de Instrucciones',   // Seccion de Instrucciones
    INST: 'Instruccion',                        // Instruccion de una seccion
    INSTRUCTIONS: 'Instrucciones',              // Instrucciones de una seccion
    EXPRESSION: 'Expresion',                    // Expresion de una instruccion
    EXPRESSIONS: 'Expresiones',                 // Expresiones de una instruccion
    DIRECT_SECTION: 'Seccion de Directivas',    // Seccion de Directivas
    DIRECT_EXP: 'Expresion de Directiva',       // Expresion de Directiva de una seccion
    DIRECTIVE: 'Directiva',                     // Directiva de una seccion
    ROOT: 'Raiz',                               // Raiz de un arbol de sintaxis concreta
            /*-----------------------------------------------------------*/
            AT: 'AT',                                   // Atómico
            BRK: 'BRK',                                 // Punto de Ruptura
            CLREX: 'CLREX',                             // Limpiar Exclusión
            DMB: 'DMB',                                 // Barrera de Memoria de Dominio
            DSB: 'DSB',                                 // Barrera de Memoria de Sincronización de Dominio
            ERET: 'ERET',                               // Retorno de Excepción
            HVC: 'HVC',                                 // Llamada de Hipervisor
            ISB: 'ISB',                                 // Barrera de Sincronización de Instrucción
            MRS: 'MRS',                                 // Leer Registro de Sistema
            MSR: 'MSR',                                 // Escribir Registro de Sistema
            NOP: 'NOP',                                 // No Operación
            SEV: 'SEV',                                 // Enviar Evento
            SEVL: 'SEVL',                               // Enviar Evento Local
            SMC: 'SMC',                                 // Llamada segura al monitor
            SVC: 'SVC',                                 // Llamada de Supervisor
            WFE: 'WFE',                                 // Esperar para Evento
            WFI: 'WFI',                                 // Esperar para Interrupción
            YIELD: 'YIELD',                             // Ceder
            /*-----------------------------------------------------------*/
            LDAXP: 'LDAXP',                             // Cargar y Añadir Exclusivo
            LDXP: 'LDXP',                               // Cargar Exclusivo
            LDR: 'LDR',                                 // Cargar
            LDAR: 'LDAR',                               // Cargar Añadiendo Reserva
            LDXR: 'LDAXR',                              // Cargar Exclusivo
            LDAXR: 'LDAXR',                             // Cargar y Añadir Exclusivo
            LDAXRB: 'LDAXRB',                           // Cargar y Añadir Exclusivo de 8 bits
            LDAXRH: 'LDAXRH',                           // Cargar y Añadir Exclusivo de 16 bits
            LDRB: 'LDRB',                               // Cargar de 8 bits
            LDRH: 'LDRH',                               // Cargar de 16 bits
            LDNP: 'LDNP',                               // Cargar Paralelo
            LDRT: 'LDRT',                               // Cargar de Registro
            LDTRB: 'LDTRB',                             // Cargar de Registro de 8 bits
            LDTRH: 'LDTRH',                             // Cargar de Registro de 16 bits
            LDTRS: 'LDTRS',                             // Cargar de Registro de 32 bits
            LDTRSB: 'LDTRSB',                           // Cargar de Registro de 8 bits con Signo
            LDTRSH: 'LDTRSH',                           // Cargar de Registro de 16 bits con Signo
            LDTRSW: 'LDTRSW',                           // Cargar de Registro de 32 bits con Signo
            STLR: 'STLR',                               // Almacenar y Cargar Exclusivo
            STLRB: 'STLRB',                             // Almacenar y Cargar Exclusivo de 8 bits
            STLRH: 'STLRH',                             // Almacenar y Cargar Exclusivo de 16 bits
            STLXP: 'STLXP',                             // Almacenar y Cargar Exclusivo
            STXP: 'STXP',                               // Almacenar Exclusivo
            STXR: 'STXR',                               // Almacenar Exclusivo
            STLXR: 'STLXR',                             // Almacenar y Cargar Exclusivo
            STXRB: 'STXRB',                             // Almacenar Exclusivo de 8 bits
            STXRH: 'STXRH',                             // Almacenar Exclusivo de 16 bits
            STLXRB: 'STLXRB',                           // Almacenar y Cargar Exclusivo de 8 bits
            STLXRH: 'STLXRH',                           // Almacenar y Cargar Exclusivo de 16 bits
            STMP: 'STMP',                               // Almacenar Multiples
            STTR: 'STTR',                               // Almacenar Translación
            STTRB: 'STTRB',                             // Almacenar Translación de 8 bits
            STTRH: 'STTRH',                             // Almacenar Translación de 16 bits
            /*-----------------------------------------------------------*/
            CRC32: 'CRC32',                             // Cyclic Redundancy Check
            CRC32B: 'CRC32B',                           // Cyclic Redundancy Check de 8 bits
            CRC32H: 'CRC32CH',                          // Cyclic Redundancy Check de 16 bits
            CRC32W: 'CRC32W',                           // Cyclic Redundancy Check de 32 bits
            CRC32X: 'CRC32X',                           // Cyclic Redundancy Check de 64 bits
            CRC32C: 'CRC32C',                           // Cyclic Redundancy Check
            CRC32CB: 'CRC32CB',                         // Cyclic Redundancy Check de 8 bits
            CRC32CH: 'CRC32CH',                         // Cyclic Redundancy Check de 16 bits
            CRC32CW: 'CRC32CW',                         // Cyclic Redundancy Check de 32 bits
            CRC32CX: 'CRC32CX',                         // Cyclic Redundancy Check de 64 bits
            /*-----------------------------------------------------------*/
            AADD: 'AADD',                               // Añadir Atomico 
            ACLR: 'ACLR',                               // Limpiar Atomico
            AEOR: 'AEOR',                               // Exclusivo OR Atomico
            ASET: 'ASET',                               // Establecer Atomico
            /*-----------------------------------------------------------*/
            CAS: 'CAS',                                 // Compara y Intercambia
            CASBH: 'CASBH',                             // Compara y Intercambia de 8 bits 
            CASP: 'CASP',                               // Compara y Intercambia Paralelo 
            LDAO: 'LDAO',                               // Cargar Atomico
            LDAOBH: 'LDAOBH',                           // Cargar Atomico de 8 bits
            STAO: 'STAO',                               // Almacenar Atomico
            STAOBH: 'STAOBH',                           // Almacenar Atomico de 8 bits 
            SWP: 'SWP',                                 // Intercambio
            SWPBH: 'SWPBH',                             // Intercambio de 8 bits
            /*-----------------------------------------------------------*/
            LDP: 'LDP',                                 // Cargar Paralelo
            LDPSW: 'LDPSW',                             // Cargar Paralelo de 32 bits con Signo
            LDR: 'LDR',                                 // Cargar
            LDUR: 'LDUR',                               // Cargar sin Reserva
            LDURB: 'LDURB',                             // Cargar de 8 bits sin Reserva
            LDURH: 'LDURH',                             // Cargar de 16 bits sin Reserva
            LDRB: 'LDRB',                               // Cargar de 8 bits
            LDRH: 'LDRH',                               // Cargar de 16 bits
            LDRS: 'LDRS',                               // Cargar de 32 bits 
            LDURSB: 'LDURSB',                           // Cargar de 8 bits sin Reserva con Signo
            LDURSH: 'LDURSH',                           // Cargar de 16 bits sin Reserva con Signo
            LDRSB: 'LDRSB',                             // Cargar de 8 bits con Signo
            LDRSH: 'LDRSH',                             // Cargar de 16 bits con Signo
            LDRSW: 'LDRSW',                             // Cargar de 32 bits con Signo
            LDURSW: 'LDURSW',                           // Cargar de 32 bits sin Reserva con Signo
            PRFM: 'PRFM',                               // Prefetch Memoria
            STP: 'STP',                                 // Almacenar Paralelo
            STR: 'STR',                                 // Almacenar
            STUR: 'STUR',                               // Almacenar sin Reserva
            STURB: 'STURB',                             // Almacenar de 8 bits sin Reserva 
            STURH: 'STURH',                             // Almacenar de 16 bits sin Reserva
            STRB: 'STRB',                               // Almacenar de 8 bits
            STRH: 'STRH',                               // Almacenar de 16 bits
            /*-----------------------------------------------------------*/
            CCMM: 'CCMM',                               // Compara y Mueve Mascara
            CCMP: 'CCMP',                               // Compara y Mueve
            CINC: 'CINC',                               // Incremento Condicional
            CINV: 'CINV',                               // Invertir Condicional
            CNEG: 'CNEG',                               // Negar Condicional
            CSEL: 'CSEL',                               // Seleccionar Condicional
            CSET: 'CSET',                               // Establecer Condicional
            CSETM: 'CSETM',                             // Establecer Mascara Condicional
            CSINC: 'CSINC',                             // Incremento Condicional
            CSINV: 'CSINV',                             // Invertir Condicional
            CSNEG: 'CSNEG',                             // Negar Condicional 
            /*-----------------------------------------------------------*/
            B: 'B',                                     // Salto Incondicional
            BCC: 'BCC',                                 // Salto Condicional
            BL: 'BL',                                   // Salto con Enlace
            BLR: 'BLR',                                 // Salto con Enlace a Registro
            BR: 'BR',                                   // Salto a Registro
            CBZ: 'CBZ',                                 // Salto Condicional a Cero
            CBNZ: 'CBNZ',                               // Salto Condicional a No Cero
            RET: 'RET',                                 // Retorno
            TBZ: 'TBZ',                                 // Prueba y Salto a Cero
            TBNZ: 'TBNZ',                               // Prueba y Salto a No Cero
            /*-----------------------------------------------------------*/
            AND: 'AND',                                 // AND Logico
            ANDS: 'ANDS',                               // AND Logico con Flags
            ASR: 'ASR',                                 // Desplazamiento Aritmetico a la Derecha
            ASRV: 'ASRV',                               // Desplazamiento Aritmetico a la Derecha de Registro
            BIC: 'BIC',                                 // Limpiar Bits
            BICS: 'BICS',                               // Limpiar Bits con Flags
            EON: 'EON',                                 // OR Exclusivo Negado
            EOR: 'EOR',                                 // OR Exclusivo
            ORN: 'ORN',                                 // OR Negado
            LSL: 'LSL',                                 // Desplazamiento Logico a la Izquierda
            LSR: 'LSR',                                 // Desplazamiento Logico a la Derecha
            MOV: 'MOV',                                 // Mover
            MOVK: 'MOVK',                               // Mover con Desplazamiento
            MOVN: 'MOVN',                               // Mover Negado
            MOVZ: 'MOVZ',                               // Mover con Ceros
            MVN: 'MVN',                                 // Mover Negado
            ORN: 'ORN',                                 // OR Negado
            ORR: 'ORR',                                 // OR Logico
            ROR: 'ROR',                                 // Desplazamiento Circular a la Derecha
            TST: 'TST',                                 // Test
            /*-----------------------------------------------------------*/
            BFI: 'BFI',                                 // Insertar Campo
            BFXIL: 'BFXIL',                             // Insertar Campo con Desplazamiento
            CLS: 'CLS',                                 // Contar Bits a la Izquierda
            CLZ: 'CLZ',                                 // Contar Ceros a la Izquierda
            EXTR: 'EXTR',                               // Extraer Campo
            RBIT: 'RBIT',                               // Invertir Bits
            REV: 'REV',                                 // Revertir Bytes
            REV16: 'REV16',                             // Revertir Bytes de 16 bits
            REV32: 'REV32',                             // Revertir Bytes de 32 bits
            SBFIZ: 'SBFIZ',                             // Insertar Campo con Signo
            UBFIZ: 'UBFIZ',                             // Insertar Campo sin Signo
            SBFX: 'SBFX',                               // Extraer Campo con Signo
            UBFX: 'UBFX',                               // Extraer Campo sin Signo
            SXTB: 'SXTB',                               // Extender Signo de 8 bits
            SXTH: 'SXTH',                               // Extender Signo de 16 bits
            UXTB: 'UXTB',                               // Extender Cero de 8 bits
            UXTH: 'UXTH',                               // Extender Cero de 16 bits
            SXTW: 'SXTW',                               // Extender Signo de 32 bits
            /*-----------------------------------------------------------*/
            ADC: 'ADC',                                 // Suma con Acarreo
            ADCS: 'ADCS',                               // Suma con Acarreo y Flags
            ADD: 'ADD',                                 // Suma
            ADDS: 'ADDS',                               // Suma con Flags
            ADR: 'ADR',                                 // Direccion de Registro
            ADRP: 'ADRP',                               // Direccion de Registro de Pagina
            CMN: 'CMN',                                 // Comparar Negativo
            CMP: 'CMP',                                 // Comparar
            MADD: 'MADD',                               // Multiplicar y Añadir
            MNEG: 'MNEG',                               // Multiplicar y Negar
            MSUB: 'MSUB',                               // Multiplicar y Restar
            MUL: 'MUL',                                 // Multiplicar
            NEG: 'NEG',                                 // Negar
            NEGS: 'NEGS',                               // Negar con Flags
            NGC: 'NGC',                                 // Negar con Acarreo
            NGCS: 'NGCS',                               // Negar con Acarreo y Flags
            SBC: 'SBC',                                 // Restar con Acarreo
            SBCS: 'SBCS',                               // Restar con Acarreo y Flags
            SDIV: 'SDIV',                               // Division con Signo
            SMADDL: 'SMADDL',                           // Multiplicar y Añadir de 64 bits con Signo
            SMNEGL: 'SMNEGL',                           // Multiplicar y Negar de 64 bits con Signo
            SMSUBL: 'SMSUBL',                           // Multiplicar y Restar de 64 bits con Signo
            SMULH: 'SMULH',                             // Multiplicar de 64 bits con Signo
            SMULL: 'SMULL',                             // Multiplicar de 64 bits con Signo
            SUB: 'SUB',                                 // Restar
            SUBS: 'SUBS',                               // Restar con Flags
            UDIV: 'UDIV',                               // Division sin Signo
            UMADDL: 'UMADDL',                           // Multiplicar y Añadir de 64 bits sin Signo
            UMNEGL: 'UMNEGL',                           // Multiplicar y Negar de 64 bits sin Signo
            UMSUBL: 'UMSUBL',                           // Multiplicar y Restar de 64 bits sin Signo
            UMULH: 'UMULH',                             // Multiplicar de 64 bits sin Signo
            UMULL: 'UMULL'                              // Multiplicar de 64 bits sin Signo
            /*-----------------------------------------------------------*/
}