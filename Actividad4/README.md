# CHAT BOT - ACTIVIDAD 4


chat.sh crea un sistema de chat simple entre dos usuarios utilizando pipes para la comunicación. Su funcionamiento es el siguiente:

1. Se eliminan los archivos `chat_1` y `chat_2` existentes (si los hay) con `rm -f chat_1 chat_2`.
2. Se crean dos pipes con el comando `mkfifo chat_1 chat_2`. Estos pipes se utilizarán para la comunicación entre los dos usuarios.

3. Se define una función llamada `chat` que toma tres argumentos: `pipe_in` (el pipe de entrada), `pipe_out` (el pipe de salida) y `nombre` (el nombre del usuario).

4. Dentro de la función `chat`, se ejecuta un bucle infinito `while true`. En cada iteración:
   - Se lee un mensaje del `pipe_in` utilizando `read -r mensaje <$pipe_in`.
   - Si el mensaje es "salir", se imprime "Saliendo del chat..." y se sale del bucle con `break`.
   - Se imprime el mensaje recibido con `echo "${nombre}: ${mensaje}"`.
   - Se solicita un nuevo mensaje al usuario con `echo -n "${nombre}: " >&2` y `read -r mensaje`.
   - Se escribe el mensaje introducido por el usuario en el `pipe_out` utilizando `echo "$mensaje" >$pipe_out`.

5. Se inician dos procesos en segundo plano (`&`) que ejecutan la función `chat`:
   - `chat chat_1 chat_2 "Usuario 1"`: este proceso lee de `chat_1` y escribe en `chat_2`.
   - `chat chat_2 chat_1 "Usuario 2"`: este proceso lee de `chat_2` y escribe en `chat_1`.

6. El script principal espera a que los dos procesos terminen con `wait`.

7. Finalmente, se eliminan los pipes con `rm -f chat_1 chat_2`.


## Ejecución y funcionamiento

Cuando se ejecuta este script, los dos usuarios pueden chatear entre sí enviando mensajes. Cada mensaje enviado por un usuario se escribe en el pipe de salida correspondiente y se lee desde el pipe de entrada del otro usuario. El chat continúa hasta que uno de los usuarios escriba "salir".

Por ejemplo, si el Usuario 1 escribe "Hola", el mensaje se mostrará en la terminal del Usuario 2 como "Usuario 1: Hola". Luego, el Usuario 2 puede responder escribiendo su mensaje, y este se mostrará en la terminal del Usuario 1. Este script demuestra cómo se pueden utilizar los pipes en Bash para establecer una comunicación bidireccional entre dos procesos.