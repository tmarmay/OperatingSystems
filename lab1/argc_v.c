#include <stdio.h>
#include <unistd.h>

int main(int argc, char **argv){
	int a = argc
	printf("%d",a);

	if (0<--argc){
		argv[argc] = NULL;
		execvp(argv[0],argv);
	}
	return 0;
}
