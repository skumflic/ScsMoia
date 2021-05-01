#include "plateau.h"
#include "serv.h"
#define NBR_C 8
#define NBR_L 8

#define couleur(param) printf("\033[%sm", param)


const TCoulPion PlateauColors[8][8] = {
	{ORANGE, BLEU, POURPRE, FUCHIA, JAUNE, ROUGE, VERT, MARON}, {ROUGE, ORANGE, FUCHIA, VERT, BLEU, JAUNE, MARON, POURPRE},
	{VERT, FUCHIA, ORANGE, ROUGE, POURPRE, MARON, JAUNE, BLEU}, {FUCHIA, POURPRE, BLEU, ORANGE, MARON, VERT, ROUGE, JAUNE},
	{JAUNE, ROUGE, VERT, MARON, ORANGE, BLEU, POURPRE, FUCHIA}, {BLEU, JAUNE, MARON, POURPRE, ROUGE, ORANGE, FUCHIA, VERT},
	{POURPRE, MARON, JAUNE, BLEU, VERT, FUCHIA, ORANGE, ROUGE}, {MARON, VERT, ROUGE, JAUNE, FUCHIA, POURPRE, BLEU, ORANGE},
};


void initPlat(Plateau *plateau)
{
	for (size_t i = 0; i < NBR_L; i++)
	{
		for (size_t j = 0; j < NBR_C; j++)
		{
			// attribution des couleurs pour les cases
			plateau->cells[i][j].CellColor = PlateauColors[i][j];
			if (i == 0)
			{
				// creation des pions du joueur 1
				plateau->cells[i][j].pion.coulJ		 = BLANC;
				plateau->cells[i][j].pion.caractPion = plateau->cells[i][j].CellColor;
				plateau->cells[i][j].isEmpty		 = false;
			}
			else if (i == NBR_L - 1)
			{
				plateau->cells[i][j].pion.coulJ		 = NOIR;
				plateau->cells[i][j].pion.caractPion = plateau->cells[i][j].CellColor;
				plateau->cells[i][j].isEmpty		 = false;
			}
			else
			{
				plateau->cells[i][j].isEmpty = true;
			}
		}
	}
}

char *convertColor(TCoulPion c)
{
	switch (c)
	{
	case ORANGE: return C_ORANGE;
	case BLEU: return C_BLEU;
	case POURPRE: return C_POURPRE;
	case FUCHIA: return C_FUCHIA;
	case JAUNE: return C_JAUNE;
	case ROUGE: return C_ROUGE;
	case VERT: return C_VERT;
	case MARON: return C_MARON;
	default: return "";
	}
}

void drawPlateau(Plateau *plateau)
{
	printf("Plateau : \n  ");
	// disposition des lettres
	for (size_t i = 0; i < NBR_C; i++)
	{
		printf(" %c ", (char)('A' + i));
	}
	printf("\n");

	// dessin du haut du plateau
	printf(" ┌");
	for (size_t i = 0; i < NBR_C; i++)
	{
		printf("─┴─");
	}
	printf("┐\n");

	// dessin du milieu du plateau
	for (size_t i = 0; i < NBR_L; i++)
	{
		for (size_t j = 0; j < NBR_C; j++)
		{
			if (j == 0)
			{
				printf("%zu┨", i + 1);
			}

			// dessin des cases
			char *color		= convertColor(plateau->cells[i][j].CellColor);
			char *colorPion = convertColor(plateau->cells[i][j].pion.caractPion);

			if (plateau->cells[i][j].isEmpty)
			{
				// pas de pion sur la case
				printf("%s%s%s%s\033[0m", color, TEXTURE_CELL, TEXTURE_CELL, TEXTURE_CELL);
			}
			else
			{
				// on dessine le pion sur la case
				char colJ;
				if (plateau->cells[i][j].pion.coulJ == BLANC)
				{
					colJ = 'B';
					printf("%s%s\033[0m%s%c\033[0m%s%s\033[0m", color, TEXTURE_CELL, colorPion, colJ, color, TEXTURE_CELL);
				}
				else if (plateau->cells[i][j].pion.coulJ == NOIR)
				{
					colJ = 'N';
					printf("%s%s\033[0m%s%c\033[0m%s%s\033[0m", color, TEXTURE_CELL, colorPion, colJ, color, TEXTURE_CELL);
				}
			}
		}

		printf("┃\n");
	}

	// dessin du bas du plateau
	printf(" └");
	for (size_t i = 0; i < NBR_C; i++)
	{
		printf("───");
	}
	printf("┘\n");
}
void plateauMove(Plateau *plateau, Joueur j, TPion *pion, TCase caseDepart, TCase caseArrivee)
{

	plateau->cells[caseDepart.c][caseDepart.l].isEmpty   = true;
	plateau->cells[caseArrivee.c][caseArrivee.l].isEmpty = false;
	plateau->cells[caseArrivee.c][caseArrivee.l].pion	= *pion;
	/*plateau->cells[caseArrivee.c][caseArrivee.l].pion.coulJ		 = j.couleurJ;
	plateau->cells[caseArrivee.c][caseArrivee.l].pion.caractPion = pion.caractPion;*/
}
