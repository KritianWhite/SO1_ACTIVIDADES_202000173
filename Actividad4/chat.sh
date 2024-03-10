#!/bin/bash

# Crear los pipes
rm -f chat_1 chat_2
mkfifo chat_1 chat_2

# Función para leer y escribir en los pipes
chat() {
    local pipe_in=$1
    local pipe_out=$2
    local nombre=$3

    while true; do
        # Leer del pipe de entrada
        read -r mensaje <$pipe_in
        if [ "$mensaje" = "salir" ]; then
            echo "Saliendo del chat..."
            break
        fi

        # Imprimir el mensaje recibido
        echo "${nombre}: ${mensaje}"

        # Solicitar un nuevo mensaje
        echo -n "${nombre}: " >&2
        read -r mensaje

        # Escribir en el pipe de salida
        echo "$mensaje" >$pipe_out
    done
}

# Iniciar los procesos de chat
chat chat_1 chat_2 "Usuario 1" &
chat chat_2 chat_1 "Usuario 2" &

# Esperar a que los procesos terminen
wait

# Eliminar los pipes
rm -f chat_1 chat_2