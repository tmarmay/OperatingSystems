#include "command.h"
#include <stdlib.h>
#include <glib.h>

struct scommand_s{
    GList *list;
    char *c_in;
    char *c_out;
};

//Agregar el 'argument' al final de la lista de comandos de self (self.list)
void scommand_push_back(scommand self, char * argument){
    if (self!=NULL && argument!=NULL){
        if (!scommand_is_empty(self)){
            self->list = g_list_append(self->list,argument);
        }
        //preguntar
        else{
            //erro scommand empty
            EXIT_FAILURE();    
        }        
    }
    //preguntar
    else{
        //error de todo null
        EXIT_FAILURE();
    }     
}


//Elimina el ultimo elemento de self.list 
void scommand_pop_front(scommand self){
    if (self != NULL && !scommand_is_empty(self)){
        int length = g_list_length(self->list);
        self->list = g_list_delete_link(self->list,length-1);
    }
    //misma respuesta que arriba
    else{

    }
}

