#include "fonctionsTCP.h"
#include "plateau.h"
#include "protocolKamisado.h"
#include "serv.h"
#include "validation.h"


/*==========================================*/
/*===============FONCTIONS==================*/
/*==========================================*/

void fillPartieRep(TPartieRep *reponseJ1, TPartieRep *reponseJ2, TPartieReq *reqJ1, TPartieReq *reqJ2)
{
	for (int i = 0; i < 30; i++)
	{
		reponseJ1->nomAdvers[i] = reqJ2->nomJoueur[i];
		reponseJ2->nomAdvers[i] = reqJ1->nomJoueur[i];
	}

	reponseJ1->validCoul = OK;

	if (reqJ1->pion == reqJ2->pion)
	{
		reponseJ2->validCoul = KO;
		// le j1 garde sa couleur
		if (reqJ1->pion == BLANC)
		{
			reqJ2->pion = NOIR;
		}
		else
		{
			reqJ2->pion = BLANC;
		}
		// ERR_PARTIE ?
	}
	else
	{
		reponseJ2->validCoul = OK;
	}
}

int fillStructJoueurs(Joueur *joueur1, Joueur *joueur2, TPartieReq *reqJ1, TPartieReq *reqJ2)
{
	int tour;
	if (reqJ1->pion == BLANC)
	{
		// le joueur 1 commence
		tour			  = 0;
		joueur1->couleurJ = BLANC;
		joueur2->couleurJ = NOIR;
		for (int k = 0; k < 30; k++)
		{
			joueur1->nomJoueur[k] = reqJ1->nomJoueur[k];
		}
		joueur1->numeroJ = 1;
		joueur1->score   = 0;

		for (int k = 0; k < 30; k++)
		{
			joueur2->nomJoueur[k] = reqJ2->nomJoueur[k];
		}
		joueur2->numeroJ = 2;
		joueur2->score   = 0;
	}
	else
	{
		tour			  = 1;
		joueur1->couleurJ = NOIR;
		joueur2->couleurJ = BLANC;
		for (int k = 0; k < 30; k++)
		{
			joueur2->nomJoueur[k] = reqJ2->nomJoueur[k];
		}
		joueur2->numeroJ = 1;
		joueur2->score   = 0;

		for (int k = 0; k < 30; k++)
		{
			joueur1->nomJoueur[k] = reqJ1->nomJoueur[k];
		}
		joueur1->numeroJ = 2;
		joueur1->score   = 0;
	}

	return tour;
}


void printDebugPartieReq(TPartieReq *tabPartieReq, int nbrPartieReq)
{
	printf("Voici ce qui a été reçu : \n\n");
	printf("TIdReq : %d\n", tabPartieReq[nbrPartieReq].idReq);
	printf("nom joueur : ");
	for (int i = 0; i < 30; i++)
	{
		printf("%c", tabPartieReq[nbrPartieReq].nomJoueur[i]);
	}
	printf("\n");

	switch (tabPartieReq[nbrPartieReq].pion)
	{
	case BLANC: printf("couleur pion souhaitée : BLANC \n"); break;

	case NOIR: printf("couleur pion souhaitée : NOIR \n"); break;
	}
}


void copyCoupRep(TCoupRep *repOrigine, TCoupRep *repDestination)
{
	repDestination->err		  = repOrigine->err;
	repDestination->propCoup  = repOrigine->propCoup;
	repDestination->validCoup = repOrigine->validCoup;
}


/*==========================================*/
/* ============ MAIN =======================*/
/*==========================================*/


int main(int argc, char **argv)
{
	/* if (argc != 2) {
		 printf("Usage : ./serveur name port\n");
		 return -1;
	 }*/

	// ushort portServeur = atoi(argv[1]);


	/*==========================================*/
	/* ============ VARIABLES ==================*/
	/*==========================================*/
	Plateau plateau;
	initPlat(&plateau);
	drawPlateau(&plateau);

	int   partieN; // COMPTEUR DE PARTIE
	short portServeur = atoi(argv[1]);
	int   sockConx	= socketServeur(portServeur);

	int sockJoueurComm[2]; // Les deux sockets de comm. pour les joueurs

	TPartieReq tabPartieReq[2];
	TPartieRep tabPartieRep[2];

	Joueur joueurs[2];


	int nbrPartieReq = 0;

	bool shouldContinue = true;


	/* ================== ATTENTE DES CONNEXIONS ===========*/
	int nbrJoueur = 0;
	for (;;)
	{

		sockJoueurComm[nbrJoueur] = socketServeurAccept(sockConx);
		nbrJoueur++;
		printf("(serveur) Nouvelle connexion au serveur (connexion numero %d)\n", nbrJoueur);


		if (nbrJoueur == 2)
		{
			break;
		}
	}
	/*==================================================================*/
	/* ================== ATTENTE DES DEUX REQUETES PARTIES  ===========
	====================================================================*/

	int requete;
	// int received;
	while (nbrPartieReq < 2)
	{

		int received = 0;
		int print	= 0; // debug
		do
		{
			// printf("boucle\n");
			received = recv(sockJoueurComm[nbrPartieReq], &tabPartieReq[nbrPartieReq], sizeof(TPartieReq), MSG_PEEK);
			if (print < 10)
			{
				printf("received = %d\n", received);
				print++;
			}
		} while (received != sizeof(TPartieReq));

		received = recv(sockJoueurComm[nbrPartieReq], &tabPartieReq[nbrPartieReq], sizeof(TPartieReq), 0);
		if (received < 0)
		{
			perror("serveur: erreur dans la reception");
			shutdown(sockJoueurComm[nbrPartieReq], SHUT_RDWR);
			close(sockJoueurComm[nbrPartieReq]);
			return -2;
		}
		else
		{
			tabPartieRep[nbrPartieReq].err = ERR_OK;
		}

		printf("Voici ce qui a été reçu : \n\n");
		printf("TIdReq : %d\n", tabPartieReq[nbrPartieReq].idReq);
		printf("nom joueur : ");
		for (int i = 0; i < 30; i++)
		{
			printf("%c", tabPartieReq[nbrPartieReq].nomJoueur[i]);
		}
		printf("\n");

		switch (tabPartieReq[nbrPartieReq].pion)
		{
		case 0: printf("couleur pion souhaitée : BLANC \n"); break;

		default:
			printf("couleur : %d", tabPartieReq[nbrPartieReq].pion);
			printf("couleur pion souhaitée : NOIR \n");
			tabPartieReq[nbrPartieReq].pion = NOIR;
			break;
		}


		printf("%d\n", tabPartieReq[nbrPartieReq].pion);
		nbrPartieReq++;
	}


	/*=============================================================*/
	/*===================== REPONSES AUX JOUEURS ==================*/
	/*==============================================================*/

	fillPartieRep(&tabPartieRep[0], &tabPartieRep[1], &tabPartieReq[0], &tabPartieReq[1]);


	int sen = send(sockJoueurComm[0], &tabPartieRep[0], sizeof(TPartieRep), 0);
	sen		= send(sockJoueurComm[1], &tabPartieRep[1], sizeof(TPartieRep), 0);


	int whoStartsIndex = fillStructJoueurs(&joueurs[0], &joueurs[1], &tabPartieReq[0], &tabPartieReq[1]);
	int tour		   = whoStartsIndex;
	// int tour = 0;

	// boucle de jeu


	// debug
	printf("Affichage des joueurs : \n");
	printf("Joueur arrivé en premier : %s numero %d score %d \n", joueurs[0].nomJoueur, joueurs[0].numeroJ, joueurs[0].score);
	printf("Joueur arrivé en second : %s numero %d score %d \n", joueurs[1].nomJoueur, joueurs[1].numeroJ, joueurs[1].score);

	/*============================================================
	|                  GESTION DES PARTIES                       |
	==============================================================*/

	TCoupReq tabCoupReq[2];
	TCoupRep tabCoupRep[2];

	/*=============================================================*/
	/*===================== BOUCLE DE JEU =========================*/
	/*=============================================================*/


	partieN		  = 1;
	int cptBoucle = 0;

	initialiserPartie();
	while (partieN < 3)
	{
		printf("Partie n° %d\n", partieN);
		cptBoucle++;
		int  recvd;
		int  req;
		bool validate;
		int  sende;
		bool timeoutover = false;
		/*init timeout to 6 seconds*/
		struct timeval tv;
		tv.tv_sec  = 6;
		tv.tv_usec = 0;
		setsockopt(sockJoueurComm[tour], SOL_SOCKET, SO_RCVTIMEO, (const char *)&tv, sizeof tv);

		do
		{
			recvd = recv(sockJoueurComm[tour], &tabCoupReq[tour], sizeof(TCoupReq), MSG_PEEK);
			if (recvd <= 0)
			{
				// nothing received ?
				printf("nothing received in the last 6 seconds\n");
				// informer du timeout
				timeoutover = true;
				break;
			}
		} while (recvd != sizeof(TCoupReq));

		recvd = recv(sockJoueurComm[tour], &tabCoupReq[tour], sizeof(TCoupReq), 0);
		if (recvd <= 0)
		{
			perror("serveur: erreur dans la reception");
			shutdown(sockJoueurComm[tour], SHUT_RDWR);
			close(sockJoueurComm[tour]);
			return -2;
		}
		else
		{
			tabCoupRep[tour].err = ERR_OK;
		}


		// Gestion du coup reçu
		if (tabCoupReq[tour].numPartie != partieN)
		{
			// erreur ?
		} // gerer les autres erreurs TODO

		TPropCoup propCoup;

		if (timeoutover)
		{
			tabCoupRep[tour].validCoup = TIMEOUT;
			tabCoupRep[tour].propCoup  = PERDU;
			tabCoupRep[tour].err	   = ERR_COUP;
		}
		else
		{
			validate = validationCoup(joueurs[tour].numeroJ, tabCoupReq[tour], &propCoup);
			if (!validate)
			{
				// le coup est non valide donc TRICHE si pas deja TIMEOUT
				tabCoupRep[tour].validCoup = TRICHE;
				tabCoupRep[tour].propCoup  = PERDU;
				tabCoupRep[tour].err	   = ERR_COUP;

				joueurs[-1 * tour + 1].score++;
			}
			else
			{
				// le coup est valide MAIS il faut vérifier la propriété du coup
				plateauMove(&plateau, joueurs[tour], &tabCoupReq[tour].coul, tabCoupReq[tour].deplPion.caseDep, tabCoupReq[tour].deplPion.caseArr);
				drawPlateau(&plateau);

				// scanf(&arret);
				switch (propCoup)
				{
				case GAGNE:
					tabCoupRep[tour].validCoup = VALID;
					tabCoupRep[tour].err	   = ERR_OK;
					tabCoupRep[tour].propCoup  = GAGNE;
					joueurs[tour].score++;

					// on envoie uniquement les rep aux deux joueurs

					break;
				case NUL:
					tabCoupRep[tour].validCoup = VALID;
					tabCoupRep[tour].err	   = ERR_OK;
					tabCoupRep[tour].propCoup  = NUL;

					break;
				case PERDU:
					tabCoupRep[tour].validCoup = VALID;
					tabCoupRep[tour].err	   = ERR_OK;
					tabCoupRep[tour].propCoup  = PERDU;

					joueurs[-1 * tour + 1].score++;
					break;
				case CONT: // on envoie les rep et la req à l'autre joueur
					tabCoupRep[tour].validCoup = VALID;
					tabCoupRep[tour].err	   = ERR_OK;
					tabCoupRep[tour].propCoup  = CONT;
					break;
				}
			}
		}
		sende = send(sockJoueurComm[0], &tabCoupRep[tour], sizeof(TCoupRep), 0);
		sende = send(sockJoueurComm[1], &tabCoupRep[tour], sizeof(TCoupRep), 0);

		if (propCoup == CONT && validate && !timeoutover)
		{
			sende = send(sockJoueurComm[-1 * tour + 1], &tabCoupReq[tour], sizeof(TCoupReq), 0);
			tour  = -1 * tour + 1;
		}
		else
		{
			initialiserPartie();
			partieN++;
			printf("Partie terminée ! \n\t scores \n\t\t%s : %d\n\t\t%s : %d\n\n\n\n", joueurs[0].nomJoueur, joueurs[0].score, joueurs[1].nomJoueur,
				   joueurs[1].score);
			if (joueurs[tour].numeroJ == 1)
			{
				tour						   = -1 * tour + 1;
				joueurs[tour].numeroJ		   = 2;
				joueurs[-1 * tour + 1].numeroJ = 1;
			}
			else
			{
				joueurs[tour].numeroJ		   = 1;
				joueurs[-1 * tour + 1].numeroJ = 2;
			}
			// tour = -1 * whoStartsIndex + 1;
		}

		printf("tour vaut : %d \n", tour);
		printf("joueur est : %s de numero %d \n", joueurs[tour].nomJoueur, joueurs[tour].numeroJ);
	}

	shutdown(sockJoueurComm[0], SHUT_RDWR);
	close(sockJoueurComm[0]);

	shutdown(sockJoueurComm[1], SHUT_RDWR);
	close(sockJoueurComm[1]);

	return 0;
}