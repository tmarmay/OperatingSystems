#include "execute.h"
#include <assert.h>
#include <sys/wait.h>
#include <unistd.h>
#include <string.h>
#include "command.h"
#include "builtin.h"
#include "strextra.h"
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include "tests/syscall_mock.h"
#define READ 0 
#define WRITE 1 

char *invalid_cmd = "Ingrese un comando valido \n";
char *pipe_error = "Error abriendo el pipe \n";
char *fork_error = "Error ejecutando fork \n";
char *dup2_error = "Error en dup2";
char *close_pipe_error = "Error cerrando el pipe";
//FALTA COMPLETAR
//PREGUNTAR SI TENGO QUE HACER UN RETURN CUANDO SALE UN ERROR
//PREGUNTAR SI ES NECAESARIOS HACER LOS COMANDOS INTERNOS FUERA DEL FORK(NO DEJAN HIJOS HUERFANOS)
//ARREGLAR EL ERROR DE EXIT
//FALTA REDIRECTORES
//CUANDO TODO ESTE TERMINADO ELIMINAR COMENTARIOS INNECESARIOS

static char **exec_cmd_parsing(unsigned int length, scommand cmd){
    char **argument_list = calloc(length + 1, sizeof(char));

    //Parseo los argumentos del cmd en la forma que execvp() los necesita
    for (unsigned int i = 0u; i < length; i++) {
        argument_list[i] = strdup(scommand_front(cmd));
        scommand_pop_front(cmd);
    }

    // Agrega NULL como ultimo elemento del array
    argument_list[length] = NULL;
    return argument_list;
}

static void execute_scommand(scommand cmd) {
    assert(cmd != NULL);
    unsigned int length = scommand_length(cmd);
  
    char **argument_list = exec_cmd_parsing(length,cmd);
  
    if (execvp(argument_list[0], argument_list) == -1) { write(STDOUT_FILENO,invalid_cmd,strlen(invalid_cmd)); } 
}

void execute_pipeline(pipeline apipe) {
    assert(apipe != NULL);

    if (pipeline_is_empty(apipe)) {
        write(STDOUT_FILENO,invalid_cmd,strlen(invalid_cmd)); 
        if(apipe != NULL) { apipe = NULL; }
    } else if (builtin_alone(apipe)) {
        builtin_run(pipeline_front(apipe));
        pipeline_pop_front(apipe);
    } else {

        unsigned int length = pipeline_length(apipe); //cantidad de comandos simples
        scommand cmd = pipeline_front(apipe);
        bool have2_wait = pipeline_get_wait(apipe);
        int fd1[2],fd2[2];
        int status,pid;

        if (pipe(fd1) == -1) { write(STDOUT_FILENO,pipe_error,strlen(pipe_error));} //Comunicar primer y segundo comando
        pid = fork();

        /* Hijo: ejecuta primer comando */
        if (pid == 0){
            if (length > 1){
                /* Preparar la entrada/salida */
                close(fd1[READ]);
                
                dup2(fd1[WRITE],STDOUT_FILENO);
                close(fd1[WRITE]);

            }
            /* Ejecuta */
            //execlp("/bin/ls", "ls","-l", NULL);
            (builtin_is_internal(cmd)) ? builtin_run(cmd) : execute_scommand(cmd);
        }

        else if( pid == -1 ){ write(STDOUT_FILENO,fork_error,strlen(fork_error));}
        
        /*Padre: sigue con la ejecucion*/
        else{
            length = length - 1; /* Ya se ejecuto un comando*/
            if (length > 0){
            
                close(fd1[WRITE]);  
                
                pipeline_pop_front(apipe);
                cmd = pipeline_front(apipe);

                if (pipe(fd2) == -1) { write(STDOUT_FILENO,pipe_error,strlen(pipe_error)); }  
                pid = fork();

                /* Hijo: ejecuta segundo comando */
                if (pid == 0){
                    /* Preaparar la entrada/salida */

                    dup2(fd1[READ],STDIN_FILENO);
                    close(fd1[READ]);

                    if (length > 1){
                        close(fd2[READ]);
                        dup2(fd2[WRITE],STDOUT_FILENO);
                        close(fd2[WRITE]);
                    }
                    /* Ejecuta */
                    //execlp("/bin/grep", "grep", "u", NULL);
                    (builtin_is_internal(cmd)) ? builtin_run(cmd) : execute_scommand(cmd);
                }

                else if ( pid == -1 ){ write(STDOUT_FILENO,fork_error,strlen(fork_error)); }
                
                else{
                    length = length - 1; /* Ya se ejecutaron dos comandos*/ 
                    close(fd1[READ]);
                
                    if (length > 0){
                        close(fd2[WRITE]);

                        pipeline_pop_front(apipe);
                        cmd = pipeline_front(apipe);        

                        pid = fork();
                        /* Hijo: ejecuta segundo comando */
                        if (pid == 0){
                            /* Preaparar la entrada/salida */
                            dup2(fd2[READ],STDIN_FILENO);
                            close(fd2[READ]);

                            /* Ejecuta */
                            execlp("/usr/bin/wc", "wc", NULL);
                            //(builtin_is_internal(cmd)) ? builtin_run(cmd) : execute_scommand(cmd);
                        }
                        else if ( pid == -1 ){ write(STDOUT_FILENO,fork_error,strlen(fork_error)); }
                    }
                }

            }
        }

        close(fd2[READ]);
        if (have2_wait) {
            wait(&status);
            wait(&status);
            wait(&status);
         }
    }
}