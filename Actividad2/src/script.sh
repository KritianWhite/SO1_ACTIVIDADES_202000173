# Leer variable de entrada
GITHUB_USER=$1

# Consultar API de GitHub
API_URL="https://api.github.com/users/${GITHUB_USER}"
USER_DATA=$(curl -s ${API_URL})

# Extraer datos
USER_ID=$(echo ${USER_DATA} | jq '.id')
USERNAME=$(echo ${USER_DATA} | jq -r '.login')
CREATED_AT=$(echo ${USER_DATA} | jq -r '.created_at')

# Imprimir saludo 
echo "Hola ${USERNAME}. User ID: ${USER_ID}. Cuenta fue creada el: ${CREATED_AT}."

# Crear directorio y archivo de log
LOG_DIR=/tmp/$(date +%Y-%m-%d)
LOG_FILE="${LOG_DIR}/saludos.log"
mkdir -p ${LOG_DIR}

# Escribir en log
echo "Hola ${USERNAME}. User ID: ${USER_ID}. Cuenta fue creada el: ${CREATED_AT}." >> ${LOG_FILE}

# Agendar ejecución cada 5 minutos
echo "*/5 * * * * ${0} ${GITHUB_USER}" > /tmp/github_cron
crontab /tmp/github_cron
rm /tmp/github_cron