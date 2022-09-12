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
/* Diferencia entre esperar y no esperar a un proceso,
   Es decir hacerlo en background o no*/
/*
int main(void){
	//EJEMPLO SIN BACKGROUND
	int rc = fork();

	if (rc == 0 ){
		execlp("/usr/bin/xeyes","xeyes", NULL);
	}

	else{
		wait(NULL);
	}
	return 0;
}
*/


int main(void){
	//EJEMPLO BACKGROUND
        int rc = fork();

        if (rc == 0 ){
                execlp("/usr/bin/xeyes","xeyes", NULL);
        }

        else{
                printf("Padre termina\n");
        }
        return 0;
}
