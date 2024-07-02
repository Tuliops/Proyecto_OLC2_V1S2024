let nextFreeAddress = 0;

const MEMORY_SIZE = 64 * 1024 * 1024; // 64 MB
const memory = new Uint8Array(MEMORY_SIZE);
const PAGE_SIZE = 256; // Número de bytes por página
let currentPage = 0;

const registers = Array(31).fill(0); // 31 General-purpose registers (X0 to X30)
const specialRegisters = {
    PC: 0,  // Program Counter
    SP: 0,  // Stack Pointer
    XZR: 0  // Zero Register (always zero)
};

// Función para convertir un número a una dirección hexadecimal de 8 dígitos
function toHexAddress(num) {
    return '0x' + num.toString(16).padStart(8, '0').toUpperCase();
}

// Función para inicializar la tabla de memoria en la interfaz
function initMemoryTable() {
    const memoryTable = document.getElementById('memoryTable').querySelector('tbody');
    memoryTable.innerHTML = '';
    for (let i = 0; i < PAGE_SIZE; i += 16) {
        const row = document.createElement('tr');
        const addressCell = document.createElement('td');
        addressCell.textContent = toHexAddress(i + currentPage * PAGE_SIZE);
        row.appendChild(addressCell);
        for (let j = 0; j < 16; j++) {
            const cell = document.createElement('td');
            cell.textContent = '00';
            row.appendChild(cell);
        }
        memoryTable.appendChild(row);
    }
}

function resetMemory() {
    memory.fill(0);
    updateMemoryTable();
}

// Función para actualizar los datos en la tabla de memoria
function updateMemoryTable() {
    const memoryTable = document.getElementById('memoryTable').querySelector('tbody');
    const rows = memoryTable.querySelectorAll('tr');
    rows.forEach((row, rowIndex) => {
        const addressCell = row.querySelector('td');
        const address = currentPage * PAGE_SIZE + rowIndex * 16;
        addressCell.textContent = toHexAddress(address);
        const cells = row.querySelectorAll('td');
        for (let i = 1; i < cells.length; i++) {
            const byteAddress = address + i - 1;
            cells[i].textContent = memory[byteAddress].toString(16).padStart(2, '0').toUpperCase();
        }
    });

    // También puedes agregar código aquí para destacar o mostrar de manera especial el símbolo msg si es necesario.
}

// Función para inicializar la memoria con los símbolos de la tabla
function initializeMemoryFromSymbols() {
    symbols.forEach(symbol => {
        const address = calculateDynamicAddress(symbol);
        switch (symbol.getType()) {
            case '.asciz':
                let symbolValue = symbol.getValue();
                if (symbolValue instanceof Value) {
                    outputArea.textContent += `\nAlmacenando cadena "${symbolValue.getValue()}" en dirección ${toHexAddress(address)}`;
                    symbol.setAddress(address); // Guardar la dirección en el símbolo
                    const stringValue = symbolValue.getValue();
                    for (let i = 0; i < stringValue.length; i++) {
                        memory[address + i] = stringValue.charCodeAt(i); // Almacenar cada carácter en memoria
                    }
                    memory[address + stringValue.length] = 0; // Null-terminator para .asciz
                } else {
                    outputArea.textContent += `\nValor del símbolo no es instancia de Value: ${symbolValue}`;
                }
                break;
            // Agregar más casos para otros tipos de datos si es necesario
            default:
                outputArea.textContent += `\nTipo de dato no soportado: ${symbol.getType()}`;
                break;
        }
    });
}

// Función para calcular la dirección dinámica en la memoria
function calculateDynamicAddress(symbol) {
    let dynamicAddress = nextFreeAddress; // Obtener la siguiente dirección disponible
    nextFreeAddress += calculateSymbolSize(symbol); // Incrementar la dirección libre
    return dynamicAddress;
}

// Función para calcular el tamaño en memoria de un símbolo (ejemplo simplificado)
function calculateSymbolSize(symbol) {
    switch (symbol.getType()) {
        case '.asciz':
            return symbol.getValue().getValue().length + 1; // Tamaño de la cadena más el null-terminator
        // Agregar más casos para otros tipos de datos si es necesario
        default:
            console.error(`Tipo de dato no soportado: ${symbol.getType()}`);
            return 0;
    }
}







// Función para manejar la navegación de páginas
function nextPage() {
    if ((currentPage + 1) * PAGE_SIZE < MEMORY_SIZE) {
        currentPage++;
    } else {
        currentPage = 0;
    }
    updateMemoryTable();
}

function prevPage() {
    if (currentPage > 0) {
        currentPage--;
    } else {
        currentPage = Math.floor(MEMORY_SIZE / PAGE_SIZE) - 1;
    }
    updateMemoryTable();
}

// Inicializar la tabla de memoria al cargar la página
document.addEventListener('DOMContentLoaded', () => {
    initMemoryTable();
    updateMemoryTable();
    document.getElementById('nextPageButton').addEventListener('click', nextPage);
    document.getElementById('prevPageButton').addEventListener('click', prevPage);
    document.getElementById('resetMemory').addEventListener('click', resetMemory);
});
