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