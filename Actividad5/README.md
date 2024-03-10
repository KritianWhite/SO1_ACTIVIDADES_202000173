Código completo en C que crea los procesos y hilos:

```c
#include <stdio.h>
#include <unistd.h>
#include <pthread.h>

void *thread_func(void *arg) {
    printf("Hilo creado\n");
    return NULL;
}

int main() {
    pid_t pid;
    pthread_t tid;

    pid = fork();

    if (pid == 0) { /* child process */
        fork();
        pthread_create(&tid, NULL, thread_func, NULL);
        pthread_join(tid, NULL);
    } else if (pid > 0) { /* parent process */
        fork();
    } else {
        /* fork failed */
        printf("Error al crear el proceso\n");
        return 1;
    }

    return 0;
}
```

### a. ¿Cuántos procesos únicos son creados?
**Respuesta:** Se crean 5 procesos únicos en total.

1. El proceso original (padre) crea un hijo con `fork()`.
2. El proceso hijo crea otro hijo con `fork()`.
3. El proceso hijo original crea un hilo con `pthread_create()`.
4. El proceso padre original crea otro hijo con `fork()`.

Por lo tanto, tenemos el proceso original, 3 procesos hijos y 1 proceso nieto, dando un total de 5 procesos únicos.

### b. ¿Cuántos hilos únicos son creados?
**Respuesta:** Se crea 1 hilo único.

Sólo se crea un hilo en el proceso hijo original mediante la llamada `pthread_create()`. El programa espera a que el hilo termine antes de salir mediante la llamada `pthread_join()`.