LD_FLAGS = 

all: serveur 

serveur: serveur.o fonctionsTCP plateau
	gcc -Wall --std=gnu99 -g kamisado-fPIC.o fonctionsTCP.o plateau.o serveur.o -o serveur

serveur.o: serveur.c 
	gcc -Wall --std=gnu99 -g -c serveur.c

fonctionsTCP: fonctionsTCP.c fonctionsTCP.h
	gcc -Wall --std=gnu99 -g -c fonctionsTCP.c

plateau: plateau.c plateau.h
	gcc -Wall --std=gnu99 -g -c plateau.c

clean:
	rm serveur.o && rm fonctionsTCP.o && rm plateau.o
mrproper:
	rm serveur
