
let quads = [];
class Quadruple{
    constructor(op, op1, op2, op3, result, label){
        this.op = op;
        this.op1 = op1;
        this.op2 = op2;
        this.op3 = op3;
        this.result = result;
        this.label = label;
    }
    setOp(op){
        this.op = op;
    }
    setOp1(op1){
        this.op1 = op1;
    }
    setOp2(op2){
        this.op2 = op2;
    }
    setOp3(op3){
        this.op3 = op3;
    }
    setResult(result){
        this.result = result;
    }
    setLabel(label){
        this.label = label;
    }
    getOp(){
        return this.op;
    }
    getOp1(){
        return this.op1;
    }
    getOp2(){
        return this.op2;
    }
    getOp3(){
        return this.op3;
    }
    getResult(){
        return this.result;
    }
    getLabel(){
        return this.label;
    }
    // Get the dot representation of the quadruple in Graphviz dot language
    getDot(){
        return `<td>${this.op.getOperator().toString().toUpperCase()}</td>\n<td>${this.op1}</td>\n<td>${this.op2}</td>\n<td>${this.op3}</td>\n<td>${this.result}</td></tr>\n`;
    }
    toString(){
        return `${this.op} ${this.op1} ${this.op2} ${this.op3} ${this.op4} ${this.result}`;
    
    }

}

class Operator{
    constructor(operator, cc, q){
        this.operator = operator;
        this.cc = cc;
        this.q = q;
    }
    setOperator(operator){
        this.operator = operator;
    }
    setCC(cc){
        this.cc = cc;
    }
    setQ(q){
        this.q = q;
    }
    getOperator(){
        return this.operator;
    }
    getCC(){
        return this.cc;
    }
    getQ(){
        return this.q;
    }
}
// Function to convert a CST to a Q by recursively traversing a list with Instructions
function CSTtoQ(insNodes){
    // The table that will store the quadruples
    // First we traverse the list of instructions, creating a quadruple for each one
    let label = '';
    for (let i = 0; i < insNodes.length; i++){
        if (insNodes[i].getType() == TYPE.LABEL){
            label = insNodes[i].getValue();
        } else{
            // Create the new quadruple and operator
            let newOperator;
            let newQuadruple = new Quadruple();

            let ins = insNodes[i];
            let op = ins.getChildren()[0];
            //Check if there are arguments
            let args;
            if (ins.getChildren().length == 1){
                args = null
            } else {
                args = ins.getChildren()[1];
            }
            // Check the operator node if has cc and q
            if(op.getChildren().length == 3){
                let operator = op.getChildren()[0].getValue();
                let cc = op.getChildren()[1].getValue();
                let q = op.getChildren()[2].getValue();
                newOperator = new Operator(operator, cc, q);
            } else if(op.getChildren().length == 2){
                let operator = op.getChildren()[0].getValue();
                let cc = op.getChildren()[1].getValue();
                let q = '';
                newOperator = new Operator(operator, cc, q);
            } else {
                let operator = op.getChildren()[0].getValue();
                let cc = '';
                let q = '';
                newOperator = new Operator(operator, cc, q);
            }
            // Set the operator to the quadruple
            newQuadruple.setOp(newOperator);
            newQuadruple.setLabel(label);
            let temp = 1;
            // Check the arguments node, if there are no arguments, set the quadruple with '--'
            if (args == null){
                newQuadruple.setResult('--');
                newQuadruple.setOp1('--');
                newQuadruple.setOp2('--');
                newQuadruple.setOp3('--');
                quads.push(newQuadruple);
            } else{
                // Check the number of arguments, and set the quadruple with the corresponding values

                // If there is only one argument, the value is set as the result, and the rest of the quadruple is set as '--'
                if (args.getChildren().length == 1){
                    let arg = args.getChildren()[0];
                    newQuadruple.setResult(returnValue(arg, quads, temp, label));
                    newQuadruple.setOp1('--');
                    newQuadruple.setOp2('--');
                    newQuadruple.setOp3('--');
                    quads.push(newQuadruple);
                } else if (args.getChildren().length == 2){
                    let arg1 = args.getChildren()[0];
                    let arg2 = args.getChildren()[1];
                    newQuadruple.setResult(returnValue(arg1, quads, temp, label));
                    newQuadruple.setOp1(returnValue(arg2, quads, temp, label));
                    newQuadruple.setOp2('--');
                    newQuadruple.setOp3('--');
                    quads.push(newQuadruple);
                } else if (args.getChildren().length == 3){
                    let arg1 = args.getChildren()[0];
                    let arg2 = args.getChildren()[1];
                    let arg3 = args.getChildren()[2];
                    newQuadruple.setResult(returnValue(arg1, quads, temp, label));
                    newQuadruple.setOp1(returnValue(arg2, quads, temp, label));
                    newQuadruple.setOp2(returnValue(arg3, quads, temp, label));
                    newQuadruple.setOp3('--');
                    quads.push(newQuadruple);
                } else if (args.getChildren().length == 4){
                    let arg1 = args.getChildren()[0];
                    let arg2 = args.getChildren()[1];
                    let arg3 = args.getChildren()[2];
                    let arg4 = args.getChildren()[3];
                    newQuadruple.setResult(returnValue(arg1, quads, temp, label));
                    newQuadruple.setOp1(returnValue(arg2, quads, temp, label));
                    newQuadruple.setOp2(returnValue(arg3, quads, temp, label));
                    newQuadruple.setOp3(returnValue(arg4, quads, temp, label));
                    quads.push(newQuadruple);
                } else if (args.getChildren().length == 5){
                    let arg1 = args.getChildren()[0];
                    let arg2 = args.getChildren()[1];
                    let arg3 = args.getChildren()[2];
                    let arg4 = args.getChildren()[3];
                    let arg5 = args.getChildren()[4];
                    newQuadruple.setResult(returnValue(arg1, quads, temp, label));
                    newQuadruple.setOp1(returnValue(arg2, quads, temp, label));
                    newQuadruple.setOp2(returnValue(arg3, quads, temp, label));
                    newQuadruple.setOp3(returnValue(arg4, quads, temp, label));
                    quads.push(newQuadruple);
                }
            }
        }
        
    }
}
/*
    If the argument is a type of register; R64, R32, SP64, SP32, ZR64, ZR32, PC, SYSREG its value is in the same node
    If the argument is a type of immediate; the value is int the chidlren of the node, this can have 2 children but the value is always in the last one, if there is only one child, the value is in that child
    If the argument is a type of constant; the value is in the children of the node, this can have 2 children but the value is always in the last one, if there is only one child, the value is in that child
    If the argument is a type of rel; the value is in the children of the children of the node
    If the argument is a type of op2a; the value or values are in the children of the node
    If the argument is a type of op2l; the value or values are in the children of the node
    If the argument is a type of addr; the value or values is in the children of the node
    If the argument is a type of shift; the value or values are in the children of the node
    If the argument is a type of barrierop; the value is in the children of the node
    If the argument is a type of prfop; the value is in the children of the node
    If the argument is a type of mask; the value is in the children of the node
    If the argument is a type of extend; the value or values are in the children of the node
    THIS NEED TO BE RECURSIVE BECAUSE THE OP2A, OP2L, ADDR CAN HAVE MORE THAN ONE ARGUMENT
*/
function returnValue(arg, table, temp, label){
    //console.log(`EVALUANDO NODO DE TIPO: ${arg.getType()}`);
    if(equalType(arg.getType(), TYPE.R64, TYPE.R32, TYPE.SP64, TYPE.SP32, TYPE.ZR64, TYPE.ZR32, TYPE.FP, TYPE.LR, TYPE.PC, TYPE.SYSREG)){
        return arg.getValue().toString().toUpperCase();
    } else if(equalType(arg.getType(), TYPE.IMM)){
        if (arg.getChildren().length == 1){
            child = arg.getChildren()[0];
            return child.getValue();
        } else {
            child = arg.getChildren()[1];
            return child.getValue();
        }
    } else if(equalType(arg.getType(), TYPE.CONSTANT)){
        if (arg.getChildren().length == 1){
            child = arg.getChildren()[0];
            return child.getValue();
        } else {
            child = arg.getChildren()[1];
            return child.getValue();
        }
    } else if(equalType(arg.getType(), TYPE.REL, TYPE.MASK)){
        arg = arg.getChildren()[0];
        return returnValue(arg, table, temp, label);
    } else if(equalType(arg.getType(), TYPE.OPSHIFT, TYPE.OPEXTEND)){
        let pQ = new Quadruple();
        let pO = new Operator();
        let args = arg.getChildren();
        console.log(args);
        pO.setOperator(args[1].getValue()); pO.setCC(''); pO.setQ('');
        pQ.setOp(pO);
        pQ.setOp1(returnValue(args[2], table, temp, label));
        pQ.setOp2('--');
        pQ.setOp3('--');
        pQ.setResult(returnValue(args[0], table, temp, label));
        pQ.setLabel(label);
        quads.push(pQ);
        return pQ.getResult();
    } else if(equalType(arg.getType(), TYPE.OP2A, TYPE.OP2L)){
        arg = arg.getChildren()[0];
        return returnValue(arg, table, temp, label);
    } else if(equalType(arg.getType(), TYPE.ADDR)){
        let args = arg.getChildren();
        if (args.length == 1){
            return returnValue(args[0], table, temp, label);
        } else if(args.length == 2){
            let pQ = new Quadruple();
            let pO = new Operator();
            pO.setOperator('addr'); pO.setCC(''); pO.setQ('');
            pQ.setOp(pO);
            pQ.setOp1(returnValue(args[0], table, temp, label));
            pQ.setOp2(returnValue(args[1], table, temp, label));
            pQ.setOp3('--');
            pQ.setResult(`t${temp}`);
            pQ.setLabel(label);
            temp++;
            quads.push(pQ);
            return pQ.getResult();
        }else if(args.length == 3){
            let pQ = new Quadruple();
            let pO = new Operator();
            pO.setOperator('addr'); pO.setCC(''); pO.setQ('');
            pQ.setOp(pO);
            pQ.setOp1(returnValue(args[0], table, temp, label));
            pQ.setOp2(returnValue(args[1], table, temp, label));
            pQ.setOp3('--');
            pQ.setResult(`t${temp}`);
            pQ.setLabel(label);
            temp++;
            quads.push(pQ);
            return pQ.getResult();
        }
    }
}
function clearQuads(){
    quads = [];
}
