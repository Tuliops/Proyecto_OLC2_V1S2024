let symbols = [];
class Symbol{
    constructor(name, type, value, environment, row, column, address){
        this.name = name;
        this.type = type;
        this.value = value;
        this.environment = environment
        this.row = row;
        this.column = column;
        this.address = address;
    }
    setName(name){
        this.name = name;
    }
    getName(){
        return this.name;
    }
    setType(type){
        this.type = type;
    }
    getType(){
        return this.type;
    }
    setValue(value){
        this.value = value;
    }
    getValue(){
        return this.value;
    }
    setEnvironment(environment){
        this.environment = environment;
    }
    getEnvironment(){
        return this.environment;
    }
    setRow(row){
        this.row = row;
    }
    getRow(){
        return this.row;
    }
    setColumn(column){
        this.column = column;
    }
    getColumn(){
        return this.column;
    }
    setAddress(address){
        this.address = address;
    }
    getAddress(){
        return this.address;
    }
}
function createSymbol(name, type, value, environment, row, column){
    let symbol = new Symbol(name, type, value, environment, row, column, '');
    return symbol;
}
function clearSymbols(){
    symbols = [];
}