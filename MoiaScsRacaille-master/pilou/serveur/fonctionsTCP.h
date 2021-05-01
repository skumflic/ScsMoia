

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <errno.h>
#define TAIL_BUF 20

#ifndef TCP
#define TCP


    int socketClient(char *nomMachine, ushort uPort);
    int socketServeur(ushort uPort); 
    int socketServeurAccept(int sock);

#endif