// Mostrar la consola
function showConsole() {
    document.getElementById('consolePopup').style.display = 'block';
    document.getElementById('consoleInput').focus();
}

// Ocultar la consola
function hideConsole() {
    document.getElementById('consolePopup').style.display = 'none';
}

// Imprimir en la consola
function printToConsole(message) {
    const consoleOutput = document.getElementById('consoleOutput');
    consoleOutput.textContent += message + '\n';
    consoleOutput.scrollTop = consoleOutput.scrollHeight; // Scroll hacia abajo automáticamente
}

// Limpiar la consola
function clearConsole() {
    document.getElementById('consoleOutput').textContent = '';
}

// Manejar entrada de comandos en la consola
document.getElementById('consoleInput').addEventListener('keypress', function (e) {
    if (e.key === 'Enter') {
        const command = e.target.value;
        printToConsole(`> ${command}`);
        handleConsoleCommand(command);
        e.target.value = ''; // Limpiar el campo de entrada después de enviar el comando
    }
});

function handleConsoleCommand(command) {
    // Implementa aquí la lógica para manejar comandos específicos
    // Ejemplo básico:
    switch (command.toLowerCase()) {
        case 'clear':
            clearConsole();
            break;
        case 'help':
            printToConsole('Lista de comandos disponibles:\n - clear: Limpiar la consola\n - help: Mostrar ayuda');
            break;
        default:
            printToConsole(`Comando no reconocido: ${command}`);
            break;
    }
}

// Manejadores para botones u otros eventos
document.getElementById('closeConsole').addEventListener('click', hideConsole);

// Ejemplo de cómo mostrar la consola (llamar a showConsole() donde sea necesario)
document.getElementById('bashButton').addEventListener('click', showConsole);
