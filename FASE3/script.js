document.addEventListener('DOMContentLoaded', function() {
    // Referencias a elementos del DOM
    const codeArea = document.getElementById('codeArea');
    const lineNumbers = document.getElementById('lineNumbers');
    const fileInput = document.getElementById('fileInput');
    const outputArea = document.getElementById('outputArea');
    const registersTable = document.getElementById('registersTable').querySelector('tbody');
    const flagsTable = document.getElementById('flagsTable').querySelector('tbody');
    const reportTable = document.getElementById('reportTable').querySelector('tbody');
    const quadruplesTable = document.getElementById('quadruplesTable').querySelector('tbody');
    const errorsTable = document.getElementById('errorsTable').querySelector('tbody');
    const symbolTable = document.getElementById('symbolTable').querySelector('tbody');
    const reportImageWrapper = document.getElementById('reportImageWrapper');
    const reportImage = document.getElementById('reportImage');
    const viewFullTreeButton = document.getElementById('viewFullTreeButton');
    const reportOptions = document.getElementById('reportOptions');
    const debugButton = document.getElementById('debugButton');
    const nextLineButton = document.getElementById('nextLineButton');
    
    let debugLines = [];
    let currentLineIndex = 0;
    let CST = null;
    let DOT = '';
    let scale = 1;

    // Inicializar tablas con cabeceras predeterminadas
    function initializeTable(table, columns) {
        const thead = table.createTHead();
        const row = thead.insertRow();
        columns.forEach(column => {
            const th = document.createElement('th');
            th.textContent = column;
            row.appendChild(th);
        });
    }

    // Crear tablas con sus cabeceras respectivas
    initializeTable(document.getElementById('quadruplesTable'), ['#', 'OP', 'ARG1', 'ARG2', 'ARG3', 'RESULT', 'LABEL']);
    initializeTable(document.getElementById('errorsTable'), ['#', 'TIPO','SÍMBOLO','DESCRIPCIÓN', 'LÍNEA', 'COLUMNA']);
    initializeTable(document.getElementById('symbolTable'), ['#', 'ID', 'TIPO', 'DATO', 'ENTORNO', 'LÍNEA', 'COLUMNA', 'DIRECCIÓN']);

    // Función para insertar filas en las tablas
    function insertRow(tableId, rowData) {
        const table = document.getElementById(tableId).querySelector('tbody');
        const row = table.insertRow();
        rowData.forEach(data => {
            const cell = row.insertCell();
            cell.textContent = data;
        });
    }

    // Insertar filas de ejemplo (puedes quitar esto después de probar)
    insertRow('quadruplesTable', [1, 'ADD', 'R1', 'R2', 'R3', 'R4']);
    insertRow('errorsTable', [1, 'Syntax Error', 'Missing ;', 12, 15]);
    insertRow('symbolTable', [1, 'var', 'int', '10', 'global', 8, 2]);

    // Resto del código del evento DOMContentLoaded...
    // Función para actualizar los números de línea en el editor
    function updateLineNumbers() {
        const lines = codeArea.value.split('\n').length;
        lineNumbers.innerHTML = '';
        for (let i = 1; i <= lines; i++) {
            const lineNumber = document.createElement('div');
            lineNumber.textContent = i;
            lineNumbers.appendChild(lineNumber);
        }
    }

    // Sincronizar el scroll de los números de línea con el editor de código
    function syncScroll() {
        lineNumbers.scrollTop = codeArea.scrollTop;
    }

    // Habilitar o deshabilitar el botón de depuración según el contenido del área de código
    function toggleDebugButton() {
        if (codeArea.value.trim() === '') {
            debugButton.disabled = true;
        } else {
            debugButton.disabled = false;
        }
    }

    // Cargar archivo en el editor
    function loadFile(event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                codeArea.value = e.target.result;
                updateLineNumbers();
                toggleDebugButton();
            }
            reader.readAsText(file);
        }
    }

    // Guardar contenido del editor como archivo
    function saveFile() {
        const blob = new Blob([codeArea.value], { type: 'text/plain' });
        const link = document.createElement('a');
        link.href = URL.createObjectURL(blob);
        link.download = 'archivo.s';
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
    }

    // Analizar código
    function analyzeCode() {
        // Limpiar la memoria y los registros antes de la ejecución
        resetMemory();
        registers.fill(0);
        specialRegisters.PC = 0;
        specialRegisters.SP = MEMORY_SIZE - 1;
        specialRegisters.XZR = 0;
        clearQuads();
        clearErrors();
        clearSymbols();
        try{
            startTime();
            CST = PARSE.parse(codeArea.value);
            endTime();
            DOT = CST.getDot();
            CSTtoQ(CST.getINSTnodes());
            SY.parse(codeArea.value);
            outputArea.style.color = 'green';
            outputArea.textContent = CST.Text();
        }catch(e){
            outputArea.style.color = 'red';
            outputArea.textContent = messageError(e);
            //insert ERROR in the table
            insertError(e);
        }
        try{
            initializeMemoryFromSymbols();
            updateMemoryTable();
        }catch(e){
            outputArea.style.color = 'red';
            outputArea.textContent = 'ERROR EN MEMORIA: '+ e;
        }
    }
    // Ejecutar código
    function runCode() {
        // Mostrar la consola
        showConsole();
        // Ejecutar los cuadruplos
        ejecutarCuadruplos(quads);
        // Aquí puedes agregar una función para actualizar la interfaz de los registros si tienes una
        updateRegisters(registers);
        // Actualizar la interfaz de la memoria y los registros
        updateMemoryTable();
        
    }

    // Limpiar consola de salida
    function clearOutput() {
        outputArea.textContent = '';
    }

    // Actualizar tabla de registros
    function updateRegisters(registers) {
        registersTable.innerHTML = '';
        for (let i = 0; i <= 30; i++) {
            const registerName = `X${i}`;
            const registerValue = registers[registerName] || '0x0'; // Valor por defecto
            const row = document.createElement('tr');
            const nameCell = document.createElement('td');
            const valueCell = document.createElement('td');
            nameCell.textContent = registerName;
            valueCell.textContent = registerValue;
            row.appendChild(nameCell);
            row.appendChild(valueCell);
            registersTable.appendChild(row);
        }
        // Agregar LR y FP
        const extraRegisters = ['LR', 'FP'];
        extraRegisters.forEach(registerName => {
            const registerValue = registers[registerName] || '0x0'; // Valor por defecto
            const row = document.createElement('tr');
            const nameCell = document.createElement('td');
            const valueCell = document.createElement('td');
            nameCell.textContent = registerName;
            valueCell.textContent = registerValue;
            row.appendChild(nameCell);
            row.appendChild(valueCell);
            registersTable.appendChild(row);
        });
        // Agregar PC, SP, XZR
        const specialRegisters = ['PC', 'SP', 'XZR'];
        specialRegisters.forEach(registerName => {
            const registerValue = registers[registerName] || '0x0'; // Valor por defecto
            const row = document.createElement('tr');
            const nameCell = document.createElement('td');
            const valueCell = document.createElement('td');
            nameCell.textContent = registerName;
            valueCell.textContent = registerValue;
            row.appendChild(nameCell);
            row.appendChild(valueCell);
            registersTable.appendChild(row);
        });
    }

    // Actualizar tabla de flags
    function updateFlags(flags) {
        flagsTable.innerHTML = '';
        const flagNames = ['N', 'Z', 'C', 'V']; // Ejemplo de flags
        flagNames.forEach(flagName => {
            const flagValue = flags[flagName] || '0'; // Valor por defecto
            const row = document.createElement('tr');
            const nameCell = document.createElement('td');
            const valueCell = document.createElement('td');
            nameCell.textContent = flagName;
            valueCell.textContent = flagValue;
            row.appendChild(nameCell);
            row.appendChild(valueCell);
            flagsTable.appendChild(row);
        });
    }

    // Mostrar opciones de reporte
    function showReportOptions() {
        reportOptions.style.display = reportOptions.style.display === 'flex' ? 'none' : 'flex';
    }

    // Generar reporte según el tipo especificado
    function generateReport(type) {
        switch(type) {
            case 'cst':
                generateCSTReport();
                break;
            case 'quad':
                generateTableReport('quadruples');
                break;
            case 'symbol':
                generateTableReport('symbol');
                break;
            case 'errors':
                generateTableReport('errors');
                break;
        }
    }

    // Generar reporte CST con Viz.js
    function generateCSTReport() {
        const viz = new Viz();
        const dot = DOT; // Ejemplo, reemplaza con tu código DOT
        if(dot === ''){
            outputArea.style.color = 'red';
            outputArea.textContent = 'No se ha generado el árbol de análisis sintáctico';
            return;
        }
        viz.renderSVGElement(dot)
            .then(function(element) {
                // Ocultar el cuerpo de las tablas, pero mantener el encabezado visible
                hideTable('reportTable');
                hideTable('quadruplesTable');
                hideTable('errorsTable');
                hideTable('symbolTable');

                // Mostrar la imagen del reporte
                const serializedElement = new XMLSerializer().serializeToString(element);
                const base64Image = btoa(serializedElement);
                reportImage.src = 'data:image/svg+xml;base64,' + base64Image;
                reportImage.style.display = 'block';
                viewFullTreeButton.style.display = 'block';
                scale = 1;
                reportImage.style.transform = `scale(${scale})`;

                // Configurar el botón para abrir la nueva página con la imagen completa
                viewFullTreeButton.onclick = function() {
                    const newWindow = window.open(`tree_viewer.html?image=${encodeURIComponent(base64Image)}`, '_blank');
                    newWindow.focus();
                };
            })
            .catch(error => {
                console.error(error);
            });
    }
    // Función para ocultar la tabla completa dejando visible el encabezado
    function hideTable(tableId) {
        const table = document.getElementById(tableId);
        if (table) {
            table.style.display = 'none';
        }
    }
    // Generar reporte en tabla
// Generar reporte en tabla
function generateTableReport(reportType) {
    let data = [];
    switch(reportType) {
        case 'quadruples':
            data = quads.map((quad, index) => {
                let op1Value = typeof quad.op1 === 'object' ? quad.op1.value : quad.op1;
                let op2Value = typeof quad.op2 === 'object' ? quad.op2.value : quad.op2;
                let op3Value = typeof quad.op3 === 'object' ? quad.op3.value : quad.op3;
                let resultValue = typeof quad.result === 'object' ? quad.result.value : quad.result;
                let labelValue = typeof quad.label === 'object' ? quad.label.value : quad.label;
                return [
                    index + 1,
                    quad.op.operator,
                    op1Value,
                    op2Value,
                    op3Value,
                    resultValue,
                    labelValue
                ];
            });
            break;
        case 'errors':
            data = errors.map((error, index) => [
                index + 1,
                error.getType(),
                error.getSymbol(),
                error.getDescription(),
                error.getRow(),
                error.getColumn()
            ]);
            break;
            case 'symbol':
                data = symbols.map((symbol, index) => {
                    let id = typeof symbol.getName() === 'object' ? symbol.getName().value : symbol.getName();
                    let value = symbol.getValue();
            
                    // Check if value is an array
                    if (Array.isArray(value)) {
                        // Map over array elements and convert each to text or object value if needed
                        value = value.map(item => {
                            if (typeof item === 'object' && item !== null) {
                                return item.value;
                            } else {
                                return item;
                            }
                        });
            
                        // Join array elements into a comma-separated string
                        value = value.join(', ');
                    } else if (typeof value === 'object' && value !== null) {
                        // If value is an object, get its value property
                        value = value.value;
                    }
            
                    return [
                        index + 1,
                        id,
                        symbol.getType(),
                        value,
                        symbol.getEnvironment(),
                        symbol.getRow(),
                        symbol.getColumn(),
                        symbol.getAddress()
                    ];
                });
                break;
            
        default:
            console.error('Tipo de reporte no reconocido:', reportType);
            return;
    }

    const tableId = reportType + 'Table';
    const table = document.getElementById(tableId).querySelector('tbody');
    table.innerHTML = '';

    data.forEach(rowData => {
        const row = document.createElement('tr');
        rowData.forEach(cellData => {
            const cell = document.createElement('td');
            cell.textContent = cellData;
            row.appendChild(cell);
        });
        table.appendChild(row);
    });
    reportImage.style.display = 'none';
    // Mostrar la tabla correspondiente y ocultar las demás
    document.querySelectorAll('#reportArea table').forEach(tab => {
        if (tab.id === tableId) {
            tab.style.display = 'table';
        } else {
            tab.style.display = 'none';
        }
    });
}
    // Reiniciar valores de los registros
    function resetRegisters() {
        updateRegisters({});
        updateFlags({});
    }

    // Inicializar depuración
    function startDebug() {
        debugLines = codeArea.value.split('\n');
        currentLineIndex = 0;
        highlightCurrentLine();
        nextLineButton.style.display = 'block';
    }

    // Ejecutar la siguiente línea en modo de depuración
    function nextLine() {
        if (currentLineIndex < debugLines.length) {
            const line = debugLines[currentLineIndex].trim();
            if (line) {
                outputArea.textContent += `\nEjecutando línea ${currentLineIndex + 1}: ${line}`;
                // Aquí puedes agregar la lógica para ejecutar la línea actual
            }
            currentLineIndex++;
            highlightCurrentLine();
        } else {
            nextLineButton.style.display = 'none';
        }
    }

    // Resaltar la línea actual en el área de código
    function highlightCurrentLine() {
        const lines = codeArea.value.split('\n');
        const highlightedLines = lines.map((line, index) => {
            if (index === currentLineIndex) {
                return `<span class="highlight">${line}</span>`;
            }
            return line;
        });
        codeArea.innerHTML = highlightedLines.join('\n');
    }

    function startTime() {
        start = performance.now();
    }
    function endTime() {
        const end = performance.now();
        document.getElementById('timer').innerHTML = `Análisis terminado en: ${(end - start).toFixed(2)} milisegundos.`
    }

    // Eventos y listeners
    codeArea.addEventListener('input', () => {
        updateLineNumbers();
        toggleDebugButton();
    });
    codeArea.addEventListener('scroll', syncScroll);
    document.getElementById('openFile').addEventListener('click', () => fileInput.click());
    fileInput.addEventListener('change', loadFile);
    document.getElementById('saveFile').addEventListener('click', saveFile);
    document.getElementById('analyzeButton').addEventListener('click', analyzeCode);
    document.getElementById('runButton').addEventListener('click', runCode);
    document.getElementById('clearOutput').addEventListener('click', clearOutput);
    document.getElementById('generateReport').addEventListener('click', showReportOptions);
    document.getElementById('cstReport').addEventListener('click', () => generateReport('cst'));
    document.getElementById('quadReport').addEventListener('click', () => generateReport('quad'));
    document.getElementById('symbolTableReport').addEventListener('click', () => generateReport('symbol'));
    document.getElementById('errorReport').addEventListener('click', () => generateReport('errors'));
    document.getElementById('resetRegisters').addEventListener('click', resetRegisters);
    debugButton.addEventListener('click', startDebug);
    nextLineButton.addEventListener('click', nextLine);

    // Inicialización
    updateLineNumbers(); // Actualizar números de línea inicialmente
    syncScroll(); // Sincronizar scroll de números de línea y editor
    updateRegisters({}); // Inicializar tabla de registros
    updateFlags({}); // Inicializar tabla de flags
    toggleDebugButton(); // Deshabilitar botón de depuración si no hay texto
});
