//https://www.youtube.com/watch?v=8LdQ09Ep9RY
#include <assert.h>
#include <sys/wait.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>

int main(void){

	int fd[2]; 
	//f[0] read
	//f[1] write 

	if (pipe(fd) == -1){
		printf("paso un errror \n");
		return 2;
	}


	int rc = fork();

	//hijo
	if (rc == 0){
		close(fd[0]);
		if (dup2(fd[1],STDOUT_FILENO) == -1){
			return 4;
		}

		close(fd[1]);
		if (execlp("/bin/ls", "ls", "-l","> ../" , NULL) == -1){
			return 9;
		}

	}
	//error
	else if ( rc < 0){
		return 5;
	}
	//padre
	else{
		close(fd[1]);
		if (dup2(fd[0], STDIN_FILENO) == -1){
			return 7;
		}
		close(fd[0]);
		execlp("/bin/grep", "grep", "u", NULL);
		wait(NULL);
	}





	return 0;
}
