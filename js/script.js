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
        mode: "text/x-rustsrc"
        
      
    });
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

/*limpiar consola */
const cleanEditor = (editor) => {
    editor.setValue("");
    consoleResult.setValue('')
}


/* Analizador*/

const analysis = async () => {
    const text = Arm64Editor.getValue();
    try {

        let resultado = PARSE.parse(text);
        var jsonString = JSON.stringify(resultado, null, 2);

        consoleResult.setValue(jsonString);


    } catch (error) {
        consoleResult.setValue(error.message);
    }
}

const btnClean = document.getElementById('clearButton'),
    btnOpen = document.getElementById('btn__open'),
    btnAnalysis = document.getElementById('btn__analysis');



btnOpen.addEventListener('click', () => openFile(Arm64Editor));
btnClean.addEventListener('click', () => cleanEditor(Arm64Editor));
btnAnalysis.addEventListener('click', () => analysis());