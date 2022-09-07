#include <stdbool.h>
#include "command.h"
#include <glib.h>
#include "strextra.h"
#include <stdio.h>

#include <string.h>
#include <stdlib.h>

struct scommand_s {
    GQueue *list;
    char *redir_in;
    char *redir_out;
};

scommand scommand_new(void) {
    scommand result = malloc(sizeof(struct scommand_s));
    assert(result != NULL);
    result->redir_in = NULL;
    result->redir_out = NULL;
    result->list = NULL;
    assert(scommand_is_empty(result) && scommand_get_redir_in(result) == NULL && scommand_get_redir_out(result) == NULL);
    return result;
}

//Requires: self != NULL preguntar si es con assert o if 
//Chequear con valgrind si esta bien el free del queue
scommand scommand_destroy(scommand self){
    assert(self != NULL);
    if (self != NULL){
        free(self->redir_in);
        self->redir_in = NULL;
        
        free(self->redir_out);
        self->redir_out = NULL;
        
        g_queue_free(self->list);
        self->list = NULL;
        self = NULL;
    }
    return self;
}

void scommand_push_back(scommand self, char * argument){
    assert(self != NULL && argument != NULL);
    
    //CASO LISTA VACIA
    if (self->list == NULL){
        self->list = g_queue_new();
        g_queue_push_tail(self->list,argument);
    }
    else{
        g_queue_push_tail(self->list,argument);
    }
    
    assert(!scommand_is_empty(self));
}
//pregutar si esta bien el assert
void scommand_pop_front(scommand self){
    assert(self!=NULL && !scommand_is_empty(self));
    char * aux = scommand_front(self);
    free (aux);
    g_queue_pop_head(self->list);
}

void scommand_set_redir_in(scommand self, char * filename){
    assert(self != NULL);
    self->redir_in = filename;
}

void scommand_set_redir_out(scommand self, char * filename){
    assert(self != NULL);
    self->redir_out = filename;
}

/* Proyectores */
bool scommand_is_empty(const scommand self){
    assert(self != NULL);
    bool result = g_queue_is_empty(self->list);
    return result;
}

unsigned int scommand_length(const scommand self){
    assert(self!=NULL);
    unsigned int length = 0u;
    length = (self->redir_in != NULL) ? length + 1u : length;
    length = (self->redir_out != NULL) ? length + 1u : length;
    length = length + (unsigned int)g_queue_get_length(self->list); 
    assert((length == 0u) == scommand_is_empty(self));
    return length;
}

char * scommand_get_redir_in(const scommand self){
    assert(self != NULL);
    return self->redir_in;
}

char * scommand_get_redir_out(const scommand self){
    assert(self != NULL);
    return self->redir_out;
}

char * scommand_front(const scommand self){
    assert(self != NULL);
    assert(!scommand_is_empty(self));
    char *result = g_queue_peek_head(self->list);
    assert(result != NULL);
    return result;
}

char * scommand_to_string(const scommand self){
    char *str = strdup("");

    if (self != NULL){

        unsigned int length = g_queue_get_length(self->list);
        if (length > 0){
            for (unsigned int i = 0u; i < g_queue_get_length(self->list); i++){
                str = strmerge(str,(char*)g_queue_peek_nth(self->list,(guint)i));
                if (i < g_queue_get_length(self->list) -1) {
                    str = strmerge(str, " ");
                }
               
            }

            if (self->redir_out != NULL){
                str = strmerge(str, " > ");
                str = strmerge(str,self->redir_out);
    
            }

            if (self->redir_in != NULL){
                str = strmerge(str, " < ");
                str = strmerge(str,self->redir_in);
                //str = strmerge(" ",str);    
            }
        }
    }
   
    assert(scommand_is_empty(self) || scommand_get_redir_in(self)==NULL || scommand_get_redir_out(self)==NULL || strlen(str)>0);
    return str;
}





/*
 * pipeline: tubería de comandos.
 * Ejemplo: ls -l *.c > out < in  |  wc  |  grep -i glibc  &
 * Secuencia de comandos simples que se ejecutarán en un pipeline,
 *  más un booleano que indica si hay que esperar o continuar.
 *
 * Una vez que un comando entra en el pipeline, la memoria pasa a ser propiedad
 * del TAD. El llamador no debe intentar liberar la memoria de los comandos que
 * insertó, ni de los comandos devueltos por pipeline_front().
 * pipeline_to_string() pide memoria internamente y debe ser liberada
 * externamente.
 *
 * Externamente se presenta como una secuencia de comandos simples donde:
 *           ______________________________
 *  front -> | scmd1 | scmd2 | ... | scmdn | <-back
 *           ------------------------------
 */


// Pipeline

struct pipeline_s {
    GQueue *pipe;
    bool wait;
};

pipeline pipeline_new(void) {
    pipeline result = malloc(sizeof(struct pipeline_s));
    result->pipe = NULL; 
    /* 
    Preguntar sobre las funciones de new
    Tal vez estamos haciendo alloc 2 veces 
    */
    result->wait = true;
    
    assert((result != NULL 
    && pipeline_is_empty(result)) 
    && pipeline_get_wait(result));

    return result;
}

pipeline pipeline_destroy(pipeline self) {
    assert(self != NULL);
    g_queue_free(self->pipe);
    self->pipe = NULL;
    free(self);
    return NULL;
}

void pipeline_push_back(pipeline self, scommand sc) {
    assert(self != NULL && sc != NULL);

    if (self->pipe == NULL)
    {
        self->pipe = g_queue_new();
        g_queue_push_tail(self->pipe, sc);
  }
    else
    {
        g_queue_push_tail(self->pipe, sc);
    }
}

void pipeline_pop_front(pipeline self) {
    assert(self != NULL && !pipeline_is_empty(self));
    scommand aux = pipeline_front(self);
    free(aux);
    g_queue_pop_head(self->pipe);

}

void pipeline_set_wait(pipeline self, const bool w) {
    assert(self != NULL);
    self->wait = w;
}

scommand pipeline_front(const pipeline self) {
    assert(self != NULL);
    assert(!pipeline_is_empty(self));
    scommand front;
    front = g_queue_peek_head(self->pipe);
    return front;
}

bool pipeline_is_empty(const pipeline self){
    assert(self != NULL);
    return (g_queue_is_empty(self->pipe));
}

unsigned int pipeline_length(const pipeline self){
    assert(self!=NULL);
    unsigned int length = 0u;
    length = length + (unsigned int)g_queue_get_length(self->pipe); 
    assert((length == 0u) == pipeline_is_empty(self));
    return length;
}

bool pipeline_get_wait(const pipeline self){
    assert(self != NULL);
    return self->wait;
}
//diferenciar el caso | con &
char * pipeline_to_string(const pipeline self){

    char *result = strdup("");
    if (self != NULL){
        unsigned int length = g_queue_get_length(self->pipe);
        if (length > 0){
            for (unsigned int i=0u; i < length; i++){
                result = strmerge(result,scommand_to_string(g_queue_peek_nth(self->pipe,(guint)i)));    
                if ( i < length -1){
                    result = strmerge(result," | ");
                }
            }
            if (self->wait == false){
                result = strmerge(result, " &");
            }
        }

    }
    
    assert(pipeline_is_empty(self) || pipeline_get_wait(self) || strlen(result)>0);
    return result;
}

