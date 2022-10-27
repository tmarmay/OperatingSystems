#include <unistd.h>
#include <assert.h>
#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>

int main(int argc, char **argv){
	//Me aseguro que van a entrear dos comandos
	/*
	if(argc < 2){
		//1 para cmd1 1 para cmd2 1 para |
		printf("Los comandos deben estar separados por | \n");
		printf("Solo acepta dos comandos concatenados por un | \n");
		return 1;
	}	 
	
	//Parseo argumentos
	char *cmd1 = (char*)calloc(argc,sizeof(char));;
	char *cmd2 = (char*)calloc(argc,sizeof(char));
	int cmd1_counter = 0;
	int cmd2_counter = 0;
	bool parsing_1cmd = true;
	for (unsigned int i=0u; i<argc; i++){
		if (argv[i] != "|"){ 
			if (parsing_1cmd){
				if (argv[i] != " "){
					cmd1[cmd1_counter] = argv[i];
					cmd1_counter++;
				}
			}
			else{
				if (argv[i] != " "){
					cmd2[cmd2_counter] = argv[i];
					cmd2_counter++;
				}
			}
		}
		else if (argv[i] == "|"){
			parsing_1cmd = false;
		}
	}
	cmd1[cmd1_counter] = NULL;
	cmd2[cmd2_counter] = NULL;
	*/
	int fd[2];	//Creo la tuveria
	
	if (pipe(fd) == -1){
		return 1;
	}

	int rc = fork();
	//Hijo
	if (rc == 0){
		if (close(fd[0]) == -1) {return 1;}	//Cierro lectura
		if (dup2(fd[1],STDOUT_FILENO) == -1) {return 1;}	//Envez de escupir en stdout lo tira por la tuvria
		if (close(fd[1]) == -1) {return 1;}	//Cierro lo que ya no necesito

		//if (execvp(cmd1[0],**cmd1) == -1) {return 1;}	//Ejecuta el comando
		if (execlp("/bin/ls","ls","-l",NULL) == -1) {return 1;}
		return 0;
	}
	//Error
	else if (rc == -1){
		return 1;
	}
	//Padre
	else{
		if (close(fd[1]) == -1) {return 1;}	//Cierro escritura
		if (dup2(fd[0],STDIN_FILENO) == -1) {return 1;} // Envez de leer por stdin lo hace por el pipe
		if (close(fd[0]) == -1) {return 1;}	//Cierro lo que ya no necesito

		wait(NULL);		//Espero a que el hijo me tire la salida del primer comando
		//if (execvp(cmd2[0],**cmd2) == -1) {return 1;}	//Ejecuta el comando
		if (execlp("/usr/bin/wc","wc",NULL) == -1) {return 1;}
	}
	return 0;
}
