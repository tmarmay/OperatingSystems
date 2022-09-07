#include <stdbool.h>
#include "command.h"
#include <glib.h>
#include "strextra.h"
#include <stdio.h>

#include <string.h>
#include <stdlib.h>

struct scommand_s {
    GQueue *list;
    char *c_in;
    char *c_out;
};

char * scommand_to_string(const scommand self){
    assert(self != NULL);
    char *str = (char*)calloc(1,sizeof(char));
    str = "";
    if (self->list != NULL){
        for (unsigned int i = 0u; i < g_queue_get_length(self->list); i++){
            str = strmerge(str,(char*)g_queue_peek_nth(self->list,(guint)i));
            //str = strmerge(" ",str);
        }
    }
    if (self->c_out != NULL){
        str = strmerge(str, ">");
        str = strmerge(str,self->c_out);
        //str = strmerge(" ",str);    
    }

    if (self->c_in != NULL){
        str = strmerge(str, "<");
        str = strmerge(str,self->c_in);
        //str = strmerge(" ",str);    
    }   
    printf("es vacio %d",scommand_is_empty(self));

    printf("redirec in vacio %d", scommand_get_redir_in(self)==NULL);
    printf("redirec ou es vacio: %d",scommand_get_redir_out(self)==NULL);
    printf("strlen %d",strlen(str)>0);
    assert(scommand_is_empty(self) || scommand_get_redir_in(self)==NULL || scommand_get_redir_out(self)==NULL || strlen(str)>0);
    return str;
}
int main(void){
    scommand t = NULL;
    printf("%s",scommand_to_string(t));
    return 0;
}