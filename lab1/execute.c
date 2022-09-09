#include "execute.h"
#include <assert.h>
#include <sys/wait.h>
#include <unistd.h>
#include <string.h>
#include "command.h"
#include "builtin.h"
#include "strextra.h"

static bool is_redirIn(scommand cmd){
    return (scommand_get_redir_in(cmd) == NULL);
}

static bool is_redirOut(scommand cmd){
    return (scommand_get_redir_out(cmd) == NULL);
}

static void free_mem(scommand cmd, char **argument_list, unsigned int length){
    char *aux;
    scommand_destroy(cmd);
    for (unsigned int i = 0u; i < length + 1; i++){
        aux = argument_list[i];
        free(aux);
    }
    aux = NULL;
    free(argument_list);
    argument_list = NULL;
}

static char **exec_cmd_parsing(unsigned int length, scommand cmd){
    char *aux;
    char **argument_list = malloc(length * sizeof(char *));

    //Parseo los argumentos del cmd en la forma que execvp() los necesita
    for (unsigned int i = 0u; i < length; i++) {
        aux = scommand_front(cmd);
        argument_list[i] = malloc(strlen(aux));
        scommand_pop_front(cmd);

        // Agrega NULL como ultimo elemento del array
        if (i == (length-1)) {
            argument_list[i + 1u] = malloc(0);
            argument_list[i+1] = NULL;
        }
    }
    return argument_list;
}

static void execute_scommand(scommand cmd) {
    assert(cmd != NULL);
    char **argument_list;
    unsigned int length;
    int fd[2]; 

    // Si es interno, usa las funciones de builtin para correr el comando
    if (builtin_is_internal(cmd)) {
        builtin_run(cmd);

    // Sino, usa execvp()
    } else {       
         
        length = scommand_length(cmd);
        
        argument_list = exec_cmd_parsing(length,cmd);

        /*
        //aca tengo que ver si usa los redirecores o no
        if() {
         
        //ver que hacer con toda esta parte
        } else {
        // Ejecuta el comando
        if (execvp(argument_list[0], argument_list) == -1) { exit(EXIT_FAILURE) }; // o va un assert ?
        }
        */

        //Libera memoria
        free_mem(cmd,argument_list,length);
    }
}


//al principio no iria un if viendo si es interno y llamando al builtin
void execute_pipeline(pipeline apipe) {
    assert(apipe != NULL);
    unsigned int length = pipeline_length(apipe);
    scommand cmd;
    int rc_wait = 0;
    int rc = 0;
    char *redir_in,redir_out;

    for (unsigned int i = 0u; i < length; i++){
        cmd = pipeline_front(apipe);
        pipeline_pop_front(apipe);
        rc_wait = pipeline_get_wait(apipe);

        //-Caso en el que hay que esperar
        if (rc_wait) {
            rc = fork();
            assert(!(rc < 0));
            //Hijo
            if (rc == 0){
                execute_scommand(cmd);
            }

            //Padre
            else{
                rc_wait = wait(NULL);
            }
            //+++Verificar que el fork no explote+++


        //-Caso en el que NO esperamos
            // no esperar signifa hacerlo por background enotnces no esperar seria hacer lo mismo que arriba pero sin el wait 
        } else{
            rc = fork();
            assert(!(rc < 0));
            //Hijo
            if (rc == 0){
                execute_scommand(cmd); //no me ejecutaria un comando y despues se muere ? 
            }
        }
 
    }
    if(!pipeline_is_empty(apipe)) {
        pipeline_destroy(apipe);
    }
}

