class CSTnode{
    constructor(type, value, description, children = []){
        this.type = type;
        this.value = value;
        this.description = description;
        this.children = children;
        this.id = CSTnode.generateUniqueId();
    }
    // Genera un identificador único para el nodo del árbol "Para el archivo .dot"
    static generateUniqueId() {
        return '\"xxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx\"'.replace(/[xy]/g, function(c) {
            const r = Math.random() * 16 | 0,
            v = c === 'x' ? r : (r & 0x3 | 0x8);
            return v.toString(16);
        });
    }
    setType(type){
        this.type = type;
    }
    setValue(value){
        this.value = value;
    }
    setChildren(children){
        this.children = children;
    }
    addDescription(description){
        this.description = description;
    }
    getType(){
        return this.type;
    }
    getValue(){
        return this.value;
    }
    getChildren(){
        return this.children;
    }
    getChildrenCount(){
        return this.children.length;
    }
    getDescription(){
        return this.description;
    }
    addChild(child){
        this.children.push(child);
    }
    addChildren(children){
        this.children = this.children.concat(children);
    }
    // Este método agrega los hijos de un nodo, pero no agrega los nodos que son comas o corchetes "Debido al lenguaje de entrada"
    addChildren_Values(children){
        children.forEach(child => {
                if(child instanceof Array){
                    child.forEach(c => {
                        if(c !== null && c instanceof CSTnode && c.getValue() !== ',' && c.getValue() !== '[' && c.getValue() !== ']'){
                            this.children.push(c);
                        }
                    });
                }else{
                    if(child !== null && child instanceof CSTnode && child.getValue() !== ',' && child.getValue() !== '[' && child.getValue() !== ']'){
                        this.children.push(child);
                    }
            }
        });
    }
    // Gráfico en lenguaje DOT para el árbol de sintaxis concreta "se usa el motor de viz.js para visualizarlo en la interfaz"
    getDot(){
        let dot = '';
        dot += 'digraph G {\n   splines=polyline;\n nodesep=0.1;\n  ranksep=0.5;\n  pack=true;\n';
        function addNodes(n){
            if(n.type === TYPE.ROOT){
                dot += `   ${n.id} [label="${n.value}", shape=tripleoctagon, style=filled, color=lightblue];\n`;
            }else if(equalType(n.type, TYPE.INST, TYPE.DIRECT_SECTION, TYPE.INST_SECTION, TYPE.INSTRUCTIONS, TYPE.EXPRESSION, TYPE.DIRECT_EXP)){
                dot += `   ${n.id} [label="${n.value}", fontsize=7, style=filled, shape=parallelogram, fillcolor=\"#F0E1C1CC\"];\n`;
            }else if(equalType(n.type, TYPE.ARGS, TYPE.OP)){
                dot += `   ${n.id} [label="${n.value}", style=filled, fillcolor=\"#C1DFF0CC\"];\n`;
            }else if(equalType(n.type, TYPE.IMM, TYPE.CONSTANT, TYPE.REL, TYPE.ADDR)){
                dot += `   ${n.id} [label="${n.value}", style=filled, fillcolor=\"#C1E1C1CC\"];\n`;
            }else if(equalType(n.type, TYPE.R64, TYPE.R32, TYPE.SP64, TYPE.SP32, TYPE.ZR64, TYPE.ZR32, TYPE.PC, TYPE.SYSREG)){
                dot += `   ${n.id} [label="${n.value}", penwidth=3.0];\n`;
            }else if(equalType(n.type, TYPE.OPSHIFT, TYPE.OPEXTEND)){
                dot += `   ${n.id} [label="${n.value}", style=filled, fillcolor=\"#C9A0DC\"];\n`;
            }else if(equalType(n.type, TYPE.INT, TYPE.HEX, TYPE.BIN, TYPE.OCT, TYPE.CHAR, TYPE.STRING)){
                dot += `   ${n.id} [label="${n.value.text}"];\n`;
            }else{
                dot += `   ${n.id} [label="${n.value}"];\n`;
            }
            n.children.forEach(child => {
                if(equalType(n.type, TYPE.DIRECTIVE_SECTION, TYPE.DIRECT_EXP, TYPE.EXPRESION, TYPE.INSTRUCTIONS)){
                    dot += `    ${n.id} -> ${child.id}[weight=3];\n`;
                }else{
                    dot += `    ${n.id} -> ${child.id};\n`;
                }
                addNodes(child);
            });
        }
        addNodes(this);
        dot += '}';
        return dot;
    }
    getINSnodes(){
        let ins = [];
        function getInstructions(n){
            if(n.type === TYPE.INST){
                ins.push(n);
            }
            n.children.forEach(child => getInstructions(child));
        }
        getInstructions(this);
        return ins;
    
    }
    getINSTnodes(){
        let ins = [];
        function getInstructions(n){
            if(n.type === TYPE.INST_SECTION){
                ins.push(n.children[0]);
            }else if(n.type === TYPE.INST){
                ins.push(n);
            }
            n.children.forEach(child => getInstructions(child));
        }
        getInstructions(this);
        return ins;
    }
    // Retorna un texto con todas las instrucciones del árbol
    Text(){
        let text = 'ANÁLISIS COMPLETADO ESPERANDO EJECUCIÓN...\n*******************\nSe han encontrado las siguientes instrucciones:\n*******************\n';
        function getInstructions(n){
            if(n.type === TYPE.INST_SECTION){text += `${n.children[0].value}\n`;}
            else if(n.type === TYPE.INST){text += `  ${n.value}| ${n.children[0].children[0].value}\n`;}
            n.children.forEach(child => getInstructions(child));
        }
        getInstructions(this);
        return text;
    }
}
// Creacion de nodos para el árbol de sintaxis concreta
function createNode(type, value, description, children = []){
    return new CSTnode(type, value, description, children);
}
// Creacion de nodos con la información de los operadores
function getType(value) {
    for (const [key, type] of Object.entries(OPTYPE)) {
        if (type === value.toUpperCase()) {
            return key;
        }
    }
    return null;
}
function createOPnameNode(value){
    return createNode(getType(value), value, '');
}
// Creacion de nodos con las instrucciones
function createInstNode(value, children = []){
    return new CSTnode(TYPE.INST, value, '', children);
}
// Creacion de nodos con los argumentos
function createArgsNode(value, children = []){
    return new CSTnode(TYPE.ARGS, value, '', children);
}
// Comparacion de tipos de datos
function equalType(value, ...types){
    return types.some(type => type === value);
}