# Informe del Grupo N°30

-----  

### Laboratorio 2 - Sistema de archivos Big Brother   

### Integrantes:  

- Bruno Volpini  
    - email: bruno.volpini@mi.unc.edu.ar  

- Ignacio Ramirez  
    - email: ignaciotramirez@mi.unc.edu.ar  

- Tomas Marmay  
    - email: tomas.marmay@mi.unc.edu.ar  

- Kevin Prieto  
    - email: kevin-prieto@mi.unc.edu.ar  

    
-----


### ¿Cómo compilar?

        $ git clone https://marmiiT@bitbucket.org/sistop-famaf/so22lab4g30.git
        $ cd so22lab4g30
        $ make 
        $ mkdir mnt 
        $ ./fat-fuse resources/fatfs.img ./mnt
            - Para montar la imagen
        $ ./fat-fuse -d resources/fatfs.img ./mnt
            - Para ver en tiempo real las fat-fuse operations
        $ ./fat-fuse -f resources/fatfs.img ./mnt
            -Para debug mode

-----

### *Coding style*

    FALTA
    la ultima respuesta ya esta lista

-----

### Respuestas

## Cuando se ejecuta el main con la opción -d, ¿qué se está mostrando en la pantalla? :
- Se muestran todas las fuse operations que se están haciendo en tiempo real mientras usamos fat_fuse.

##### ¿Hay alguna manera de saber el nombre del archivo guardado en el cluster 157? :
- No, no hay manera de saber, ya que dentro de cada entrada de la fat_table solo está la memoria que mapea, un offset de la estructura, el número de cluster, un offset por donde inician los datos, un file descriptor para escribir/leer  y su cluster order.


##### ¿Dónde se guardan las entradas de directorio? ¿Cuántos archivos puede tener adentro un directorio en FAT32?:
- Se guardan dependiendo del cluster order, ya que nos determina el tamaño del directorio y eso nos dice el número de dir entries que puede tener, es decir la cantidad de archivos.


##### Cuando se ejecuta el comando como ls -l, el sistema operativo, ¿llama a algún programa de usuario? 
 - ###### ¿A alguna llamada al sistema? ¿Cómo se conecta esto con FUSE? ¿Qué funciones de su código se ejecutan finalmente? :
    -El sistema operativo no llama a ningún programa de usuario, y tampoco hace ninguna llamada del sistema. Esto se debe a que toda la información ya está guardada en el árbol de fat_fuse, así que no necesita leerlo de otro lado. 
    Fat_fuse, a nivel interno, abre el directorio en el que se encuentra, para ver sus atributos (OPENDIR , GETATTR, READDIR, LOOKUP ) y obtener de esta manera a sus hijos. Luego itera, hasta que no le quede ningún hijo, mientras usa lookup y getattr.


##### ¿Por qué tienen que escribir las entradas de directorio manualmente pero no tienen que guardar la tabla FAT cada vez que la modifican? :
    -Es necesario que se modifiquen las entradas de directorio ya que dentro de estas están marcados los archivos que se deben ignorar por estar eliminados y nos permite ver como esta formado el árbol de archivos. Mientras que la FAT es una lista enlazada para agilizar los accesos a discos que esta guardada en RAM.

##### Para los sistemas de archivos FAT32, la tabla FAT, ¿siempre tiene el mismo tamaño? En caso de que sí, ¿qué tamaño tiene? :
    -Si, el número de clusters es constante (4.294.967.264), que es aproximadamente 2^32. Que se debe a como esta impementado la estructura de la fat table. Podemos ver que la cantidad de cluster esta representada con un u32 (unsigned int de 32 bits), por lo tanto la max capacidad es de 2^32. Por otro lado el tamaño de un solo cluster es de 2^9 = 512 bytes. 
    Entonces el tamaño de la tabla FAT32 es de (2^32)*(2^9) = 2^41 = 2TB 
    
-----

## Conclusion

    - En este lab aprendimos como funciona fat-fuse (sistema de archivos) y lo facil que es ocultar informacion al usuario desde la implementacion 



