#include "command.h"


struct scommand_s {
    GQueue *list;
    char *c_in;
    char *c_out;
};

scommand scommand_new(void) {
    scommand result = malloc(sizeof(struct scommand_s));
    assert(result != NULL);
    result->c_in = NULL;
    result->c_out = NULL;
    result->list = NULL;
    assert(scommand_is_empty(result) && scommand_get_redir_in(result) == NULL && scommand_get_redir_out(result) == NULL);
    return result;
}

//Requires: self != NULL preguntar si es con assert o if 
//Chequear con valgrind si esta bien el free del queue
scommand scommand_destroy(scommand self){
    if (self != NULL){
        free(self->c_in);
        self->c_in = NULL;
        
        free(self->c_out);
        self->c_out = NULL;
        
        g_queue_free(self->list);
        self->list = NULL;
        self = NULL;
    }
    return self;
}

//pregutar si envez de hacer no iria un if para devolver una especie de error
void scommand_push_back(scommand self, char * argument){
    assert(self != NULL && argument != NULL);
    g_queue_push_tail(self->list,argument);
    assert(!scommand_is_empty(self));
}
//pregutar si esta bien el assert
void scommand_pop_front(scommand self){
    assert(self!=NULL && !scommand_is_empty(self));
    self->list = g_queue_pop_head(self->list);        
}

void scommand_set_redir_in(scommand self, char * filename){
    assert(self != NULL);
    self->c_in = filename;
}

void scommand_set_redir_out(scommand self, char * filename){
    assert(self != NULL);
    self->c_out = filename;
}

/* Proyectores */
// ejemplo de un comando es: ls -l ej1.c > out < in --> para que sea vacio todo tiene que estar en null
//preguntar si ese assert esta bien
bool scommand_is_empty(const scommand self){
    assert(self != NULL);
    return (self->list == NULL && self->c_in == NULL && self->c_out == NULL);
}


unsigned int scommand_length(const scommand self){
    assert(self!=NULL);
    unsigned int length = 0u;
    length = (self->c_in != NULL) ? length + 1u : length;
    length = (self->c_out != NULL) ? length + 1u : length;
    length = length + (unsigned int)g_queue_get_length(self->list); 
    assert((length == 0u) == scommand_is_empty(self));
    return length;
}

char * scommand_get_redir_in(const scommand self){
    assert(self != NULL);
    return self->c_in;
}

char * scommand_get_redir_out(const scommand self){
    assert(self != NULL);
    return self->c_out;
}

//FALTAE COMPLETAR PERO ESTA ES LA IDEA:
    //FALTARIA COMO CALCULAR EL TAMAÑO Y EL RESTO SALE 
//char *strncat(char *dest, const char *src, size_t n);
/*
char * scommand_to_string(const scommand self){
    assert(self != NULL);
    unsigned int length = scommand_length(self);
    *char str = calloc(sizeof(char) * length); 

    return str;
}
*/




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
