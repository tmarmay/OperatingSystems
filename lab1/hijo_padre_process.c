//conlcusiones es que se ejecuta el hijo primero si esta el wait y dspues que se termina se elimina el proceso

#include <sys/wait.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
int main(void){
	printf("iniciando prueba \n");
	int rc = fork();

	if (rc < 0){
		printf("error  \n");
	}

	else if (rc == 0){
		int i = 10;
		printf("soy el niñp, mi pid: %d  \n",getpid());
		while(i > 0){
			sleep(2);
			i = i-1;
		}
		//exit(EXIT_SUCCESS); si no lo pongo es como qu estuviera  
	}

	else{
		//wait(NULL);
		printf("soy el padre, mi pid: %d  \n",getpid());
		//int i = 10;
		//while(i > 0){
		//	printf("esperando  \n");
		//	i = i-1;
		//	sleep(10);
		//}

	}

	printf("final");
	return 0;
}
