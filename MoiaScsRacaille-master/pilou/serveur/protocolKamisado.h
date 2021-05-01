/*******************************************************
 *
 * Programme : protocolKamisado.h
 *
 * Synopsis : entete du protocole d'acces a l'arbitre
 *            pour le jeu Kamisado
 *
 * Ecrit par : VF, FB
 * Date :  15 / 01 / 18
 * 
 *******************************************************/

 #ifndef _protocolKamisado_h
 #define _protocolKamisado_h
 
 /* Taille des chaines de caracteres pour les noms */
 #define T_NOM 30
 
 /* Identificateurs des requetes */
 typedef enum { PARTIE, COUP } TIdReq;
 
 /* Types d'erreur */
 typedef enum { ERR_OK,      /* Validation de la requete */
            ERR_PARTIE,  /* Erreur sur la demande de partie */
            ERR_COUP,    /* Erreur sur le coup joue */
            ERR_TYP      /* Erreur sur le type de requete */
 } TCodeRep;
 
 /* 
  * Structures demande de partie
  */ 
 typedef enum { BLANC, NOIR } TCoulJoueur;
 
 typedef struct {
   TIdReq idReq;               /* Identificateur de la requete */
   char nomJoueur[T_NOM];      /* Nom du joueur */
   TCoulJoueur pion;           /* Couleur de pion souhaitee */
 } TPartieReq;
 
 typedef enum { OK, KO } TValidCoul;
 typedef struct {
   TCodeRep err;               /* Code d'erreur */
   char nomAdvers[T_NOM];      /* Nom du joueur adverse */
   TValidCoul validCoul;       /* Validation couleur */
 } TPartieRep;
 
 
 /* 
  * Definition d'une position de case
  */
 typedef enum { UN, DEUX, TROIS, QUATRE, CINQ, SIX, SEPT, HUIT } TLg;
 typedef enum { A, B, C, D, E, F, G, H } TCol;
 
 typedef struct {
   TCol c;          /* La colonne de la position d'une case */
   TLg l;           /* La ligne de la position d'une case */
 } TCase;
 
 /* 
  * Definition d'un deplacement de pion
  */
 typedef struct {
   TCase  caseDep;   /* Position de depart du pion */
   TCase  caseArr;   /* Position d'arrivee du pion */
 } TDeplPion;
 
 /* 
  * Structures coup du joueur 
  */
 
 /* Precision des types de coups */
 typedef enum { DEPL_PION, PASSE } TCoup;
 
 /* Informations sur le pion à jouer */
 typedef enum { ORANGE, BLEU, POURPRE, FUCHIA, JAUNE, ROUGE, VERT, MARON } TCoulPion;
 
 typedef struct {
   TCoulJoueur coulJ;      /* Couleur du joueur */
   TCoulPion caractPion;   /* Caracteristique du pion == couleur joué */
 } TPion;
 
 typedef struct {
   TIdReq     idRequest;     /* Identificateur de la requete */
   int        numPartie;     /* Numero de la partie (commencant a 1) */
   TCoup      typeCoup;      /* Type du coup : deplacement ou passe */
   TPion      coul;          /* Info du pion joue */
   TDeplPion  deplPion;      /* Deplacement de pion - valable uniquement 
                                pour un deplacement de pion */
 } TCoupReq;
 
 /* Validite du coup */
 typedef enum { VALID, TIMEOUT, TRICHE } TValCoup;
 
 /* Propriete des coups */
 typedef enum { CONT, GAGNE, NUL, PERDU } TPropCoup;
 
 /* Reponse a un coup */
 typedef struct {
   TCodeRep  err;            /* Code d'erreur */
   TValCoup  validCoup;      /* Validite du coup */
   TPropCoup propCoup;       /* Propriete du coup */
 } TCoupRep;
 
 #endif
 