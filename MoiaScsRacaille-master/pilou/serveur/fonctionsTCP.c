#include "fonctionsTCP.h"

//erreur ligne 64


int socketClient(char *nomMachine, ushort uPort) {
  char chaine[TAIL_BUF];   /* buffer */
  int sock,                /* descripteur de la socket locale */
      port,                /* variables de lecture */
      err;                 /* code d'erreur */
  char* ipMachServ;        /* pour solution inet_aton */
  char* nomMachServ;       /* pour solution getaddrinfo */
  struct sockaddr_in addSockServ;  
                           /* adresse de la socket connexion du serveur */
  struct addrinfo hints;   /* parametre pour getaddrinfo */
  struct addrinfo *result; /* les adresses obtenues par getaddrinfo */ 
  socklen_t sizeAdd;       /* taille d'une structure pour l'adresse de socket */

  /* verification des arguments */
  if (nomMachine == NULL || uPort < 0) {
    return -1;
  }
  
  ipMachServ = nomMachine; nomMachServ = nomMachine;
  port = uPort;
  printf("nomMachine : %s, port = %d \n",nomMachine, uPort);
  /* 
   * creation d'une socket, domaine AF_INET, protocole TCP 
   */
  sock = socket(AF_INET, SOCK_STREAM, 0);
  if (sock < 0) {
    perror("(client) erreur sur la creation de socket");
    return -2;
  }
  
  /* 
   * initialisation de l'adresse de la socket - version inet_aton
   */
  /*
  addSockServ.sin_family = AF_INET;
  err = inet_aton(ipMachServ, &addSockServ.sin_addr);
  if (err == 0) { 
    perror("(client) erreur obtention IP serveur");
    close(sock);
    return -3;
  }
  

  addSockServ.sin_port = htons(port);
  bzero(addSockServ.sin_zero, 8);
 	
  sizeAdd = sizeof(struct sockaddr_in);
  */
  /* 
   *  initialisation de l'adresse de la socket - version getaddrinfo
   */
  
  memset(&hints, 0, sizeof(struct addrinfo));
  hints.ai_family = AF_INET; // AF_INET / AF_INET6 
  hints.ai_socktype = SOCK_STREAM;
  hints.ai_flags = 0;
  hints.ai_protocol = 0;
  
  
  // récupération de la liste des adresses corespondante au serveur
  char *portStr = malloc(15 * sizeof(char));
  snprintf(portStr, 15, "%d", uPort);
  printf("port = %s| \n", portStr);
  err = getaddrinfo(nomMachServ, portStr, &hints, &result); //nomMachine : numéro de port en char*
  if (err != 0) {
    perror("(client) erreur sur getaddrinfo");
    close(sock);
    return -3;
  }
  
  addSockServ = *(struct sockaddr_in*) result->ai_addr;
  sizeAdd = result->ai_addrlen;
  
			     
  /* 
   * connexion au serveur 
   */
  err = connect(sock, (struct sockaddr *)&addSockServ, sizeAdd); 
  printf("addresse machine = %s \n", nomMachine);
  if (err < 0) {
    perror("(client) erreur a la connection de socket");
    close(sock);
    return -4;
  }
  
  
  return sock;
}

int socketServeur(ushort uPort) {
    int err;
    int sock = socket(AF_INET, SOCK_STREAM, 0);
    if (sock < 0) {
        perror("(serveur) erreur de socket");
        return -1;
    }

    socklen_t len = sizeof(struct sockaddr_in);
    struct sockaddr_in addr;
    addr.sin_family = AF_INET;
    addr.sin_port = htons(uPort);
    addr.sin_addr.s_addr = INADDR_ANY;
    bzero(addr.sin_zero, 8);

    // Bind
    err = bind(sock, (struct sockaddr *)&addr, len);
    if (err < 0) {
        perror("(serveur) bind");
        return -2;
    }


    // Listen
    err = listen(sock, 10);  // 10 connexions simultanees
    if (err < 0) {
        perror("(serveur) listen");
        return -3;
    }


    return sock;
}

int socketServeurAccept(int sock) {
    // Accept
    struct sockaddr_in addr;
    socklen_t len = sizeof(struct sockaddr_in);
    int sockTrans = accept(sock, (struct sockaddr *)&addr, &len);
    if (sockTrans < 0) {
        perror("(serveurTCP) erreur sur accept");
        return -1;
    }
    printf("(serveur) accept OK\n");

    return sockTrans;
}