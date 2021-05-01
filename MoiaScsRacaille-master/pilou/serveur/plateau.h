#ifndef H_PLATEAU
#define H_PLATEAU

#include "protocolKamisado.h"
#include "serv.h"
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

/*#ifdef ZSH
  #define C_ROUGE     "\e[31;1m"
  #define C_VERT   "\e[32;1m"
  #define C_JAUNE  "\e[33;1m"
  #define C_BLEU    "\e[34;1m"
  #define C_POURPRE "\e[35;1m"
  #define C_FUCHIA  "\e[38;2;255;153;255m"
  #define C_ORANGE  "\e[38;2;255;128;0m"
  #define C_MARON   "\e[38;2;153;76;0m"
#else
  #define C_ROUGE     "\e[48;5;196m"
  #define C_VERT   "\e[48;5;034m"
  #define C_JAUNE  "\e[48;5;184m"
  #define C_BLEU    "\e[48;5;020m"
  #define C_POURPRE "\e[48;5;091m"
  #define C_FUCHIA  "\e[48;5;168m"
  #define C_ORANGE  "\e[48;5;202m"
  #define C_MARON   "\e[48;5;094m"
#endif*/

#define C_ROUGE "\e[31;1m"
#define C_VERT "\e[32;1m"
#define C_JAUNE "\e[33;1m"
#define C_BLEU "\e[38;5;57m"
//#define C_POURPRE "\e[35;1m"
#define C_POURPRE "\e[38;5;135m"
#define C_FUCHIA "\e[38;5;199m"
#define C_ORANGE "\e[38;2;255;128;0m"
#define C_MARON "\e[38;2;153;76;0m"

#define RESET "\e[0m"

#define TEXTURE_CELL "█"

#define EMPTY -1
#define NBR_COL 8
#define NBR_ROW 8


typedef struct
{
	TCoulPion CellColor; // couleur de la case
	TPion	 pion;		 // pion sur la case;
	bool	  isEmpty;   // case vide ou non
} Cell;

typedef struct
{
	Cell cells[NBR_COL][NBR_ROW];
} Plateau;


void initPlat(Plateau *plateau);
char *convertColor(TCoulPion c);
void drawPlateau(Plateau *plateau);
void plateauMove(Plateau *plateau, Joueur j, TPion *pion, TCase caseDepart, TCase caseArrivee);

#endif
