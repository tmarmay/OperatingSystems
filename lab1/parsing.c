#include <stdlib.h>
#include <stdbool.h>
#include <assert.h>
#include <glib.h>
#include "parsing.h"
#include "parser.h"
#include "command.h"

/* Si no incluyo la definicion del struct tira error */
struct scommand_s {
    GQueue *list;
    char *redir_in;
    char *redir_out;
};

struct pipeline_s {
    GQueue *pipe;
    bool wait;
};

static scommand parse_scommand(Parser p) {
    /* Devuelve NULL cuando hay un error de parseo */
    assert(p != NULL);
    
    scommand result;
    result = scommand_new();
    arg_kind_t *type = NULL;
    char *arg = NULL;

    while (parser_next_argument(p, type) != NULL){
        arg = parser_next_argument(p, type);
        if (*type == ARG_INPUT){
            result->redir_in = arg;
        }
        else if (*type == ARG_OUTPUT){
            result->redir_out = arg;
        }
        else { 
            scommand_push_back(result,arg);
        }
    }
    return result;
}

pipeline parse_pipeline(Parser p) {
    assert(p != NULL);
    assert(!parser_at_eof(p));
    pipeline result = pipeline_new();
    scommand cmd = NULL;
    bool error = false; 
    bool another_pipe= true;
    bool background = false;
    
    cmd = parse_scommand(p);
    error = (cmd==NULL); /* Comando inválido al empezar */
   
    while (another_pipe && !error) {
        parser_skip_blanks(p);
        pipeline_push_back(result,cmd);
        parser_op_pipe(p,&another_pipe);
        parser_garbage(p,&error);
    }
    parser_op_background(p,&background);
    pipeline_set_wait(result,background);

    if (error == true)
    {
        return NULL;
    }
    
    /* Tolerancia a espacios posteriores */
    /* Consumir todo lo que hay inclusive el \n */
    /* Si hubo error, hacemos cleanup */

    return result; 
}
