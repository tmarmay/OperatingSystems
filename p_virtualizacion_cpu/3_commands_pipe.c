//https://www.youtube.com/watch?v=8LdQ09Ep9RY
#include <assert.h>
#include <sys/wait.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>

#define READ 0
#define WRITE 1

int main(void){

	int fd1[2],fd2[2]; 
    int status,pid;

	pipe(fd1); /*Comunica ls y grep*/ 

	pid = fork();

	//hijo
	if (pid == 0){
		close(fd1[READ]);
		dup2(fd1[WRITE],STDOUT_FILENO);
		close(fd1[WRITE]);
        
		execlp("/bin/ls", "ls", "-l", NULL);

	}
	//padre
	else{
		
        close(fd1[WRITE]); 
		// esta mal dup2(fd1[READ], STDIN_FILENO);
		// estal mal close(fd1[READ]);
        // esta mal wait(NULL);
        
        pipe(fd2);

        pid = fork();
        
        if (pid == 0){
            
            close(fd2[READ]); //PORQUE QUIERO ESCRIBIR PARA LA SALIDA DEL PROX
            
            dup2(fd1[READ],STDIN_FILENO);
            close(fd1[READ]);

            dup2(fd2[WRITE],STDOUT_FILENO);
            close(fd2[WRITE]);
            
            execlp("/bin/grep", "grep", "u", NULL);
        }

        else{
            
            close(fd1[READ]);
            close(fd2[WRITE]);

            pid = fork();

            if (pid == 0){

                dup2(fd2[READ],STDIN_FILENO);
                close(fd2[READ]);
                execlp("/usr/bin/wc", "wc", NULL);
            }            
        }
	}
    close(fd2[READ]);
    wait(&status);
    wait(&status);
    wait(&status);

	return 0;
}
