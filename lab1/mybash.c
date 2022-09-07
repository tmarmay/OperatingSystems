#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#include "command.h"
#include "execute.h"
#include "parser.h"
#include "parsing.h"
#include "builtin.h"

static void show_prompt(void) {
    printf ("mybash> ");
    fflush (stdout);
}

int main(int argc, char *argv[]) {
    pipeline pipe;
<<<<<<< HEAD
    pipe = pipe; //profe
=======
    pipe = pipe;
>>>>>>> a6d04bbd7f548019e2a153b632fbf73183a34118
    Parser input;
    bool quit = false;


    input = parser_new(stdin);
    while (!quit) {
        show_prompt();
        pipe = parse_pipeline(input);

        /* Hay que salir luego de ejecutar? */
        quit = parser_at_eof(input);

        printf("%s",pipeline_to_string(pipe));
    }
    parser_destroy(input); input = NULL;
    return EXIT_SUCCESS;
}

