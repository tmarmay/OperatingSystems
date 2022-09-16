#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "command.h"
#include "execute.h"
#include "parser.h"
#include "parsing.h"
#include "builtin.h"
#include <unistd.h>

/* Colores prompt */
#define ANSI_COLOR_GREEN   "\x1b[92m"
#define ANSI_COLOR_CYAN    "\x1b[36m"
#define ANSI_COLOR_RESET   "\x1b[0m"

static void show_prompt(void) {
    char *user = malloc(256);
    char *dir = malloc(256);
    gethostname(user,256);
    dir = getcwd(dir,256);

    printf (ANSI_COLOR_GREEN "%s@mybash:",user);
    printf (ANSI_COLOR_CYAN"~%s",dir);
    printf (ANSI_COLOR_RESET"$");
    
    free(user);
    free(dir);
    user = NULL;
}

int main(int argc, char *argv[]) {
    pipeline pipe;
    pipe = pipeline_new(); 
    Parser input;
    bool quit = false;

    
    while (!quit) { /* Hay que salir luego de ejecutar? -> NO, se deberia usar exit o algo por el estilo*/
        show_prompt();
        input = parser_new(stdin);
        pipe = parse_pipeline(input);
        execute_pipeline(pipe);
        //fflush (stdout);        /* Imprime en pantalla la salida estandar */
        quit = parser_at_eof(input);
    }
    
    if (input != NULL) {parser_destroy(input); input = NULL;}
    if (pipe != NULL) {pipeline_destroy(pipe);}
    return EXIT_SUCCESS;
}