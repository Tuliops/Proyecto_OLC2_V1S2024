let errorTable, symbolTable, Arm64Editor, consoleResult, dotStringCst = "";
/*Scrips Code Mirror */
$(document).ready(function () {
    Arm64Editor = editor('editor', 'text/x-rustsrc');
    consoleResult = editor('console', '', false, true, false);


});

function editor(id, language, lineNumbers = true, readOnly = false, styleActiveLine = true) {
    return CodeMirror.fromTextArea(document.getElementById(id), {
        lineNumbers: true,
        styleActivateLine: true,
        matchBrackets: true,
        theme: "midnight",
        scrollbarStyle: "null",
        mode: "text/x-rustsrc"


    });
}

/**
 * Tabla de Errores 
 */
function getErrors() {

    let info = '<tr><th>No.</th><th>Tipo</th><th>Descripción</th><th>Linea</th><th>Columna</th></tr>'
    document.getElementById('errors-report').innerHTML = info


}
function getSymbolsTable() {

    let info = '<tr><th>No.</th><th>ID</th><th>Tipo</th><th>Tipo de Dato</th><th>Entorno</th><th>Linea</th><th>Columna</th></tr>'
    document.getElementById('symb-report').innerHTML = info


}
function getTokens() {

    let info = '<tr><th>No.</th><th>Lexema</th><th>Token</th><th>Linea</th><th>Columna</th></tr>'
    document.getElementById('tokens-report').innerHTML = info


}

/** Abrir Archivo */
const openFile = async (editor) => {
    console.log('click en open file ')
    let fileInput = document.createElement('input')
    fileInput.type = 'file'
    fileInput.addEventListener('change', function (event) {
        let file = event.target.files[0]
        let reader = new FileReader()
        reader.readAsText(file, 'utf-8')
        console.log(reader)
        try {
            reader.onload = function (e) {
                var contenido = e.target.result;
                editor.setValue(contenido);
            }
        } catch (error) {
            editor.setValue('error en la carga del archivo intente de nuevo ')
        }

    });
    fileInput.click();
}

/**Guardar achivo .s  */
const saveFile = async (editor) => {
    const text = Arm64Editor.getValue();
    var archivoBlob = new Blob([text], { type: 'text/plain' });
    // Crear un enlace para descargar el archivo
    var enlaceDescarga = document.createElement("a");
    enlaceDescarga.href = window.URL.createObjectURL(archivoBlob);

    // Solicitar al usuario que ingrese un nombre de archivo
    var nombreArchivo = prompt("Por favor, ingresa el nombre del archivo:", "nombreArchivo");
    nombreArchivo += ".s"
    if (nombreArchivo) {
        enlaceDescarga.download = nombreArchivo;

        // Ocultar el enlace
        enlaceDescarga.style.display = "none";

        // Agregar el enlace al cuerpo del documento y hacer clic en él
        document.body.appendChild(enlaceDescarga);
        enlaceDescarga.click();

        // Eliminar el enlace del cuerpo del documento
        document.body.removeChild(enlaceDescarga);
    }
}

/*limpiar consola */
const cleanEditor = (editor) => {
    editor.setValue("");
    consoleResult.setValue('')
}


/* Analizador*/

const analysis = async () => {
    const text = Arm64Editor.getValue();
    try {
        iniciarContador();
        let resultado = PARSE.parse(text);
        terminarContador();
        var jsonString = JSON.stringify(resultado, null, 2);

        consoleResult.setValue(jsonString);
        

    } catch (error) {
        consoleResult.setValue(error.message);
    }
}

const btnClean = document.getElementById('clearButton'),
    btnOpen = document.getElementById('btn__open'),
    btnSave = document.getElementById('btn__save'),
    btnAnalysis = document.getElementById('btn__analysis');




btnOpen.addEventListener('click', () => openFile(Arm64Editor));
btnClean.addEventListener('click', () => cleanEditor(Arm64Editor));
btnAnalysis.addEventListener('click', () => analysis());
btnSave.addEventListener('click', () => saveFile());


/**contador para ejecucion */

let contadorId;

// Función para iniciar el contador
// Función para iniciar el contador
function iniciarContador() {
    tiempoInicio = performance.now(); // Guardar el tiempo de inicio en milisegundos
    console.log('Contador iniciado.');
  }
  
  // Función para terminar el contador y mostrar la duración en nanosegundos
  function terminarContador() {
    const tiempoFin = performance.now(); // Guardar el tiempo de fin en milisegundos
    const duracionEnNanosegundos = (tiempoFin - tiempoInicio) * 1000000; // Convertir la duración a nanosegundos
    console.log(`La duración del contador es ${duracionEnNanosegundos} nanosegundos.`);
    document.getElementById('contador').innerHTML = `La duración del Analisis es ${tiempoFin - tiempoInicio} milisegundos.`
  }