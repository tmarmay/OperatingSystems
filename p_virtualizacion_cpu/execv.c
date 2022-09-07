#include <stdio.h>
#include <unistd.h>

int main(void){
	char * const args[] = {"/bin/date", "-R", NULL};
	execv(args[0], args);
	printf("a\n");
}
