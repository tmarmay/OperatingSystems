#include <stdbool.h>
#include <stdio.h>
#include <assert.h>
#include <string.h>
#include <unistd.h>
#include "builtin.h"
#include "command.h"


// Preguntar si esta forma de checkear los comandos internos es correcta
#define INTERNO_SIZE 3
const char* INTERNO[] = {"cd", "help", "exit"};
/* 
 * cd = 0
 * help = 1
 * exit = 2
 */ 

/* Indica si el comando alojado en `cmd` es un comando interno
 */
bool builtin_is_internal(scommand cmd) {
    assert(cmd != NULL);
    bool result = false;
    for(int i = 0; i < INTERNO_SIZE; i++){
        if(strcmp(scommand_front(cmd), INTERNO[i]) == 0){
            result = true;
        }
    }
    return result;
}


/* Indica si el pipeline tiene solo un elemento y si este se corresponde a un
 * comando interno.
 * REQUIRES: p != NULL
 * ENSURES:
 * builtin_alone(p) == pipeline_length(p) == 1 &&
 *                     builtin_is_internal(pipeline_front(p))
 */
bool builtin_alone(pipeline p) {
    assert(p != NULL);
    bool result = false;
    if((pipeline_length(p) == 1 ) && builtin_is_internal(pipeline_front(p))) {
        result = true;
    }
    return result;
}


static void read_help_file(){

    FILE *help_file = fopen(".hidden/mybash_help.txt", "r");

    if (help_file == NULL){
        printf("Error opening the file"); //ver si conviene sacar por stderr
        exit(EXIT_SUCCESS); // preguntar si no seria el exitfa
    }

    int response = fgetc(help_file);

    while(response != EOF){
        printf("%c", response);
        response = fgetc(help_file);
    }

    fclose(help_file);
}


/* Ejecuta un comando interno
 * REQUIRES: {builtin_is_internal(cmd)}
 */
void builtin_run(scommand cmd) {
    assert(builtin_is_internal(cmd));

    char* front;
    front = strdup(scommand_front(cmd));

    if(strcmp(front,INTERNO[0]) == 0) {
            scommand_pop_front(cmd);
            chdir(scommand_front(cmd));
            scommand_destroy(cmd);
    }
     // Falta implementar "help" y "exit"
    if(strcmp(front,INTERNO[1]) == 0) {
        read_help_file();
    }
    if(strcmp(front,INTERNO[2]) == 0) {
        printf("exit");
    }

}

