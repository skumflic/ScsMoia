#include "plateau.h"
#include "protocolKamisado.h"

#ifndef H_SERV
#define H_SERV

#define TIME_MAX 6


typedef struct
{
	int			socket;
	char		nomJoueur[30];
	int			numeroJ; // 1 si commence, deux sinon
	TCoulJoueur couleurJ;
	int			score;
	TCoupRep	coupRep;
	TCoupReq	coupReq;
	TPartieReq  partieReq;
	TPartieRep  partieRep;
} Joueur;

void printDebugPartieReq(TPartieReq tabPartieReq[2], int nbrPartieReq);


/**
 * Fill answers to be returned to each player, to tell them theirs colors and name of the opposant player
 * */
void fillPartieRep(TPartieRep *reponseJ1, TPartieRep *reponseJ2, TPartieReq *reqJ1, TPartieReq *reqJ2);

/**
 *
 * fill Struct Joueur for each player. This allows us to know who is the player who starts (depending on his color)
 * -------------------------------------------------
 * @param joueurs is an array of two Struct Joueur
 * @param tabPartieReq is an array of two 'PARTIE' requests received from each players. (It may has been modified by fillPartieRep(...) method, if
 *they both wanted the same color)
 *--------------------------------------------------
 * @returns tour : (int) needed for the 'loop game', tour is the index to access the good player alternately within 'Joueur' structures or different
 * requests
 * */
int fillStructJoueursAndDetermineWhoStarts(Joueur *joueur1, Joueur *joueur2);


int waitForPartieReqs(Joueur *joueur1, Joueur *joueur2);
#endif