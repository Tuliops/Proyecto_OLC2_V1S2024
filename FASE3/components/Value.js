class Value{
    constructor(type, value, text){
        this.type = type;
        this.value = value;
        this.text = text;
    }
    setType(type){
        this.type = type;
    }
    setValue(value){
        this.value = value;
    }
    setText(text){
        this.text = text;
    }
    getType(){
        return this.type;
    }
    getValue(){
        return this.value;
    }
    getText(){
        return this.text;
    }
    convertToType(){
        switch(this.type){
            case TYPE.INT:
                this.value = parseInt(this.text, 10);
                break;
            case TYPE.HEX:
                this.value = parseInt(this.text, 16);
                break;
            case TYPE.OCT:
                this.value = parseInt(this.text, 8);
                break;
            case TYPE.BIN:
                //Remove the 0b prefix
                let value = this.text.slice(2);
                this.value = parseInt(value, 2);
                break;
            case TYPE.CHAR:
                //convert the character to its ASCII value
                let ascii = this.text.charCodeAt(0);
                this.value = ascii;
                break;
            case TYPE.STRING:
                this.value = this.text;
                break;
            case TYPE.DOUBLE:
                this.value = parseFloat(this.text);
                break;
            case TYPE.BOOLEAN:
                if(this.text.toLowerCase() === "true"){
                    this.value = true;
                }else {
                    this.value = false;
                }
                break;
            default:
                break;
        }
    }
}