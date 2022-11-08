#include <unistd.h>
#include <string.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
int main(void){
	char file[] = "hola.txt";
	//Abrir el archivo
	FILE *myfile = fopen(file,"w+");
	//Defino buffer
	char buffer[] = {'a','b'};
	//Escribir en archivo el contenido del buffer
	fwrite(buffer,sizeof(buffer),1,myfile);
	//Cerrar archivo
	fclose(myfile);
}
