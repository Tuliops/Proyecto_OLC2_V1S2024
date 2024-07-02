let errors = [];
class ParseError{
    constructor(type, symbol, description, row, column){
        this.type = type;
        this.symbol = symbol;
        this.description = description;
        this.row = row;
        this.column = column;
    }
    setType(type){
        this.type = type;
    }
    setSymbol(symbol){
        this.symbol = symbol;
    }
    setDescription(description){
        this.description = description;
    }
    setRow(row){
        this.row = row;
    }
    setColumn(column){
        this.column = column;
    }
    getType(){
        return this.type;
    }
    getSymbol(){
        return this.symbol;
    }
    getDescription(){
        return this.description;
    }
    getRow(){
        return this.row;
    }
    getColumn(){
        return this.column;
    }

}
function insertErrors(){
    errors.forEach(error => {
        insertRow('errorsTable', [errors.length, error.type, error.description, error.row, error.column]);
    });
}
function insertError(error){
    let e = new ParseError();
    if(isLexicalError(error)){
        e.setType('Lexical Error');
        e.setSymbol(error.found);
        e.setDescription('Símbolo no pertence al lenguaje');
        e.setRow(error.location.start.line);
        e.setColumn(error.location.start.column);
    } else {
        e.setType('Syntax Error');
        e.setSymbol(error.found);
        e.setDescription('Símbolo no esperado en la entrada');
        e.setRow(error.location.start.line);
        e.setColumn(error.location.start.column);
    }
    errors.push(e);    
}
function isLexicalError(e) {
    const validIdentifier = /^[a-zA-Z_$][a-zA-Z0-9_$]*$/;
    const validInteger = /^[0-9]+$/;
    const validRegister = /^[a-zA-Z][0-9]+$/;
    const validCharacter = /^[a-zA-Z0-9_$,\[\]#"]$/;
    const validString = /^"[a-zA-Z0-9_$,\[\]# ]*"$/;
    const validComment = /^;.*$/;
    const validHexadecimal = /^0x[0-9a-fA-F]+$/;
    const validBinary = /^0b[01]+$/;
    const validOctal = /^0o[0-7]+$/;
    const validDirective = /^\.[a-zA-Z]+$/;
    if (e.found) {
      if (!validIdentifier.test(e.found) && !validInteger.test(e.found) && !validRegister.test(e.found) && !validCharacter.test(e.found) && !validString.test(e.found) &&
          !validComment.test(e.found) && !validHexadecimal.test(e.found) && !validBinary.test(e.found) && !validOctal.test(e.found) && !validDirective.test(e.found)){
        return true; // Error léxico
      }
    }
    return false; // Error sintáctico
}
function messageError(e){
    if(isLexicalError(e)){
        return `Error léxico: Símbolo no pertenece al lenguaje. Se encontró '${e.found}' en la línea ${e.location.start.line} y columna ${e.location.start.column}`;
    }
    return `Error sintáctico: Símbolo no esperado en la entrada. Se encontró '${e.found}' en la línea ${e.location.start.line} y columna ${e.location.start.column}`;
}
function clearErrors(){
    errors = [];
}