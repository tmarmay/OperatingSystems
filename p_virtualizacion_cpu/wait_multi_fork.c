#include <assert.h>
#include <sys/wait.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>

int main(void){
	int rc = fork();
	int status;
	if (rc == 0 ){
		printf("soy el hijo1 \n");
	}
	else{
//		wait(NULL);
		int rc2 = fork();
		if (rc2 == 0){
			printf("soy el hijo2 \n");
		}
		else{
//			wait(NULL);
			printf("soy el padre\n");
		}
	}
	wait(&status);
	wait(&status);
	return 0;
}
