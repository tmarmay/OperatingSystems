#include <stdio.h>
#include <assert.h>
#include <sys/wait.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <time.h>
#include <stdlib.h>
/*Redirijir salida/entrada desde un archivo*/

// redireccion de salida (>)
/*
int main(void){

	char direc[] = "prueba_redir.txt";
	int op = open(direc,O_WRONLY);
	dup2(op,STDOUT_FILENO);
	close(op);
	printf("Programa finalizado");
	return 0;
}
*/

// redireccion de entrada (<)
int main(void){

        char direc[] = "prueba_redir.txt";
        int op = open(direc,O_RDONLY);
        dup2(op,STDIN_FILENO);
	//printf("Programa finalizado");
	close(op);
        execlp("/usr/bin/wc","wc",NULL);
	return 0;
}


