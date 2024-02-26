# Actividad 3 - Systemd Unit

1. Creamos un script llamado `saludo.sh` con el siguiente contenido:

    ```bash
    #!/bin/bash
    while true; do
        echo "Hola, ¡Bienvenido! La fecha y hora actual es: $(date)"
        sleep 1
    done
    ```

2. Guardamos el script en un directorio apropiado, en mi caso lo guardé en `/usr/local/bin/`.

3. Le damos permisos de ejecución al script con el siguiente comando:

    ```bash
    chmod +x /usr/local/bin/saludo.sh
    ```

4. Se crea un archivo de unidad de systemd llamado `saludo.service` en `/etc/systemd/system/`:

    ```bash
    sudo nano /etc/systemd/system/saludo.service
    ```

5. En el archivo de unidad de systemd, agregamos el siguiente contenido:

    ```plaintext
    [Unit]
    Description=Saludo y fecha
    After=network.target

    [Service]
    Type=simple
    ExecStart=/usr/local/bin/saludo.sh
    Restart=always

    [Install]
    WantedBy=multi-user.target
    ```

6. Guardamos y cerramos el archivo.

7. Habilitamos el servicio para que se inicie con el sistema:

    ```bash
    sudo systemctl enable saludo.service
    ```

8. Inicializamos el servicio:

    ```bash
    sudo systemctl start saludo.service
    ```

