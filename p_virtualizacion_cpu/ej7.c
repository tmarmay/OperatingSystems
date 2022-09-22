#include <unistd.h>
#include <stdio.h>

int main(int argc, char **argv) {

	printf("cant argu %d \n",argc);
	for (int i = 0; i < argc+1; i++){
		printf("argumento %d, %s \n",i,argv[i]);
	}
	/*Voy a tener el nombre del programa, los argumentos y al ultimo un null indicando el final */
	/**/
	if (0 < --argc) {
		argv[argc] = NULL;
		execvp(argv[0], argv);
	}
	else{
		printf("no hago nada \n");
	}
	printf("---------------------------------------");
	return 0;
}
