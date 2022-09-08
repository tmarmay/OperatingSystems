#include "execute.h"
#include <assert.h>
#include <sys/wait.h>
#include <unistd.h>
#include <string.h>
#include "command.h"
#include "builtin.h"
#include "strextra.h"

static void execute_scommand(scommand cmd) {
    assert(cmd != NULL);
    char **argument_list;
    unsigned int length;
    char *aux;

    // Si es interno, usa las funciones de builtin para correr el comando
    if (builtin_is_internal(cmd)) {
        builtin_run(cmd);

    // Sino, usa execvp()
    } else {
        length = scommand_length(cmd);
        argument_list = malloc(length * sizeof(char *));

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

        // Ejecuta el comando
        execvp(argument_list[0], argument_list);

        //Libera memoria
        scommand_destroy(cmd);  
        for (unsigned int i = 0u; i < length + 1; i++) {
            aux = argument_list[i];
            free(aux);
        }
        free(argument_list);
    }

}

//al principio no iria un if viendo si es interno y llamando al builtin
void execute_pipeline(pipeline apipe) {
    assert(apipe != NULL);
    unsigned int length = pipeline_length(apipe);
    scommand cmd;
    int rc_wait = 0;
    int rc = 0;

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
        } else{
            //+++COMPLETAR+++
        }

    pipeline_destroy(apipe);
    }
}

/*
 * Ejecuta un pipeline, identificando comandos internos, forkeando, y
 *   redirigiendo la entrada y salida. puede modificar `apipe' en el proceso
 *   de ejecución.
 *   apipe: pipeline a ejecutar
 * Requires: apipe!=NULL
 */
