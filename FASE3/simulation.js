const SYSCALL_EXIT = 93;
function ejecutarCuadruplo(cuadruplo) {
    const { op, op1, op2, op3, result, address } = cuadruplo;

    switch (op.getOperator().toString().toUpperCase()) {
        case 'ADD':
            registers[result] = getValue(op1) + getValue(op2);
            break;
        case 'SUB':
            registers[result] = getValue(op1) - getValue(op2);
            break;
        case 'MOV':
            registers[result] = getValue(op1);
            break;
        case 'LDR':
            registers[result] = address;
            break;
        case 'STORE':
            memory[getValue(op1)] = registers[getValue(op2)];
            break;
        case 'SVC':
            handleSvc();
            break;
        // Agregar más casos para otras operaciones según sea necesario
        default:
            console.error(`Operación no soportada: ${op.getOperator()}`);
            printToConsole(`Operación no soportada: ${op.getOperator()}`);
            break;
    }
}


function handleSvc() {
    const syscallNumber = registers['X8']; // x8 contiene el número de syscall
    switch (syscallNumber) {
        case SYSCALL_EXIT:
            const returnValue = registers['X0']; // x0 contiene el valor de retorno
            console.log(`Exit called with return value: ${returnValue}`);
            printToConsole(`Exit called with return value: ${returnValue}`);
            // Aquí podrías implementar la lógica para detener la simulación o cualquier otra acción necesaria.
            break;
        // Agregar más casos para otros syscalls si es necesario
        default:
            console.error(`Syscall no soportada: ${syscallNumber}`);
            printToConsole(`Syscall no soportada: ${syscallNumber}`);
            break;
    }
}

// Función para obtener el valor de un operando
function getValue(operando) {
    if (typeof operando === 'string' && (operando.startsWith('x') || operando.startsWith('X'))) {
        return registers[parseInt(operando.slice(1))];
    } else{
        return operando.getValue();
    } 
}
// Función para ejecutar todos los cuadruplos
function ejecutarCuadruplos(cuadruplos) {
    cuadruplos.forEach(cuadruplo => {
        ejecutarCuadruplo(cuadruplo);
    });
}
