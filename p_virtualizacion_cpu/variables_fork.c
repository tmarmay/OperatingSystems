#include <sys/types.h>
#include <unistd.h>
#include <stdio.h>

int main(void){
	int x = 100;

	int rc = fork();

	if (rc < 0){
		printf("error \n");
	}

	else if (rc == 0){
		x = 50;
		printf("proceso hijo, variable x = %d \n",x);
	}

	else{
		printf("proceso padre, variable x = %d \n",x);
	}
	return 0;
}
