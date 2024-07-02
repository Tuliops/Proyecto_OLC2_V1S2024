start
    = list:(directive_section /  code_section  / comment / blank_line)* EOI 
// ************************************************** Directivas ************************************************** \\
directive_section
    = d:directive _* de:directive_exp? _* comment? "\n" exp:(expression)*
directive_exp
    = e:directive
    / i:identifier c:comma _* int:int
    / i:identifier c:comma _* "@" i2:identifier 
    / i:identifier c:comma _* string:string
    / i:identifier
directive
    = _* "." directive_name
directive_name
    = "align" 
    / "ascii" 
    / "asciz" 
    / "balign" 
    / "bss" 
    / "byte" 
    / "comm" 
    / "data" 
    / "double" 
    / "end" 
    / "equ"
    / "extern"
    / "file" 
    / "float" 
    / "global" 
    / "hword" 
    / "incbin" 
    / "include" 
    / "int" 
    / "long" 
    / "p2align" 
    / "quad" 
    / "section"
    / "set" 
    / "size" 
    / "skip" 
    / "space" 
    / "string" 
    / "text" 
    / "type" 
    / "word" 
    / "zero"

// ************************************************** Expresiones ************************************************** \\
expression
    = identifier equal value 
    / l:label _* "\n"? d:directive _* value (comma value)*  _* comment? "\n"?
    / l:label _* "\n"? d:directive _* i:identifier _* comment? "\n"?
    / blank_line
    / comment
// ************************************************** Sección de Código ************************************************** \\
code_section
    = (l:label _* comment? "\n")+ list:(instruction / blank_line / comment)+
// ************************************************** Instrucciones en ARM64 v8 ************************************************** \\
instruction
    = i:aadd_inst _* comment? "\n"? 
    / i:aclr_inst _* comment? "\n"? 
    / i:adc_inst _* comment? "\n"? 
    / i:add_inst _* comment? "\n"? 
    / i:adr_inst _* comment? "\n"? 
    / i:adrp_inst _* comment? "\n"? 
    / i:aeor_inst _* comment? "\n"? 
    / i:and_inst _* comment? "\n"? 
    / i:asr_inst _* comment? "\n"? 
    / i:at_inst _* comment? "\n"? 
    / i:bcc_inst _* comment? "\n"? 
    / i:bfi_inst _* comment? "\n"? 
    / i:bfxil_inst _* comment? "\n"? 
    / i:bic_inst _* comment? "\n"? 
    / i:blr_inst _* comment? "\n"? 
    / i:bl_inst _* comment? "\n"? 
    / i:brk_inst _* comment? "\n"? 
    / i:br_inst _* comment? "\n"? 
    / i:b_inst _* comment? "\n"? 
    / i:casbh_inst _* comment? "\n"? 
    / i:casp_inst _* comment? "\n"? 
    / i:cas_inst _* comment? "\n"? 
    / i:cbnz_inst _* comment? "\n"? 
    / i:cbz_inst _* comment? "\n"? 
    / i:ccmn_inst _* comment? "\n"? 
    / i:ccmp_inst _* comment? "\n"? 
    / i:cinc_inst _* comment? "\n"? 
    / i:cinv_inst _* comment? "\n"? 
    / i:clrex_inst _* comment? "\n"? 
    / i:cls_inst _* comment? "\n"? 
    / i:clz_inst _* comment? "\n"? 
    / i:cmn_inst _* comment? "\n"? 
    / i:cmp_inst _* comment? "\n"? 
    / i:cneg_inst _* comment? "\n"? 
    / i:crc32cx_inst _* comment? "\n"? 
    / i:crc32cw_inst _* comment? "\n"? 
    / i:crc32c_inst _* comment? "\n"? 
    / i:crc32w_inst _* comment? "\n"? 
    / i:crc32x_inst _* comment? "\n"? 
    / i:crc32_inst _* comment? "\n"? 
    / i:csetm_inst _* comment? "\n"? 
    / i:cset_inst _* comment? "\n"? 
    / i:csel_inst _* comment? "\n"? 
    / i:csinc_inst _* comment? "\n"? 
    / i:csinv_inst _* comment? "\n"? 
    / i:csneg_inst _* comment? "\n"? 
    / i:dmb_inst _* comment? "\n"? 
    / i:dsb_inst _* comment? "\n"? 
    / i:eon_inst _* comment? "\n"? 
    / i:eor_inst _* comment? "\n"? 
    / i:eret_inst _* comment? "\n"? 
    / i:extr_inst _* comment? "\n"? 
    / i:hvc_inst _* comment? "\n"? 
    / i:isb_inst _* comment? "\n"? 
    / i:ldaobh_inst _* comment? "\n"? 
    / i:ldao_inst _* comment? "\n"? 
    / i:ldaxrbh_inst _* comment? "\n"? 
    / i:ldaxr_inst _* comment? "\n"? 
    / i:ldaxp_inst _* comment? "\n"? 
    / i:ldnp_inst _* comment? "\n"? 
    / i:ldpsw_inst _* comment? "\n"? 
    / i:ldp_inst _* comment? "\n"? 
    / i:ldtrsbh_inst _* comment? "\n"? 
    / i:ldtrsw_inst _* comment? "\n"? 
    / i:ldtrbh_inst _* comment? "\n"? 
    / i:ldtr_inst _* comment? "\n"? 
    / i:ldursbh_inst _* comment? "\n"? 
    / i:ldursw_inst _* comment? "\n"? 
    / i:ldurbh_inst _* comment? "\n"? 
    / i:ldur_inst _* comment? "\n"? 
    / i:lsl_inst _* comment? "\n"? 
    / i:lsr_inst _* comment? "\n"? 
    / i:madd_inst _* comment? "\n"? 
    / i:mneg_inst _* comment? "\n"? 
    / i:movk_inst _* comment? "\n"? 
    / i:movn_inst _* comment? "\n"? 
    / i:movz_inst _* comment? "\n"? 
    / i:mov_inst _* comment? "\n"? 
    / i:msub_inst _* comment? "\n"? 
    / i:msr_inst _* comment? "\n"? 
    / i:mrs_inst _* comment? "\n"? 
    / i:mul_inst _* comment? "\n"? 
    / i:mvn_inst _* comment? "\n"? 
    / i:neg_inst _* comment? "\n"? 
    / i:ngc_inst _* comment? "\n"? 
    / i:nop_inst _* comment? "\n"? 
    / i:orn_inst _* comment? "\n"? 
    / i:orr_inst _* comment? "\n"? 
    / i:prfm_inst _* comment? "\n"? 
    / i:rbit_inst _* comment? "\n"? 
    / i:rev32_inst _* comment? "\n"? 
    / i:rev16_inst _* comment? "\n"? 
    / i:rev_inst _* comment? "\n"? 
    / i:ror_inst _* comment? "\n"? 
    / i:ret_inst _* comment? "\n"? 
    / i:sbc_inst _* comment? "\n"? 
    / i:sdiv_inst _* comment? "\n"? 
    / i:sev_inst _* comment? "\n"? 
    / i:sevl_inst _* comment? "\n"? 
    / i:smaddl_inst _* comment? "\n"? 
    / i:smc_inst _* comment? "\n"? 
    / i:smnegl_inst _* comment? "\n"? 
    / i:smsubl_inst _* comment? "\n"? 
    / i:smulh_inst _* comment? "\n"? 
    / i:smull_inst _* comment? "\n"? 
    / i:staobh_inst _* comment? "\n"? 
    / i:stao_inst _* comment? "\n"? 
    / i:stlxrbh_inst _* comment? "\n"? 
    / i:stlxr_inst _* comment? "\n"? 
    / i:stlxp_inst _* comment? "\n"? 
    / i:stlrbh_inst _* comment? "\n"? 
    / i:stlr_inst _* comment? "\n"? 
    / i:sturbh_inst _* comment? "\n"? 
    / i:stur_inst _* comment? "\n"? 
    / i:sttrbh_inst _* comment? "\n"? 
    / i:sttr_inst _* comment? "\n"? 
    / i:stnp_inst _* comment? "\n"? 
    / i:stp_inst _* comment? "\n"? 
    / i:svc_inst _* comment? "\n"? 
    / i:susxtbh_inst _* comment? "\n"? 
    / i:sxtw_inst _* comment? "\n"? 
    / i:swpbh_inst _* comment? "\n"? 
    / i:swp_inst _* comment? "\n"? 
    / i:tbnz_inst _* comment? "\n"? 
    / i:tbz_inst _* comment? "\n"?  
    / i:tst_inst _* comment? "\n"? 
    / i:udiv_inst _* comment? "\n"? 
    / i:umaddl_inst _* comment? "\n"? 
    / i:umnegl_inst _* comment? "\n"? 
    / i:umsubl_inst _* comment? "\n"? 
    / i:umulh_inst _* comment? "\n"? 
    / i:umull_inst _* comment? "\n"? 
    / i:wfe_inst _* comment? "\n"? 
    / i:wfi_inst _* comment? "\n"? 
    / i:yield_inst _* comment? "\n"? 
    / i:subfiz_inst _* comment? "\n"? 
    / i:subfx_inst _* comment? "\n"? 
    / i:sub_inst _* comment? "\n"? 
// ************************************************** ......................... ************************************************** \\    
// ************************************************** Instrucciones Aritméticas ************************************************** \\
// ************************************************** ......................... ************************************************** \\
// ************************************************** Suma con Acarreo (ADC{S}) ************************************************** \\
adc_inst
    = _* op:ADC c:cc? q:q? _ args:(rs64 comma rs64 comma rs64)
    / _* op:ADC c:cc? q:q? _ args:(rs32 comma rs32 comma rs32)
ADC
    = _* "adc"i ("s"i)? /*CASES: ADC, ADCS*/
// ************************************************** Suma (ADD{S}) ************************************************** \\
add_inst
    = _* op:ADD c:cc? q:q? _ args:(rs64 comma rs64 comma (op2_arithmetic / rs64 / imm))   
    / _* op:ADD c:cc? q:q? _ args:(rs32 comma rs32 comma (op2_arithmetic / rs32 / imm))
ADD
    = _* "add"i ("s"i)?/*CASES: ADD, ADDS*/
// ************************************************** Dirección de Etiqueta (ADR) ************************************************** \\
adr_inst
    = _* op:ADR c:cc? q:q? _ args:(rs64 comma rel) 
ADR
    = _* op:"adr"i
// ************************************************** Dirección de Página de Etiqueta (ADRP) ************************************************** \\
adrp_inst
    = _* op:ADRP c:cc? q:q? _ args:(rs64 comma rel)
ADRP
    = _* op:"adrp"i
// ************************************************** Comparar Negativo (CMN) ************************************************** \\
cmn_inst
    = _* op:CMN c:cc? q:q? _ args:(rs64 comma (op2_arithmetic / rs64 / imm))
    / _* op:CMN c:cc? q:q? _ args:(rs32 comma (op2_arithmetic / rs32 / imm)) 
CMN 
    = _* op:"cmn"i
// ************************************************** Comparar (CMP) ************************************************** \\
cmp_inst
    = _* op:CMP c:cc? q:q? _ args:(rs64 comma (op2_arithmetic / rs64 / imm))
    / _* op:CMP c:cc? q:q? _ args:(rs32 comma (op2_arithmetic / rs32 / imm))
CMP
    = _* op:"cmp"i
// ************************************************** Multiplicar y Sumar (MADD) ************************************************** \\
madd_inst
    = _* op:MADD c:cc? q:q? _ args:(rs64 comma rs64 comma rs64 comma rs64)
    / _* op:MADD c:cc? q:q? _ args:(rs32 comma rs32 comma rs32 comma rs32)
MADD
    = _* op:"madd"i
// ************************************************** Multiplicar y Negar (MNEG) ************************************************** \\
mneg_inst
    = _* op:MNEG c:cc? q:q? _ args:(rs64 comma rs64 comma rs64 comma rs64)
    / _* op:MNEG c:cc? q:q? _ args:(rs32 comma rs32 comma rs32 comma rs32)
MNEG    
    = _* op:"mneg"i
// ************************************************** Multiplicar y Restar (MSUB) ************************************************** \\
msub_inst
    = _* op:MSUB c:cc? q:q? _ args:(rs64 comma rs64 comma rs64 comma rs64)
    / _* op:MSUB c:cc? q:q? _ args:(rs32 comma rs32 comma rs32 comma rs32)
MSUB
    = _* op:"msub"i
// ************************************************** Multiplicar (MUL) ************************************************** \\
mul_inst
    = _* op:MUL c:cc? q:q? _ args:(rs64 comma rs64 comma rs64)
    / _* op:MUL c:cc? q:q? _ args:(rs32 comma rs32 comma rs32)
MUL
    = _* op:"mul"i
// ************************************************** Negar (NEG{S}) ************************************************** \\
neg_inst
    = _* op:NEG c:cc? q:q? _ args:(rs64 comma (op2_arithmetic / rs64 / imm))
    / _* op:NEG c:cc? q:q? _ args:(rs32 comma (op2_arithmetic / rs32 / imm))
NEG
    = _* "neg"i ("s"i)? /*CASES: NEG, NEGS*/
// ************************************************** Negar con Acarreo (NGC{S}) ************************************************** \\
ngc_inst
    = _* op:NGC c:cc? q:q? _ args:(rs64 comma rs64)
    
    / _* op:NGC c:cc? q:q? _ args:(rs32 comma rs32)
    
NGC
    = _* "ngc"i ("s"i)? /*CASES: NGC, NGCS*/
// ************************************************** Restar con Acarreo (SBC{S}) ************************************************** \\
sbc_inst
    = _* op:SBC c:cc? q:q? _ args:(rs64 comma rs64 comma rs64)
    / _* op:SBC c:cc? q:q? _ args:(rs32 comma rs32 comma rs32)   
SBC
    = _* "sbc"i ("s"i)? /*CASES: SBC, SBCS*/
// ************************************************** Dividir con Signo (SDIV) ************************************************** \\
sdiv_inst
    = _* op:SDIV c:cc? q:q? _ args:(rs64 comma rs64 comma rs64)
    / _* op:SDIV c:cc? q:q? _ args:(rs32 comma rs32 comma rs32)
SDIV
    = _* op:"sdiv"i
// ************************************************** Multiplicar y Sumar Largo con Signo (SMADDL) ************************************************** \\
smaddl_inst
    = _* op:SMADDL c:cc? q:q? _ args:(rs64 comma rs32 comma rs32 comma rs64)
SMADDL
    = _* op:"smaddl"i
// ************************************************** Multiplicar y Negar Largo con Signo (SMNEGL) ************************************************** \\
smnegl_inst
    = _* op:SMNEGL c:cc? q:q? _ args:(rs64 comma rs32 comma rs32)
SMNEGL
    = _* op:"smnegl"i
// ************************************************** Multiplicar y Restar Largo con Signo (SMSUBL) ************************************************** \\
smsubl_inst
    = _* op:SMSUBL c:cc? q:q? _ args:(rs64 comma rs32 comma rs32 comma rs64)
SMSUBL
    = _* op:"smsubl"i
// ************************************************** Multiplicar Alto con Signo (SMULH) ************************************************** \\
smulh_inst
    = _* op:SMULH c:cc? q:q? _ args:(rs64 comma rs64 comma rs64)
SMULH
    = _* op:"smulh"i
// ************************************************** Multiplicar Largo con Signo (SMULL) ************************************************** \\
smull_inst
    = _* op:SMULL c:cc? q:q? _ args:(rs64 comma rs32 comma rs32)
SMULL
    = _* op:"smull"i
// ************************************************** Restar (SUB{S}) ************************************************** \\
sub_inst
    = _* op:SUB c:cc? q:q? _ args:(rs64 comma rs64 comma (op2_arithmetic / rs64 / imm))
    / _* op:SUB c:cc? q:q? _ args:(rs32 comma rs32 comma (op2_arithmetic / rs32 / imm))
SUB
    = _* "sub"i ("s"i)? /*CASES: SUB, SUBS*/
// ************************************************** Dividir con Signo (UDIV) ************************************************** \\
udiv_inst
    = _* op:UDIV c:cc? q:q? _ args:(rs64 comma rs64 comma rs64)
    / _* op:UDIV c:cc? q:q? _ args:(rs32 comma rs32 comma rs32)
UDIV
    = _* op:"udiv"i
// ************************************************** Multiplicar y Sumar Largo con Signo (UMADDL) ************************************************** \\
umaddl_inst
    = _* op:UMADDL c:cc? q:q? _ args:(rs64 comma rs32 comma rs32 comma rs64)
UMADDL
    = _* op:"umaddl"i
// ************************************************** Multiplicar y Negar Largo con Signo (UMNEGL) ************************************************** \\
umnegl_inst
    = _* op:UMNEGL c:cc? q:q? _ args:(rs64 comma rs32 comma rs32)
UMNEGL
    = _* op:"umnegl"i
// ************************************************** Multiplicar y Restar Largo con Signo (UMSUBL) ************************************************** \\
umsubl_inst
    = _* op:UMSUBL c:cc? q:q? _ args:(rs64 comma rs32 comma rs32 comma rs64)
UMSUBL
    = _* op:"umsubl"i
// ************************************************** Multiplicar Alto con Signo (UMULH) ************************************************** \\
umulh_inst
    = _* op:UMULH c:cc? q:q? _ args:(rs64 comma rs64 comma rs64)
UMULH
    = _* op:"umulh"i
// ************************************************** Multiplicar Largo con Signo (UMULL) ************************************************** \\
umull_inst
    = _* op:UMULL c:cc? q:q? _ args:(rs64 comma rs32 comma rs32)
UMULL
    = _* op:"umull"i
// ************************************************** .................................... ************************************************** \\
// ************************************************** Instrucciones de Manipulación de Bit ************************************************** \\
// ************************************************** .................................... ************************************************** \\
// ************************************************** Inserción Campo de Bit (BFI) ************************************************** \\
bfi_inst
    = _* op:BFI c:cc? q:q? _ args:(rs64 comma rs64 comma imm comma imm)   
    / _* op:BFI c:cc? q:q? _ args:(rs32 comma rs32 comma imm comma imm)
BFI
    = _* op:"bfi"i
// ************************************************** Inserción Extendida de Campo de Bit (BFXIL) ************************************************** \\
bfxil_inst
    = _* op:BFXIL c:cc? q:q? _ args:(rs64 comma rs64 comma imm comma imm)
    / _* op:BFXIL c:cc? q:q? _ args:(rs32 comma rs32 comma imm comma imm)
BFXIL
    = _* op:"bfxil"i
// ************************************************** Recuento de Bits en Claro ************************************************** \\
cls_inst
    = _* op:CLS c:cc? q:q? _ args:(rs64 comma rs64)
    / _* op:CLS c:cc? q:q? _ args:(rs32 comma rs32)
CLS
    = _* op:"cls"i
// ************************************************** Recuento de Bits en Cero ************************************************** \\
clz_inst
    = _* op:CLZ c:cc? q:q? _ args:(rs64 comma rs64)
    / _* op:CLZ c:cc? q:q? _ args:(rs32 comma rs32)
CLZ
    = _* op:"clz"i
// ************************************************** Extracción de Campo de Bit (EXTR) ************************************************** \\
extr_inst
    = _* op:EXTR c:cc? q:q? _ args:(rs64 comma rs64 comma rs64 comma imm)
    / _* op:EXTR c:cc? q:q? _ args:(rs32 comma rs32 comma rs32 comma imm)
EXTR
    = _* op:"extr"i
// ************************************************** Inversión de Bits de Registro (RBIT) ************************************************** \\
rbit_inst
    = _* op:RBIT c:cc? q:q? _ args:(rs64 comma rs64)
    / _* op:RBIT c:cc? q:q? _ args:(rs32 comma rs32)
RBIT
    = _* op:"rbit"i
// ************************************************** Reversión de Bytes (REV) ************************************************** \\
rev_inst
    = _* op:REV c:cc? q:q? _ args:(rs64 comma rs64)
    / _* op:REV c:cc? q:q? _ args:(rs32 comma rs32)
REV
    = _* op:"rev"i
// ************************************************** Reversión de Mitad de Palabra (16 bits) (REV16) ************************************************** \\
rev16_inst
    = _* op:REV16 c:cc? q:q? _ args:(rs64 comma rs64)
    / _* op:REV16 c:cc? q:q? _ args:(rs32 comma rs32)
REV16
    = _* op:"rev16"i
// ************************************************** Reversión de Mitad de Palabra (REV32) ************************************************** \\
rev32_inst
    = _* op:REV32 c:cc? q:q? _ args:(rs64 comma rs64)
REV32
    = _* op:"rev32"i
// ************************************************** Inserción de Ceros con Bandera ({S,U}BFIZ) ************************************************** \\
subfiz_inst
    = _* op:SUBFIZ c:cc? q:q? _ args:(rs64 comma rs64 comma imm comma imm)
    / _* op:SUBFIZ c:cc? q:q? _ args:(rs32 comma rs32 comma imm comma imm)
SUBFIZ
    = _* ("s"i/ "u"i) "bfiz"i /*CASES: SBFIZ, UBFIZ*/
// ************************************************** Extracción de Campo de Bits con Bandera ({S,U}BFX) ************************************************** \\
subfx_inst
    = _* op:SUBFX c:cc? q:q? _ args:(rs64 comma rs64 comma imm comma imm)
    / _* op:SUBFX c:cc? q:q? _ args:(rs32 comma rs32 comma imm comma imm)
SUBFX
    = _* ("s"i/ "u"i) "bfx"i /*CASES: SBFX, UBFX*/
// ************************************************** Extensión con Signo o Cero ({S,U}XT{B,H}) ************************************************** \\
susxtbh_inst
    = _* op:SUSXTBH c:cc? q:q? _ args:(rs64 comma rs32)
SUSXTBH
    = _* ("s"i/ "u"i) "xt"i ("b"i/ "h"i) /*CASES: SXTB, UXTB, SXTH, UXTH*/
// ************************************************** Extensión con Signo de Palabra (SXTW) ************************************************** \\
sxtw_inst
    = _* op:SXTW c:cc? q:q? _ args:(rs64 comma rs32)
SXTW
    = _* op:"sxtw"i
// ************************************************** ..................................... ************************************************** \\
// ************************************************** Instrucciones Lógicas y de Movimiento ************************************************** \\
// ************************************************** ..................................... ************************************************** \\
// ************************************************** Operación lógica AND (AND{S}) ************************************************** \\
and_inst
    = _* op:AND c:cc? q:q? _ args:(rs64 comma rs64 comma (op2_logic / rs64 / mask))
    / _* op:AND c:cc? q:q? _ args:(rs32 comma rs32 comma (op2_logic / rs32 / mask))
AND
    = _* "and"i ("s"i)? /*CASES: AND, ANDS*/
// ************************************************** Desplazamiento Aritmético hacia la Derecha (ASR) ************************************************** \\
asr_inst
    = _* op:ASR c:cc? q:q? _ args:(rs64 comma rs64 comma (rs64 / imm))
    / _* op:ASR c:cc? q:q? _ args:(rs32 comma rs32 comma (rs32 / imm))
ASR
    = _* op:"asr"i
// ************************************************** Borrar Bits (BIC{S}) ************************************************** \\
bic_inst
    = _* op:BIC c:cc? q:q? _ args:(rs64 comma rs64 comma (op2_logic / rs64))
    / _* op:BIC c:cc? q:q? _ args:(rs32 comma rs32 comma (op2_logic / rs32))
BIC
    = _* "bic"i ("s"i)? /*CASES: BIC, BICS*/
// ************************************************** Operación lógica EOR-AND (EON) ************************************************** \\
eon_inst
    = _* op:EON c:cc? q:q? _ args:(rs64 comma rs64 comma (op2_logic / rs64))
    / _* op:EON c:cc? q:q? _ args:(rs32 comma rs32 comma (op2_logic / rs32))
EON
    = _* op:"eon"i
// ************************************************** Operación lógica EOR (OR exclusivo) (EOR) ************************************************** \\
eor_inst
    = _* op:EOR c:cc? q:q? _ args:(rs64 comma rs64 comma (op2_logic / rs64 / mask))
    / _* op:EOR c:cc? q:q? _ args:(rs32 comma rs32 comma (op2_logic / rs32 / mask))
EOR
    = _* op:"eor"i
// ************************************************** Desplazamiento Lógico hacia la Izquierda (LSL) ************************************************** \\
lsl_inst
    = _* op:LSL c:cc? q:q? _ args:(rs64 comma rs64 comma (rs64 / imm))
    / _* op:LSL c:cc? q:q? _ args:(rs32 comma rs32 comma (rs32 / imm))
LSL
    = _* op:"lsl"i
// ************************************************** Desplazamiento Lógico hacia la Derecha (LSR) ************************************************** \\
lsr_inst
    = _* op:LSR c:cc? q:q? _ args:(rs64 comma rs64 comma (rs64 / imm))
    / _* op:LSR c:cc? q:q? _ args:(rs32 comma rs32 comma (rs32 / imm))
LSR
    = _* op:"lsr"i
// ************************************************** Movimiento de Datos (MOV) ************************************************** \\
mov_inst
    = _* op:MOV c:cc? q:q? _ args:(rs64 comma (rs64 / imm))
    / _* op:MOV c:cc? q:q? _ args:(rs32 comma (rs32 / imm))
MOV
    = _* op:"mov"i
// ************************************************** Mover Inmediato con Complemento (MOVK) ************************************************** \\
movk_inst
    = _* op:MOVK c:cc? q:q? _ args:(rs64 comma imm (comma sh)?)
    / _* op:MOVK c:cc? q:q? _ args:(rs32 comma imm (comma sh)?)
MOVK
    = _* op:"movk"i
// ************************************************** Mover Inmediato Negativo (MOVN) ************************************************** \\
movn_inst
    = _* op:MOVN c:cc? q:q? _ args:(rs64 comma imm (comma sh)?)
    / _* op:MOVN c:cc? q:q? _ args:(rs32 comma imm (comma sh)?)
MOVN
    = _* op:"movn"i
// ************************************************** Mover Inmediato con Ceros (MOVZ) ************************************************** \\
movz_inst
    = _* op:MOVZ c:cc? q:q? _ args:(rs64 comma imm (comma sh)?)
    / _* op:MOVZ c:cc? q:q? _ args:(rs32 comma imm (comma sh)?)
MOVZ
    = _* op:"movz"i
// ************************************************** NOT de Bits (MVN) ************************************************** \\
mvn_inst
    = _* MVN cc? q? _ rs64 comma (op2_logic / rs64)
    / _* op:MVN c:cc? q:q? _ args:(rs32 comma (op2_logic / rs32))
MVN
    = _* op:"mvn"i
// ************************************************** Operación lógica OR-NOT (ORN) ************************************************** \\
orn_inst
    = _* op:ORN c:cc? q:q? _ args:(rs64 comma rs64 comma (op2_logic / rs64))
    / _* op:ORN c:cc? q:q? _ args:(rs32 comma rs32 comma (op2_logic / rs32))
ORN
    = _* op:"orn"i
// ************************************************** Operación lógica OR (ORR) ************************************************** \\
orr_inst
    = _* op:ORR c:cc? q:q? _ args:(rs64 comma rs64 comma (op2_logic / rs64 / mask))
    / _* op:ORR c:cc? q:q? _ args:(rs32 comma rs32 comma (op2_logic / rs32 / mask))
ORR
    = _* op:"orr"i
// ************************************************** Rotación hacia la Derecha (ROR) ************************************************** \\
ror_inst
    = _* op:ROR c:cc? q:q? _ args:(rs64 comma rs64 comma (rs64 / imm))
    / _* op:ROR c:cc? q:q? _ args:(rs32 comma rs32 comma (rs32 / imm))
ROR
    = _* op:"ror"i
// ************************************************** Test de bits (TST) ************************************************** \\
tst_inst
    = _* op:TST c:cc? q:q? _ args:(rs64 comma (op2_logic / rs64 / mask))
    / _* op:TST c:cc? q:q? _ args:(rs32 comma (op2_logic / rs32 / mask))
TST
    = _* op:"tst"i
// ************************************************** ..................... ************************************************** \\
// ************************************************** Instrucciones de Rama ************************************************** \\
// ************************************************** ..................... ************************************************** \\
// ************************************************** Rama Incondicional (B) ************************************************** \\
b_inst
    = _* op:B c:cc? q:q? _ a:rel
B
    = _* op:"b"i
// ************************************************** Rama Condicional (Bcc) ************************************************** \\
bcc_inst
    = _* op:BCC c:cc? q:q? _ a:rel
BCC
    = _* op:"bcc"i
// ************************************************** Rama con Enlace (BL) ************************************************** \\
bl_inst
    = _* op:BL c:cc? q:q? _ a:rel
BL
    = _* op:"bl"i
// ************************************************** Rama con enlace Indirecto (BLR) ************************************************** \\
blr_inst
    = _* op:BLR c:cc? q:q? _ a:rs64
    / _* op:BLR c:cc? q:q? _ a:rs32
BLR
    = _* op:"blr"i
// ************************************************** Rama a Registro (BR) ************************************************** \\
br_inst
    = _* op:BR c:cc? q:q? _ a:rs64
    / _* op:BR c:cc? q:q? _ a:rs32
BR
    = _* op:"br"i
// ************************************************** Compare y Rama si no es Cero (CBNZ) ************************************************** \\
cbnz_inst
    = _* op:CBNZ c:cc? q:q? _ args:(rs64 comma rel)
    / _* op:CBNZ c:cc? q:q? _ args:(rs32 comma rel)
CBNZ
    = _* op:"cbnz"i
// ************************************************** Compare y Rama si es Cero (CBZ) ************************************************** \\
cbz_inst
    = _* op:CBZ c:cc? q:q? _ args:(rs64 comma rel)
    / _* op:CBZ c:cc? q:q? _ args:(rs32 comma rel)
CBZ
    = _* op:"cbz"i
// ************************************************** Retorno ************************************************** \\
ret_inst
    = _* op:RET c:cc? q:q? args:(_ (rs64 / rs32))?
RET
    = _* op:"ret"i
// **************************************************  Test bit y Rama si no es cero (TBNZ) ************************************************** \\
tbnz_inst
    = _* op:TBNZ c:cc? q:q? _ args:(rs64 comma imm comma rel)
    / _* op:TBNZ c:cc? q:q? _ args:(rs32 comma imm comma rel)
TBNZ
    = _* op:"tbnz"i
// ************************************************** Test bit y Rama si es cero (TBZ) ************************************************** \\
tbz_inst
    = _* op:TBZ c:cc? q:q? _ args:(rs64 comma imm comma rel)
    / _* op:TBZ c:cc? q:q? _ args:(rs32 comma imm comma rel)
TBZ
    = _* op:"tbz"i
// ************************************************** ........................... ************************************************** \\
// ************************************************** Instrucciones Condicionales ************************************************** \\
// ************************************************** ........................... ************************************************** \\
// ************************************************** Comparar y Condicionalmente Modificar (CCMN) ************************************************** \\
ccmn_inst
    = _* op:CCMN c:cc? q:q? _ args:(rs64 comma (rs64/ imm) comma imm comma _* cc)
    / _* op:CCMN c:cc? q:q? _ args:(rs32 comma (rs32 / imm) comma imm comma _* cc)
CCMN
    = _* op:"ccmn"i
// ************************************************** Comparar y condicionalmente modificar (CCMP) ************************************************** \\
ccmp_inst
    = _* op:CCMP c:cc? q:q? _ args:(rs64 comma (rs64 / imm) comma imm comma _* cc)
    / _* op:CCMP c:cc? q:q? _ args:(rs32 comma (rs32 / imm) comma imm comma _* cc) 
CCMP
    = _* op:"ccmp"i
// ************************************************** Incremento condicional (CINC) ************************************************** \\
cinc_inst
    = _* op:CINC c:cc? q:q? _ args:(rs64 comma rs64 comma _* cc)
    / _* op:CINC c:cc? q:q? _ args:(rs32 comma rs32 comma _* cc)
CINC
    = _* op:"cinc"i
// ************************************************** Inversión condicional (CINV) ************************************************** \\
cinv_inst
    = _* op:CINV c:cc? q:q? _ args:(rs64 comma rs64 comma _* cc)
    / _* op:CINV c:cc? q:q? _ args:(rs32 comma rs32 comma _* cc)
CINV
    = _* op:"cinv"i
// ************************************************** Negación condicional (CNEG) ************************************************** \\
cneg_inst
    = _* op:CNEG c:cc? q:q? _ args:(rs64 comma rs64 comma _* cc)
    / _* op:CNEG c:cc? q:q? _ args:(rs32 comma rs32 comma _* cc) 
CNEG
    = _* op:"cneg"i
// ************************************************** Selección Condicional (CSEL) ************************************************** \\
csel_inst
    = _* op:CSEL c:cc? q:q? _ args:(rs64 comma rs64 comma rs64 comma _* cc)
    / _* op:CSEL c:cc? q:q? _ args:(rs32 comma rs32 comma rs32 comma _* cc)
CSEL
    = _* op:"csel"i
// ************************************************** Establecer condicional (CSET) ************************************************** \\
cset_inst
    = _* op:CSET c:cc? q:q? _ args:(rs64 comma _* cc)
    / _* op:CSET c:cc? q:q? _ args:(rs32 comma _* cc)
CSET
    = _* op:"cset"i
// ************************************************** Establecer a máscara condicional (CSETM) ************************************************** \\
csetm_inst
    = _* op:CSETM c:cc? q:q? _ args:(rs64 comma _* cc)
    / _* op:CSETM c:cc? q:q? _ args:(rs32 comma _* cc)
CSETM
    = _* op:"csetm"i
// ************************************************** Incremento condicional selectivo (CSINC) ************************************************** \\
csinc_inst
    = _* op:CSINC c:cc? q:q? _ args:(rs64 comma rs64 comma rs64 comma _* cc)
    / _* op:CSINC c:cc? q:q? _ args:(rs32 comma rs32 comma rs32 comma _* cc)
CSINC
    = _* op:"csinc"i
// ************************************************** Inversión condicional selectiva (CSINV) ************************************************** \\
csinv_inst
    = _* op:CSINV c:cc? q:q? _ args:(rs64 comma rs64 comma rs64 comma _* cc)
    / _* op:CSINV c:cc? q:q? _ args:(rs32 comma rs32 comma rs32 comma _* cc)
CSINV
    = _* op:"csinv"i
// ************************************************** Negación condicional selectiva (CSNEG) ************************************************** \\
csneg_inst
    = _* op:CSNEG c:cc? q:q? _ args:(rs64 comma rs64 comma rs64 comma _* cc)
    / _* op:CSNEG c:cc? q:q? _ args:(rs32 comma rs32 comma rs32 comma _* cc)
CSNEG
    = _* op:"csneg"i
// ************************************************** ....................................... ************************************************** \\
// ************************************************** Instrucciones de Carga y Almacenamiento ************************************************** \\
// ************************************************** ....................................... ************************************************** \\ 
// ************************************************** Cargar Par de Registros (LDP) ************************************************** \\
ldp_inst
    = _* op:LDP c:cc? q:q? _ args:(rs64 comma rs64 comma addr)
    / _* op:LDP c:cc? q:q? _ args:(rs32 comma rs32 comma addr)
LDP
    = _* op:"ldp"i
// ************************************************** Cargar Par de Palabras con Signo (LDPSW) ************************************************** \\
ldpsw_inst
    = _* op:LDPSW c:cc? q:q? _ args:(rs64 comma rs64 comma addr)
    / _* op:LDPSW c:cc? q:q? _ args:(rs32 comma rs32 comma addr)
LDPSW
    = _* op:"ldpsw"i
// ************************************************** Cargar Registro (LD{U}R) ************************************************** \\
ldur_inst
    = _* op:LDUR c:cc? q:q? _ args:(rs64 comma addr)
    / _* op:LDUR c:cc? q:q? _ args:(rs32 comma addr)
LDUR
    = _* "ld"i "u"i? "r"i /*CASES: LDUR, LDR'*/
// ************************************************** Cargar Registro Byte, Cargar Registro Media Palabra (LD{U}R{B,H}) ************************************************** \\
ldurbh_inst
    = _* op:LDURBH c:cc? q:q? _ args:(rs64 comma addr)
    / _* op:LDURBH c:cc? q:q? _ args:(rs32 comma addr)
LDURBH
    = _* "ld"i "u"i? "r"i ("b"i/ "h"i) /*CASES: LDURB, LDRB, LDURH, LDRH'*/
// ************************************************** Cargar Registro Byte con Signo, Cargar Registro Media Palabra con Signo (LD{U}RS{B,H}) ************************************************** \\
ldursbh_inst
    = _* op:LDURSBH c:cc? q:q? _ args:(rs64 comma addr)
    / _* op:LDURSBH c:cc? q:q? _ args:(rs32 comma addr)
LDURSBH
    = _* "ld"i "u"i? "rs"i ("b"i/ "h"i) /*CASES: LDURSB, LDRSB, LDURSH, LDRSH'*/
// ************************************************** Cargar Registro Palabra con Signo (LD{U}RSW) ************************************************** \\
ldursw_inst
    = _* op:LDURSW c:cc? q:q? _ args:(rs64 comma addr)
    / _* op:LDURSW c:cc? q:q? _ args:(rs32 comma addr)
LDURSW
    = _* "ld"i "u"i? "rsw"i /*CASES: LDURSW, LDRSW'*/
// ************************************************** Precargar Datos (PRFM) ************************************************** \\
prfm_inst
    = _* op:PRFM c:cc? q:q? _ args:prfop
PRFM  
    = _* op:"prfm"i
// ************************************************** Almacenar Par de Registros (STP) ************************************************** \\
stp_inst
    = _* op:STP c:cc? q:q? _ args:(rs64 comma rs64 comma addr)
    / _* op:STP c:cc? q:q? _ args:(rs32 comma rs32 comma addr)
STP
    = _* op:"stp"i
// ************************************************** Almacenar Registro (ST{U}R) ************************************************** \\
stur_inst
    = _* op:STUR c:cc? q:q? _ args:((rs64 / rs32) comma addr)
STUR
    = _* "st"i "u"i? "r"i /*CASES: STUR, STR'*/
// ************************************************** Almacenar Registro Byte, Almacenar Registro Media Palabra (ST{U}R{B,H}) ************************************************** \\
sturbh_inst
    = _* op:STURBH c:cc? q:q? _ args:(rs64 comma addr)
    / _* op:STURBH c:cc? q:q? _ args:(rs32 comma addr)
STURBH
    = _* "st"i "u"i? "r"i ("b"i/ "h"i) /*CASES: STURB, STURH, STRB, STRH'*/
// ************************************************** ...................... ************************************************** \\
// ************************************************** Instrucciones Atómicas ************************************************** \\
// ************************************************** ...................... ************************************************** \\
// ************************************************** Comparar y almacenar condicionalmente (CAS{A}{L}) ************************************************** \\
cas_inst
    = _* op:CAS c:cc? q:q? _ args:(rs64 comma rs64 comma rs64 comma lbracket rs64 rbracket)
    / _* op:CAS c:cc? q:q? _ args:(rs32 comma rs32 comma rs32 comma lbracket rs64 rbracket)
CAS
    = _* "cas"i "a"i? "l"i?
// ************************************************** Comparar y almacenar condicionalmente extendido (CASP{A}{L}{B,H}) ************************************************** \\
casbh_inst
    = op:CASPBH c:cc? q:q? _ args:(rs32 comma rs32 comma rs32 comma lbracket rs64 rbracket)
CASPBH
    = _* "casp"i "a"i? "l"i? ("b"i/ "h"i)?
// ************************************************** Comparar y almacenar condicionalmente con predicción (CAS{A}{L}P) ************************************************** \\
casp_inst
    = _* op:CASP c:cc? q:q? _ args:(rs64 comma rs64 comma rs64 comma rs64 comma lbracket rs64 rbracket)
    / _* op:CASP c:cc? q:q? _ args:(rs32 comma rs32 comma rs32 comma rs32 comma lbracket rs64 rbracket)
CASP
    = _* "cas" "a"i? "l"i? "p"i
// ************************************************** Carga atómica con operación (LDao{A}{L}{B,H}) ************************************************** \\
ldaobh_inst
    = op:LDAOBH c:cc? q:q? _ args:(rs32 comma rs32 comma lbracket rs64 rbracket)
LDAOBH
    = _* "ldao"i "a"i? "l"i? ("b"i/ "h"i)?
// ************************************************** Carga atómica y opera (LDao{A}{L}) ************************************************** \\
ldao_inst
    = op:LDAO c:cc? q:q? _ args:(rs64 comma rs64 comma lbracket rs64 rbracket)
    / op:LDAO c:cc? q:q? _ args:(rs32 comma rs32 comma lbracket rs64 rbracket)
LDAO
    = _* "ldao"i "a"i? "l"i?
// ************************************************** Almacenamiento atómico con operación (STao{A}{L}{B,H}) ************************************************** \\
staobh_inst
    = op:STAOBH c:cc? q:q? _ args:(rs32 comma rs32 comma lbracket rs64 rbracket)
STAOBH
    = _* "stao"i "a"i? "l"i? ("b"i/ "h"i)?
// ************************************************** Almacenamiento atómico y opera (STao{A}{L}) ************************************************** \\
stao_inst
    = op:STAO c:cc? q:q? _ args:(rs64 comma rs64 comma lbracket rs64 rbracket)
    / op:STAO c:cc? q:q? _ args:(rs32 comma rs32 comma lbracket rs64 rbracket)
STAO
    = _* "stao"i "a"i? "l"i?
// ************************************************** Intercambio atómico extendido (SWP{A}{L}{B,H}) ************************************************** \\
swpbh_inst
    = op:SWPBH c:cc? q:q? _ args:(rs32 comma rs32 comma rs32 comma lbracket rs64 rbracket)
SWPBH
    = _* "swp"i "a"i? "l"i? ("b"i/ "h"i)?
// ************************************************** Intercambio atómico (SWP{A}{L}) ************************************************** \\
swp_inst
    = op:SWP c:cc? q:q? _ args:(rs64 comma rs64 comma rs64 comma lbracket rs64 rbracket)
    / op:SWP c:cc? q:q? _ args:(rs32 comma rs32 comma rs32 comma lbracket rs64 rbracket)
SWP
    = _* "swp"i "a"i? "l"i?
// ************************************************** ........................... ************************************************** \\
// ************************************************** Instrucciones Atómicas (ao) ************************************************** \\
// ************************************************** ........................... ************************************************** \\
// ************************************************** Sumar y obtener el máximo condiciona (ADD) ************************************************** \\
aadd_inst
    = _* op:AADD c:cc? q:q? _ args:(lbracket rs64 rbracket plus (rs64 / rs32))
AADD
    = _* op:"add"i
// ************************************************** Limpiar y obtener el mínimo condicional (CLR) ************************************************** \\
aclr_inst
    = _* op:ACLR c:cc? q:q? _ args:(lbracket rs64 rbracket y neg (rs64 / rs32))
ACLR
    = _* op:"clr"i
// ************************************************** Operación XOR y obtener el máximo sin signo condicional (EOR) ************************************************** \\
aeor_inst
    = _* op:AEOR c:cc? q:q? _ args:(lbracket rs64 rbracket xor (rs64 / rs32))
AEOR
    = _* op:"eor"i
// ************************************************** Establecer (SET) ************************************************** \\
aset_inst
    = _* op:ASET c:cc? q:q? _ args:(lbracket rs64 rbracket o (rs64 / rs32))
ASET
    = _* op:"set"i
// ************************************************** ..................................... ************************************************** \\
// ************************************************** Instrucciones de Suma de Comprobación ************************************************** \\
// ************************************************** ..................................... ************************************************** \\
// ************************************************** Cálculo de la suma de Comprobación (CRC32{B,H}) ************************************************** \\
crc32_inst
    = _* op:CRC32 c:cc? q:q? _ args:(rs32 comma rs32 comma rs32)
CRC32
    = _* "crc32"i ("b"i / "h"i)? /*CASES: CRC32, CRC32B, CRC32H*/
// ************************************************** Cálculo de la suma de Comprobación con Palabra (CRC32W) ************************************************** \\
crc32w_inst
    = _* op:CRC32W c:cc? q:q? _ args:(rs32 comma rs32 comma rs32)
CRC32W
    = _* op:"crc32w"i
// ************************************************** Cálculo de la suma de Comprobación Extendido (CRC32X) ************************************************** \\
crc32x_inst
    = _* op:CRC32X c:cc? q:q? _ args:(rs32 comma rs32 comma rs64)
CRC32X
    = _* op:"crc32x"i
// ************************************************** Cálculo de la suma de Comprobación C (CRC32C{B,H}) ************************************************** \\
crc32c_inst
    = _* op:CRC32C c:cc? q:q? _ args:(rs32 comma rs32 comma rs32)
CRC32C
    = _* "crc32c"i ("b"i / "h"i)? /*CASES: CRC32C, CRC32CB, CRC32CH*/
// ************************************************** Cálculo de la suma de Comprobación con Palabra (CRC32CW) ************************************************** \\
crc32cw_inst
    = _* op:CRC32CW c:cc? q:q? _ args:(rs32 comma rs32 comma rs32)
CRC32CW
    = _* op:"crc32cw"i
// ************************************************** Cálculo de la suma de Comprobación Extendido C (CRC32CX) ************************************************** \\
crc32cx_inst
    = _* op:CRC32CX c:cc? q:q? _ args:(rs32 comma rs32 comma rs64)
CRC32CX
    = _* op:"crc32cx"i
// ************************************************** .................................................... ************************************************** \\
// ************************************************** Instrucciones de Carga y Almacenamiento con Atributo ************************************************** \\
// ************************************************** .................................................... ************************************************** \\
// ************************************************** Carga exclusiva con atributos (LD{A}XP) ************************************************** \\
ldaxp_inst
    = _* op:LDAXP c:cc? q:q? _ args:(rs64 comma rs64 comma lbracket rs64 rbracket)
    / _* op:LDAXP c:cc? q:q? _ args:(rs32 comma rs32 comma lbracket rs64 rbracket)
LDAXP
    = _* "ld"i "a"i? "xp"i /*CASES: LDAXP, LDXP*/
// ************************************************** Carga exclusiva con registro extendido (LD{A}{X}R) ************************************************** \\
ldaxr_inst
    = _* op:LDAXR c:cc? q:q? _ args:((rs64 / rs32) comma lbracket rs64 rbracket)
LDAXR
    = _* "ld"i "a"i? "x"i? "r"i /*CASES: LDR, LDAR, LDAXR, LDAXR*/
// ************************************************** Carga exclusiva con registro extendido byte/media palabra (LD{A}{X}R{B,H}) ************************************************** \\
ldaxrbh_inst
    = _* op:LDAXRBH c:cc? q:q? _ args:(rs32 comma lbracket rs64 rbracket)
LDAXRBH
    = _* "ld"i "a"i? "x"i? "r"i ("b"i/ "h"i)? /*CASES: LDAXRB, LDAXRH, LDRB, LDRH, LDR*/
// ************************************************** Carga no post-incrementada (LDNP) ************************************************** \\
ldnp_inst
    = _* op:LDNP c:cc? q:q? _ args:(rs64 comma rs64 comma addr)
    / _* op:LDNP c:cc? q:q? _ args:(rs32 comma rs32 comma addr) 
LDNP
    = _* op:"ldnp"i
// ************************************************** Carga con traducción (LDTR) ************************************************** \\
ldtr_inst
    = _* op:LDTR c:cc? q:q? _ args:((rs64 / rs32) comma addr)
LDTR
    = _* op:"ldtr"i
// ************************************************** Carga con traducción byte/media palabra (LDTR{B,H}) ************************************************** \\
ldtrbh_inst
    = _* op:LDTRBH c:cc? q:q? _ args:(rs32 comma addr)
LDTRBH
    = _* "ldtr"i ("b"i/ "h"i)? /*CASES: LDTRB, LDTRH, LDTR*/
// ************************************************** Carga con traducción y signo byte/media palabra (LDTRS{B,H}) ************************************************** \\
ldtrsbh_inst
    = _* op:LDTRSBH c:cc? q:q? _ args:((rs64 / rs32) comma addr)
LDTRSBH
    = _* "ldtrs"i ("b"i/ "h"i)? /*CASES: LDTRSB, LDTRSH, LDTRS*/
// ************************************************** Carga con traducción y signo palabra (LDTRSW) ************************************************** \\
ldtrsw_inst
    = _* op:LDTRSW c:cc? q:q? _ args:(rs64 comma addr)
LDTRSW
    = _* op:"ldtrsw"i
// ************************************************** Almacenamiento con registro de lectura exclusiva (STLR) ************************************************** \\
stlr_inst
    = _* op:STLR c:cc? q:q? _ args:((rs64 / rs32) comma lbracket rs64 rbracket)
STLR
    = _* op:"stlr"i
// ************************************************** Almacenamiento con registro de lectura exclusiva byte/media palabra (STLR{B,H}) ************************************************** \\
stlrbh_inst
    = _* op:STLRBH c:cc? q:q? _ args:(rs32 comma lbracket rs64 rbracket)
STLRBH
    = _* "stlr"i ("b"i/ "h"i)? /*CASES: STLRB, STLRH, STLR*/
// ************************************************** Almacenamiento exclusivo con atributos (ST{L}XP) ************************************************** \\
stlxp_inst
    = _* op:STLXP c:cc? q:q? _ args:(rs32 comma rs64 comma rs64 comma lbracket rs64 rbracket)
    / _* op:STLXP c:cc? q:q? _ args:(rs32 comma rs32 comma rs32 comma lbracket rs64 rbracket)
STLXP
    = _* "st"i "l"i? "xp"i /*CASES: STLXP, STXP*/
// ************************************************** Almacenamiento exclusivo con registro extendido (ST{L}XR) ************************************************** \\
stlxr_inst
    = _* op:STLXR c:cc? q:q? _ args:(rs32 comma (rs64 / rs32) comma lbracket rs64 rbracket)
STLXR
    = _* "st"i "l"i? "xr"i /*CASES: STLXR, STXR*/
// ************************************************** Almacenamiento exclusivo con registro extendido byte/media palabra (ST{L}XR{B,H}) ************************************************** \\
stlxrbh_inst
    = _* op:STLXRBH c:cc? q:q? _ args:(rs32 comma rs32 comma lbracket rs64 rbracket)
STLXRBH
    = _* "st"i "l"i? "xr"i ("b"i/ "h"i) /*CASES: STLXRB, STLXRH, STXRB, STXRH*/
// ************************************************** Almacenamiento no post-incrementado (STNP) ************************************************** \\
stnp_inst
    = _* op:STNP c:cc? q:q? _ args:(rs64 comma rs64 comma addr)
    / _* op:STNP c:cc? q:q? _ args:(rs32 comma rs32 comma addr)
STNP
    = _* op:"stnp"i
// ************************************************** Almacenamiento con traducción (STTR) ************************************************** \\
sttr_inst
    = _* op:STTR c:cc? q:q? _ args:((rs64 / rs32) comma addr)
STTR
    = _* op:"sttr"i
// ************************************************** Almacenamiento con traducción byte/media palabra (STTR{B,H}) ************************************************** \\
sttrbh_inst
    = _* op:STTRBH c:cc? q:q? _ args:(rs32 comma addr)
STTRBH
    = _* "sttr"i ("b"i/ "h"i) /*CASES: STTRB, STTRH, STTR*/
// ************************************************** ........................ ************************************************** \\
// ************************************************** Instrucciones de Sistema ************************************************** \\
// ************************************************** ........................ ************************************************** \\
// ************************************************** Atómico (AT) ************************************************** \\
at_inst
    = _* op:AT c:cc? q:q? _ args:(atsy comma rs64)  
AT
    = _* op:"at"i
// ************************************************** Punto de ruptura (BRK) ************************************************** \\
brk_inst
    = _* op:BRK c:cc? q:q? _ arg:imm
BRK
    = _* op:"brk"i
// ************************************************** Limpiar excepciones (CLREX {#i4}) ************************************************** \\
clrex_inst
    = _* op:CLREX c:cc? q:q? arg:imm?
CLREX
    = _* op:"clrex"i
// ************************************************** Barrera de memoria de dominio (DMB) ************************************************** \\
dmb_inst
    = _* op:DMB c:cc? q:q? _ arg:barrierop
DMB
    = _* op:"dmb"i
// ************************************************** Barrera de memoria de dominio (DSB) ************************************************** \\
dsb_inst
    = _* op:DSB c:cc? q:q? _ arg:barrierop
DSB
    = _* op:"dsb"i
// ************************************************** Retorno de excepción (ERET) ************************************************** \\
eret_inst
    = _* op:ERET c:cc? q:q?
ERET
    = _* op:"eret"i
// ************************************************** Llamada hipervisor (HVC #16) ************************************************** \\
hvc_inst
    = _* op:HVC c:cc? q:q? arg:imm
HVC
    = _* op:"hvc"i
// ************************************************** Barrera de sincronización de instrucciones (ISB {SY}) ************************************************** \\
isb_inst
    = _* op:ISB c:cc? q:q? arg:sy?
ISB
    = _* op:"isb"i
// ************************************************** Leer registro del sistema (MRS Xd, sysreg) ************************************************** \\
mrs_inst
    = _* op:MRS c:cc? q:q? _ args:(rs64 comma sysreg)
MRS
    = _* op:"mrs"i
// ************************************************** Escribir registro del sistema (MSR sysreg, Xn) ************************************************** \\
msr_inst
    = _* op:MSR c:cc? q:q? _ args:(sysregM comma imm)
    / _* op:MSR c:cc? q:q? _ args:(sysreg comma rs64)
MSR
    = _* op:"msr"i
// ************************************************** No operación (NOP) ************************************************** \\
nop_inst
    = _* op:NOP c:cc? q:q?
NOP
    = _* op:"nop"i
// ************************************************** Despertar evento (SEV) ************************************************** \\
sev_inst
    = _* op:SEV c:cc? q:q?
SEV
    = _* op:"sev"i
// ************************************************** Despertar evento con retardo (SEVL) ************************************************** \\
sevl_inst
    = _* op:SEVL c:cc? q:q? 
SEVL
    = _* op:"sevl"i
// ************************************************** Llamada segura al sistema (SMC #i16) ************************************************** \\
smc_inst
    = _* op:SMC c:cc? q:q? arg:imm
SMC
    = _* op:"smc"i
// ************************************************** Llamada al supervisor (SVC) ************************************************** \\
svc_inst
    = _* op:SVC c:cc? q:q? arg:imm
SVC
    = _* op:"svc"i
// ************************************************** Espera para evento (WFE) ************************************************** \\
wfe_inst
    = _* op:WFE c:cc? q:q?
WFE
    = _* op:"wfe"i
// ************************************************** Espera para interrupción (WFI) ************************************************** \\
wfi_inst
    = _* op:WFI c:cc? q:q?
WFI
    = _* op:"wfi"i
// ************************************************** Ceder (YIELD) ************************************************** \\
yield_inst
    = _* op:YIELD c:cc? q:q? 
YIELD
    = _* op:"yield"i
// ************************************************** SH ************************************************** \\
sh
    = _* op:shift _* h:"#"i? i:imm
// ************************************************** Operando 2 Aritmético ************************************************** \\    
op2_arithmetic
    = op:shift_op 
    / op:extend_op 
    / op:extend_xtx 
// ************************************************** Operando 2 Lógico ************************************************** \\
op2_logic
    = op:shift_op 
    / op:shift_ror_op 

// ************************************************** Mask ************************************************** \\
mask
    = i:imm
// ************************************************** ADDR ************************************************** \\
addr 
    = _* lbracket list:(rs64 comma (shift_op / extend_xtx_op / extend_op /rs64)) rbracket
    / _* list:(lbracket rs64 rbracket comma imm)
    / _* lbracket list:(rs64 (comma imm)? rbracket excl?)
    / _* rl:rel
// ************************************************** OPERACIONES ************************************************** \\
shift_op "Operacion de Desplazamiento"
    = r:(rs64 / rs32) comma op:shift i:imm
shift_ror_op "Operacion de Rotación"
    = r:(rs64 / rs32) comma op:shift_ror i:imm
extend_op "Operacion de Extensión"
    = r:rs32 comma op:extend i:imm
extend_xtx_op "Operacion de Extensión"
    = r:rs64 comma op:extend_xtx i:imm
// ************************************************** Desplazamiento Relativo ************************************************** \\
rel
    = rl:constant
    / rl:imm
// ************************************************** PRFOP ************************************************** \\
prfop
    = _* "pldl1keep"i  // Prefetch to L1 cache and keep
    / _* "pld1strm"i  // Prefetch to L1 cache and stream
    / _* "pld2keep"i  // Prefetch to L2 cache and keep
    / _* "pld2strm"i  // Prefetch to L2 cache and stream
    / _* "pldl3keep"i  // Prefetch to L3 cache and keep
    / _* "pld3strm"i  // Prefetch to L3 cache and stream
    / _* "pstl1keep"i  // Prefetch to L1 cache and keep
    / _* "pst1strm"i  // Prefetch to L1 cache and stream
    / _* "pstl2keep"i  // Prefetch to L2 cache and keep
    / _* "pst2strm"i  // Prefetch to L2 cache and stream
    / _* "pstl3keep"i  // Prefetch to L3 cache and keep
    / _* "pst3strm"i  // Prefetch to L3 cache and stream
    / _* "pli"i  // Prefetch to instruction cache
// ************************************************** BARRIEROP ************************************************** \\
barrierop
    = _* "osh"i _* (comma _* "ld"i / comma _* "st"i)?  // Outer Shareable, All/Load/Store
    / _* "nsh"i _* (comma _* "ld"i / comma _* "st"i)?  // Non-shareable, All/Load/Store
    / _* "ish"i _* (comma _* "ld"i / comma _* "st"i)?  // Inner Shareable, All/Load/Store
    / _* "ld"i  // Full system, Load
    / _* "st"i  // Full system, Store
    / _* "sy"i  // Full system

// ************************************************** Tipos de Desplazamiento y Rotaciones ************************************************** \\
shift
    = _* "lsl"i  // Logical Shift Left
    / _* "lsr"i  // Logical Shift Right
    / _* "asr"i  // Arithmetic Shift Right
shift_ror
    = _* "ror"i  // Rotate Right
shift_rrx
    = _* "rrx"i  // Rotate Right Extended
// ************************************************** Tipos de Extensión ************************************************** \\
extend
    = _* "uxtb"i  // Unsigned Extend Byte
    / _* "uxth"i  // Unsigned Extend Halfword
    / _* "uxtw"i  // Unsigned Extend Word
    / _* "sxtb"i  // Signed Extend Byte
    / _* "sxth"i  // Signed Extend Halfword
    / _* "sxtw"i  // Signed Extend Word
extend_xtx
    = _* "sxtx"i  // Signed Extend Doubleword
    / _* "uxtx"i  // Unsigned Extend Doubleword
// ************************************************** Registros y Registros Especiales ************************************************** \\
rs64
    = r:r64 
    / r:sp 
    / r:xzr
    / r:lr
    / r:fp 
    / r:pc 
    / r:spsr_el 
    / r:elr_el 
    / r:sp_el 
    / r:sps_el 
    / r:currentel 
    / r:daif 
    / r:nzcv 
    / r:fpcr 
    / r:fpsr 
rs32
    = r:r32 
    / r:wsp 
    / r:wzr 
// ************************************************** Registros de propósito general 64 bits ************************************************** \\
r64 "Registro_64_Bits"
    = _* "x"i ("30" / [12][0-9] / [0-9])
// ************************************************** Registros de propósito general 32 bits ************************************************** \\
r32 "Registro_32_Bits"
    = _* "w"i ("30" / [12][0-9] / [0-9])
//  ************************************************** Apuntador de Pila ************************************************** \\
sp "Apuntador_Pila"
    = _* "sp"i
wsp "Apuntador_Pila"
    = _* "wsp"i
// ************************************************** Zero Register ************************************************** \\
xzr "Zero_Register"
    = _* "xzr"i
wzr "Zero_Register"
    = _* "wzr"i
// ************************************************** Link Register ************************************************** \\
lr "Link_Register"
    = _* "lr"i
// ************************************************** Frame Pointer ************************************************** \\
fp "Frame_Pointer"
    = _* "fp"i
// ************************************************** Program Counter ************************************************** \\
pc "Program_Counter"
    = _* "pc"i
// ************************************************** sysreg ************************************************** \\
sysreg
    = r:sps_el 
    / r:elr_el 
    / r:spsr_el 
    / r:sp_el 
    / r:currentel 
    / r:daif 
    / r:nzcv 
    / r:fpcr 
    / r:fpsr 
    / r:pmcr 
    / r:pmcntenset 
    / r:pmcntenclr 
    / r:pmcnten 
    / r:pmovsclr 
    / r:pmswinc 
    / r:pmselr 
    / r:pmceid0 
    / r:pmceid1 
    / r:pmceid 
    / r:pmccntr 
    / r:pmxevtyper 
    / r:pmxevcntr 
    / r:pmuserenr 
    / r:pmovsset 
    / r:pmintenset 
    / r:pmintenclr 
    / r:pmevcntr 
    / r:pmevtyper 
    / r:pmccfiltr 
sysregM
    = r:daifset 
    / r:daifclr 
    / r:spsel 

// ************************************************** Registros con propósito especial ************************************************** \\
atsy
    = "s1"i "2"i? "e"i [0-3]? ("r"i / "w"i)? 
sy
    = _* "sy"i
spsr_el "Saved_Program_Status_Register_For_Exception_Level"
    = _* "spsr_el"i [1-3] 
elr_el "Exception_Link_Register_For_Exception_Level"
    = _* "elr_el"i [1-3] 
sp_el "Stack_Pointer_For_Exception_Level"
    = _* "sp_el"i [0-2] 
sps_el "SP_Selection" 
    = _* "spsel"i [0-3] 
currentel "Current_Exception_Level"
    = _* "currentel"i 
daif "Interrupt_Mask_Bits"
    = _* "daif"i 
nzcv "Condition_Flag_Register"
    = _* "nzcv"i 
fpcr "Floating_Point_Control_Register"
    = _* "fpcr"i 
fpsr "Floating_Point_Status_Register"
    = _* "fpsr"i 
// ************************************************** Registros de monitores de rendimiento ************************************************** \\
pmcr "Performance_Monitoring_Control"
    = _* "pmcr_el0"i 
pmcntenset "Performance_Monitoring_Count_Enable_Set"
    = _* "pmcntenset_el0"i 
pmcntenclr "Performance_Monitoring_Count_Enable_Clear"
    = _* "pmcntenclr_el0"i 
pmcnten "Performance_Monitoring_Count_Enable"
    = _* "pmcnten_el0"i 
pmovsclr "Performance_Monitoring_Overflow_Status_Clear"
    = _* "pmovsclr_el0"i 
pmswinc "Performance_Monitoring_Software_Increment"
    = _* "pmswinc_el0"i 
pmselr "Performance_Monitoring_Select"
    = _* "pmselr_el0"i 
pmceid0 "Performance_Monitoring_Event_Identifier_0"
    = _* "pmceid0_el0"i 
pmceid1 "Performance_Monitoring_Event_Identifier_1"
    = _* "pmceid1_el0"i 
pmceid "Performance_Monitoring_Counter_Event_Type"
    = _* "pmceid_el0"i 
pmccntr "Performance_Monitoring_Counter"
    = _* "pmccntr_el0"i 
pmxevtyper "Performance_Monitoring_Event_Type"
    = _* "pmxevtyper_el0"i 
pmxevcntr "Performance_Monitoring_Event_Count"
    = _* "pmxevcntr_el0"i 
pmuserenr "Performance_Monitoring_User_Enable"
    = _* "pmuserenr_el0"i 
pmovsset "Performance_Monitoring_Overflow_Status_Set"
    = _* "pmovsset_el0"i 
pmintenset "Performance_Monitoring_Interrupt_Enable_Set"
    = _* "pmintenset_el0"i 
pmintenclr "Performance_Monitoring_Interrupt_Enable_Clear"
    = _* "pmintenclr_el0"i 
pmevcntr "Performance_Monitoring_Event_Count"
    = _* "pmevcntr"i ( [30]/ [1-2][0-9] / [0-9])? "_el0"i 
pmevtyper "Performance_Monitoring_Event_Type"
    = _* "pmevtyper"i ( [30]/ [1-2][0-9] / [0-9])? "_el0"i 
pmccfiltr "Performance_Monitoring_Cycle_Counter_Filter"
    = _* "pmccfiltr_el0"i
daifset "Interrupt_Mask_Bits_Set"
    = _* "daifset"i 
daifclr "Interrupt_Mask_Bits_Clear"
    = _* "daifclr"i 
spsel "Stack_Pointer_Selection"
    = _* "spsel"i 
// ************************************************** Códigos Condicionales (cc) ************************************************** \\
cc "Códigos_Condicionales"
    = "eq"i // Equal
    / "ne"i // Not Equal
    / "cs"i // Carry Set, Unsigned Higher or Same
    / "hs"i // Carry Set, Unsigned Higher or Same
    / "cc"i // Carry Clear, Unsigned Lower
    / "lo"i // Carry Clear, Unsigned Lower
    / "mi"i // Minus, Negative
    / "pl"i // Plus, Positive or Zero
    / "vs"i // Overflow
    / "vc"i // No Overflow
    / "hi"i // Unsigned Higher
    / "ls"i // Unsigned Lower or Same
    / "ge"i // Signed Greater or Equal
    / "lt"i // Signed Less Than
    / "gt"i // Signed Greater Than
    / "le"i // Signed Less or Equal
    / "al"i  // Always
// ************************************************** Sufijo de Condición (q) ************************************************** \\
q "Sufijo_Condición"
    = ".N"i  // Meaning narrow
    / ".W"i  // Meaning wide 
// ************************************************** Valor Inmediato************************************************** \\
imm
    = i:iident  
    / i:ichar 
    / i:ibin 
    / i:ihex 
    / i:ioct 
    / i:iint 
iint "Inmediato Entero"
    = _* h:"#"i? s:("+"/"-")? v:int
ihex "Inmediato Hexadecimal"
    = _* h:"#"i? v:hex 
ioct "Inmediato Octal"
    = _* h:"#"i? v:oct 
ibin "Inmediato Binario"
    = _* h:"#"i? v:bin 
ichar "Inmediato Caracter"
    = _* h:"#"i? v:char
iident "Inmediato Identificador"
    = _* h:"#"i? v:identifier
// ************************************************** Constante ************************************************** \\
constant "Constante"
    = _* e:"="? i:identifier
// ************************************************** Value ************************************************** \\
value "Value"
    = _* identifier / string / char / oct / hex / bin / int
// ************************************************** Label ************************************************** \\
label "Label"
    = _* ([a-zA-Z_] [a-zA-Z0-9_]*) _* ":"
// ************************************************** Identificador ************************************************** \\
identifier "Identificador"
    = _* [a-zA-Z_] [a-zA-Z0-9_]*
// ************************************************** String ************************************************** \\
string "String"
    = _* "\"" [^"]* "\""
// ************************************************** Char ************************************************** \\
char "Char"
    = _* "'" [^'] "'"
// ************************************************** Octal ************************************************** \\
oct "Octal"
    = _* "0" [0-7]+
// ************************************************** Hexadecimal ************************************************** \\
hex "Hexadecimal"
    = _* "0x" [0-9a-fA-F]+
// ************************************************** Binario ************************************************** \\
bin "Binario"
    = _* "0b" [01]+
// ************************************************** Entero ************************************************** \\
int "Entero"
    = _* [0-9]+
// ************************************************** Línea en blanco ************************************************** \\
blank_line "Linea En Blanco"
    = _* comment? "\n" _*
// ************************************************** Comentarios ************************************************** \\
comment "Comentario"
    = c:lcomment
    / c:mcomment
lcomment "Comentario de Línea"
    = _* ("//" [^\n]*)
    / _* (";" [^\n]*)
mcomment "Comentario Multilínea"
    = _* "/*" ([^*] / [*]+ [^*/])* "*/"+
// ************************************************** Equal ************************************************** \\
equal "Equal"
    = _* "="
// ************************************************** Xor ************************************************** \\
xor "Xor"
    = _* s:"⊕"i
// ************************************************** Negación ************************************************** \\
neg "Negación"
    = _* s:"∼"i
// ************************************************** O ************************************************** \\
o "O"
    = _* s:"|"i
// ************************************************** Y ************************************************** \\
y "Y"
    = _* s:"&"i
// ************************************************** Mas ************************************************** \\
plus "Mas"
    = _* s:"+"i
// ************************************************** Llave Izq ************************************************** \\
lbracket "Llave Izq"
    = _* s:"["i
// ************************************************** Llave Der ************************************************** \\
rbracket "Llave Der"
    = _* s:"]"i
// ************************************************** Exclamación ************************************************** \\
excl "Exclamación"
    = _* s:"!"i
// ************************************************** Coma ************************************************** \\
comma "Coma"
    = _* s:","
// ************************************************** Espacios en blanco ************************************************** \\
_ "Espacio en blanco"
    = [ \t]+
// ************************************************** EOI ************************************************** \\
EOI "Fin de la Entrada"
    = _* !.
