#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

int main(void)
{
	int fd = open("salida.txt", O_CREAT|O_WRONLY|O_TRUNC, S_IRWXU);
	printf("salida tiene un file descriotor inicial indexado por %d \n", fd);
	close(STDOUT_FILENO);
	int r = dup(fd);
	printf("Como cierro stdout (fd 1) salida deberia volver 1 \n");
	printf("el numero de file descriptor de salida es %d \n",r);
	return 0;
}
