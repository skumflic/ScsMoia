#include "fonctionsTCP.h"
#include "plateau.h"
#include "protocolKamisado.h"
#include "serv.h"
#include "validation.h"
#include <time.h>


/*==========================================*/
/*===============FONCTIONS==================*/
/*==========================================*/

void fillPartieRep(TPartieRep *reponseJ1, TPartieRep *reponseJ2, TPartieReq *reqJ1, TPartieReq *reqJ2)
{
	// verification du type de requete
	if (reqJ1->idReq != PARTIE)
	{
		reponseJ1->err = ERR_TYP;
	}

	if (reqJ2->idReq != PARTIE)
	{
		reponseJ2->err = ERR_TYP;
	}

	for (int i = 0; i < 30; i++)
	{
		reponseJ1->nomAdvers[i] = reqJ2->nomJoueur[i];
		reponseJ2->nomAdvers[i] = reqJ1->nomJoueur[i];
	}

	reponseJ1->validCoul = OK;

	if (reqJ1->pion == reqJ2->pion)
	{
		reponseJ2->validCoul = KO;
		// le joueur 1 garde la couleur demandée
		if (reqJ1->pion == BLANC)
		{
			reqJ2->pion = NOIR;
		}
		else
		{
			reqJ2->pion = BLANC;
		}
	}
	else
	{
		reponseJ2->validCoul = OK;
	}
}


int fillStructJoueursAndDetermineWhoStarts(Joueur *joueur1, Joueur *joueur2)
{
	int			tour;
	TPartieReq *reqJ1 = &joueur1->partieReq;
	TPartieReq *reqJ2 = &joueur2->partieReq;

	for (int i = 0; i < 30; i++)
	{
		joueur1->nomJoueur[i] = joueur1->partieReq.nomJoueur[i];
		joueur2->nomJoueur[i] = joueur2->partieReq.nomJoueur[i];
	}
	if (reqJ1->pion == BLANC)
	{
		// le joueur 1 commence
		tour			  = 0;
		joueur1->couleurJ = BLANC;
		joueur2->couleurJ = NOIR;
		joueur1->numeroJ  = 1;
		joueur1->score	= 0;
		joueur2->numeroJ  = 2;
		joueur2->score	= 0;
	}
	else
	{
		tour			  = 1;
		joueur1->couleurJ = NOIR;
		joueur2->couleurJ = BLANC;
		joueur2->numeroJ  = 1;
		joueur2->score	= 0;
		joueur1->numeroJ  = 2;
		joueur1->score	= 0;
	}

	return tour;
}

int waitForPartieReqs(Joueur *joueur1, Joueur *joueur2)
{
	int received = 0;
	do
	{
		received = recv(joueur1->socket, &joueur1->partieReq, sizeof(TPartieReq), MSG_PEEK);
	} while (received < sizeof(TPartieReq));

	received = recv(joueur1->socket, &joueur1->partieReq, sizeof(TPartieReq), 0);
	if (received < 0)
	{
		perror("serveur: erreur dans la reception");
		shutdown(joueur1->socket, SHUT_RDWR);
		close(joueur1->socket);
		return -2;
	}
	else
	{
		joueur1->partieRep.err = ERR_OK;
	}

	received = 0;
	do
	{

		received = recv(joueur2->socket, &joueur2->partieReq, sizeof(TPartieReq), MSG_PEEK);
	} while (received < sizeof(TPartieReq));

	received = recv(joueur2->socket, &joueur2->partieReq, sizeof(TPartieReq), 0);
	if (received < 0)
	{
		perror("serveur: erreur dans la reception");
		shutdown(joueur2->socket, SHUT_RDWR);
		close(joueur2->socket);
		return -2;
	}
	else
	{
		joueur1->partieRep.err = ERR_OK;
	}

	return 0;
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

	Joueur joueurs[2];								 // tableau de 2 struct Joueur
	int	partieN	 = 1;							 // compteur de parties, 1 = la première
	short  portServeur = atoi(argv[1]);				 // le port
	int	sockConx	= socketServeur(portServeur); // socket de connexion

	/* ================== ATTENTE DES CONNEXIONS ===========*/
	int nbrJoueur = 0;
	for (;;)
	{

		joueurs[nbrJoueur].socket = socketServeurAccept(sockConx);
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

	int err = waitForPartieReqs(&joueurs[0], &joueurs[1]);
	if (err < 0)
	{
		printf("Something went wrong\n");
		shutdown(joueurs[0].socket, SHUT_RDWR);
		close(joueurs[0].socket);

		shutdown(joueurs[1].socket, SHUT_RDWR);
		close(joueurs[1].socket);
		return -2;
	}

	/*=============================================================*/
	/*===================== REPONSES AUX JOUEURS ==================*/
	/*==============================================================*/

	fillPartieRep(&joueurs[0].partieRep, &joueurs[1].partieRep, &joueurs[0].partieReq, &joueurs[1].partieReq);


	int sen = send(joueurs[0].socket, &joueurs[0].partieRep, sizeof(TPartieRep), 0);
	sen		= send(joueurs[1].socket, &joueurs[1].partieRep, sizeof(TPartieRep), 0);


	int tour = fillStructJoueursAndDetermineWhoStarts(&joueurs[0], &joueurs[1]);

	// debug
	printf("Affichage des joueurs : \n");
	printf("Joueur arrivé en premier : %s numero %d score %d \n", joueurs[0].nomJoueur, joueurs[0].numeroJ, joueurs[0].score);
	printf("Joueur arrivé en second : %s numero %d score %d \n", joueurs[1].nomJoueur, joueurs[1].numeroJ, joueurs[1].score);


	/*=============================================================*/
	/*===================== BOUCLE DE JEU =========================*/
	/*=============================================================*/
	struct timeval timestart;
	timestart.tv_sec  = 0;
	timestart.tv_usec = 0;


	struct timeval timeend;
	timeend.tv_sec  = 0;
	timeend.tv_usec = 0;


	initialiserPartie();
	while (partieN < 3)
	{
		printf("Partie n° %d\n", partieN);
		int recvd;
		int req;

		bool	  validate = true;
		int		  sende;
		bool	  timeoutover = false;
		TPropCoup propCoup;
		/*init timeout to 6 seconds*/
		struct timeval tv;
		tv.tv_sec  = TIME_MAX;
		tv.tv_usec = 0;
		setsockopt(joueurs[tour].socket, SOL_SOCKET, SO_RCVTIMEO, (const char *)&tv, sizeof tv);

		gettimeofday(&timestart, NULL);
		do
		{
			recvd = recv(joueurs[tour].socket, &(joueurs[tour].coupReq), sizeof(TCoupReq), MSG_PEEK);
			if (recvd <= 0)
			{
				// nothing received ?
				printf("nothing received in the last 6 seconds\n");
				// informer du timeout
				timeoutover = true;
				break;
			}
		} while (recvd < sizeof(TCoupReq));
		gettimeofday(&timeend, NULL);

		recvd = recv(joueurs[tour].socket, &(joueurs[tour].coupReq), sizeof(TCoupReq), 0);

		if (timeend.tv_sec - timestart.tv_sec > TIME_MAX)
		{
			timeoutover = true;
		}

		/*if (recvd <= 0)
		{
			perror("serveur: erreur dans la reception");
			shutdown(joueurs[tour].socket, SHUT_RDWR);
			close(joueurs[tour].socket);
			return -2;
		}*/
		// else


		if (timeoutover)
		{
			joueurs[tour].coupRep.validCoup = TIMEOUT;
			joueurs[tour].coupRep.propCoup  = PERDU;
			joueurs[tour].coupRep.err		= ERR_COUP;
			validate						= false;
			joueurs[-1 * tour + 1].score++;
		}
		else if (joueurs[tour].coupReq.idRequest != COUP)
		{
			joueurs[tour].coupRep.validCoup = TRICHE;
			joueurs[tour].coupRep.propCoup  = PERDU;
			joueurs[tour].coupRep.err		= ERR_TYP;
			validate						= false;
			joueurs[-1 * tour + 1].score++;
		}
		else if (joueurs[tour].coupReq.numPartie != partieN)
		{
			joueurs[tour].coupRep.validCoup = TRICHE;
			joueurs[tour].coupRep.propCoup  = PERDU;
			joueurs[tour].coupRep.err		= ERR_PARTIE;
			validate						= false;
			joueurs[-1 * tour + 1].score++;
		}


		if (validate)
			validate = validationCoup(joueurs[tour].numeroJ, joueurs[tour].coupReq, &propCoup);

		if (validate)
		{
			// le coup est valide MAIS il faut vérifier la propriété du coup
			plateauMove(&plateau, joueurs[tour], &joueurs[tour].coupReq.coul, joueurs[tour].coupReq.deplPion.caseDep,
						joueurs[tour].coupReq.deplPion.caseArr);
			drawPlateau(&plateau);
			switch (propCoup)
			{
			case GAGNE:
				joueurs[tour].coupRep.validCoup = VALID;
				joueurs[tour].coupRep.propCoup  = GAGNE;
				joueurs[tour].coupRep.err		= ERR_OK;
				joueurs[tour].score++;

				// on envoie uniquement les rep aux deux joueurs
				break;
			case NUL:
				joueurs[tour].coupRep.validCoup = VALID;
				joueurs[tour].coupRep.propCoup  = NUL;
				joueurs[tour].coupRep.err		= ERR_OK;

				break;
			case PERDU:
				joueurs[tour].coupRep.validCoup = VALID;
				joueurs[tour].coupRep.propCoup  = PERDU;
				joueurs[tour].coupRep.err		= ERR_OK;

				joueurs[-1 * tour + 1].score++;
				break;
			case CONT: // on envoie les rep et la req à l'autre joueur

				joueurs[tour].coupRep.validCoup = VALID;
				joueurs[tour].coupRep.propCoup  = CONT;
				joueurs[tour].coupRep.err		= ERR_OK;
				break;
			}
		}
		else
		{
			joueurs[tour].coupRep.validCoup = TRICHE;
			joueurs[tour].coupRep.propCoup  = PERDU;
			joueurs[tour].coupRep.err		= ERR_COUP;
			joueurs[-1 * tour + 1].score++;
		}


		sende = send(joueurs[0].socket, &joueurs[tour].coupRep, sizeof(TCoupRep), 0);
		sende = send(joueurs[1].socket, &joueurs[tour].coupRep, sizeof(TCoupRep), 0);

		if (propCoup == CONT && validate && !timeoutover)
		{
			sende = send(joueurs[-1 * tour + 1].socket, &joueurs[tour].coupReq, sizeof(TCoupReq), 0);
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
		}

		printf("tour vaut : %d \n", tour);
		printf("joueur est : %s de numero %d \n", joueurs[tour].nomJoueur, joueurs[tour].numeroJ);
	}

	shutdown(joueurs[0].socket, SHUT_RDWR);
	close(joueurs[0].socket);

	shutdown(joueurs[1].socket, SHUT_RDWR);
	close(joueurs[1].socket);

	return 0;
}