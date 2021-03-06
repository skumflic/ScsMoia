:- use_module(library(lists)).
:- use_module(library(plunit)).
:- use_module(library(aggregate)).
:- use_module(library(between)).
:- use_module(library(random)).

plateau([o,b,p,f,j,r,v,m
	,r,o,f,v,b,j,m,p
	,v,f,o,r,p,m,j,b
	,f,p,b,o,m,v,r,j
	,j,r,v,m,o,b,p,f
	,b,j,m,p,r,o,f,v
	,p,m,j,b,v,f,o,r
	,m,v,r,j,f,p,b,o]).

translateCoordinatesFromList(Coord, Res, Couleur):-
	plateau(Plateau),
	nth1(Coord, Plateau, Couleur),
	getLigne(Coord, Ligne),
	getColonne(Coord, Colonne),
	Res = (Colonne, Ligne),
	write([Colonne, Ligne]).
	

getLigne(Coord, Res):-
	Res1 is div(Coord, 8),
	Res is Res1 + 1.

getColonne(Coord, Res):-
	Col = [a,b,c,d,e,f,g,h],
	ColonneNum is mod(Coord, 8),
	nth1(ColonneNum, Col, Res).

translateCoordinatesFromCouple([a, Ligne], Res, Couleur):-
	Res1 is 8*(Ligne - 1),
	Res is Res1 + 1.

translateCoordinatesFromCouple([b, Ligne], Res, Couleur):-
	Res1 is 8*(Ligne - 1),
	Res is Res1 + 2.

translateCoordinatesFromCouple([c, Ligne], Res, Couleur):-
	Res1 is 8*(Ligne - 1),
	Res is Res1 + 3.
	
	
get(X, Y):-
	X = 1,
	Y = 1.
	
	
	
	
append_to_list(List,Item) :-
    List = [Start|[To_add|Rest]],
    nonvar(Start),
    (var(To_add),To_add=Item;append_to_list([To_add|Rest],Item)).


	
deplacementBlancVertical(I, J, I1, J1) :- J1 is J + 1, J1 < 8, I1 = I.
deplacementBlancVertical(I, J, I1, J1) :- J1 is J + 2, J1 < 8, I1 = I.
deplacementBlancVertical(I, J, I1, J1) :- J1 is J + 3, J1 < 8, I1 = I.
deplacementBlancVertical(I, J, I1, J1) :- J1 is J + 4, J1 < 8, I1 = I.
deplacementBlancVertical(I, J, I1, J1) :- J1 is J + 5, J1 < 8, I1 = I.
deplacementBlancVertical(I, J, I1, J1) :- J1 is J + 6, J1 < 8, I1 = I.
deplacementBlancVertical(I, J, I1, J1) :- J1 is J + 7, J1 < 8, I1 = I.
	
deplacementBlancGauche(I, J, I1, J1) :- J1 is J + 1, J1 < 8, I1 is I - 1, I1 > -1.
deplacementBlancGauche(I, J, I1, J1) :- J1 is J + 2, J1 < 8, I1 is I - 2, I1 > -1.
deplacementBlancGauche(I, J, I1, J1) :- J1 is J + 3, J1 < 8, I1 is I - 3, I1 > -1.
deplacementBlancGauche(I, J, I1, J1) :- J1 is J + 4, J1 < 8, I1 is I - 4, I1 > -1.
deplacementBlancGauche(I, J, I1, J1) :- J1 is J + 5, J1 < 8, I1 is I - 5, I1 > -1.
deplacementBlancGauche(I, J, I1, J1) :- J1 is J + 6, J1 < 8, I1 is I - 6, I1 > -1.
deplacementBlancGauche(I, J, I1, J1) :- J1 is J + 7, J1 < 8, I1 is I - 7, I1 > -1.

deplacementBlancDroite(I, J, I1, J1) :- J1 is J + 1, J1 < 8, I1 is I + 1, I1 < 8.
deplacementBlancDroite(I, J, I1, J1) :- J1 is J + 2, J1 < 8, I1 is I + 2, I1 < 8.
deplacementBlancDroite(I, J, I1, J1) :- J1 is J + 3, J1 < 8, I1 is I + 3, I1 < 8.
deplacementBlancDroite(I, J, I1, J1) :- J1 is J + 4, J1 < 8, I1 is I + 4, I1 < 8.
deplacementBlancDroite(I, J, I1, J1) :- J1 is J + 5, J1 < 8, I1 is I + 5, I1 < 8.
deplacementBlancDroite(I, J, I1, J1) :- J1 is J + 6, J1 < 8, I1 is I + 6, I1 < 8.
deplacementBlancDroite(I, J, I1, J1) :- J1 is J + 7, J1 < 8, I1 is I + 7, I1 < 8.

	
	
deplacementNoirVertical(I, J, I1, J1) :- J1 is J - 1, J1 > -1, I1 = I.
deplacementNoirVertical(I, J, I1, J1) :- J1 is J - 2, J1 > -1, I1 = I.
deplacementNoirVertical(I, J, I1, J1) :- J1 is J - 3, J1 > -1, I1 = I.
deplacementNoirVertical(I, J, I1, J1) :- J1 is J - 4, J1 > -1, I1 = I.
deplacementNoirVertical(I, J, I1, J1) :- J1 is J - 5, J1 > -1, I1 = I.
deplacementNoirVertical(I, J, I1, J1) :- J1 is J - 6, J1 > -1, I1 = I.
deplacementNoirVertical(I, J, I1, J1) :- J1 is J - 7, J1 > -1, I1 = I.

deplacementNoirGauche(I, J, I1, J1) :- J1 is J - 1, J1 > -1, I1 is I - 1, I1 > -1.
deplacementNoirGauche(I, J, I1, J1) :- J1 is J - 2, J1 > -1, I1 is I - 2, I1 > -1.
deplacementNoirGauche(I, J, I1, J1) :- J1 is J - 3, J1 > -1, I1 is I - 3, I1 > -1.
deplacementNoirGauche(I, J, I1, J1) :- J1 is J - 4, J1 > -1, I1 is I - 4, I1 > -1.
deplacementNoirGauche(I, J, I1, J1) :- J1 is J - 5, J1 > -1, I1 is I - 5, I1 > -1.
deplacementNoirGauche(I, J, I1, J1) :- J1 is J - 6, J1 > -1, I1 is I - 6, I1 > -1.
deplacementNoirGauche(I, J, I1, J1) :- J1 is J - 7, J1 > -1, I1 is I - 7, I1 > -1.

deplacementNoirDroite(I, J, I1, J1) :- J1 is J - 1, J1 > -1, I1 is I + 1, I1 < 8.
deplacementNoirDroite(I, J, I1, J1) :- J1 is J - 2, J1 > -1, I1 is I + 2, I1 < 8.
deplacementNoirDroite(I, J, I1, J1) :- J1 is J - 3, J1 > -1, I1 is I + 3, I1 < 8.
deplacementNoirDroite(I, J, I1, J1) :- J1 is J - 4, J1 > -1, I1 is I + 4, I1 < 8.
deplacementNoirDroite(I, J, I1, J1) :- J1 is J - 5, J1 > -1, I1 is I + 5, I1 < 8.
deplacementNoirDroite(I, J, I1, J1) :- J1 is J - 6, J1 > -1, I1 is I + 6, I1 < 8.
deplacementNoirDroite(I, J, I1, J1) :- J1 is J - 7, J1 > -1, I1 is I + 7, I1 < 8.



yaQuoiCommeCouleur([X|L], I, V, Res, Inc) :-
	Tmp is V * 8 + I,
	Inc = Tmp,
	Res = X.
	
yaQuoiCommeCouleur([X|L], I, V, Res, Inc) :-
	Inc1 is Inc + 1,
	yaQuoiCommeCouleur(L, I, V, Res, Inc1).


yaQuoiDansCetteCase([X|L], I, V, Res, Inc) :-
	Tmp is V * 8 + I,
	Inc = Tmp,
	Res = X.
	
yaQuoiDansCetteCase([X|L], I, V, Res, Inc) :-
	Inc1 is Inc + 1,
	yaQuoiDansCetteCase(L, I, V, Res, Inc1).
	
	
yaQuoiDansCesCases(L, I, [], Bag2).

yaQuoiDansCesCases(L, I, [X|Tail], Bag2) :-
	yaQuoiDansCetteCase(L, I, X, Res, 0),
	Res = vide,
	yaQuoiDansCesCases(L, I, Tail, Bag3). 
	
	
		
	
yaQuoiDansCesCasesDiagonal(L, I, [], []).

yaQuoiDansCesCasesDiagonal(L, [X1|Tail1], [X|Tail], Bag2) :-
	yaQuoiDansCetteCase(L, X1, X, Res, 0),
	Res = vide,
	yaQuoiDansCesCasesDiagonal(L, Tail1, Tail, Bag3). 
		
		
	
% POUR LES BLANCS TOUT DROIT	


pasDobstacleVerticalBlanc(I, J, I1, J1, L) :-
	JUN is J + 1,
	findall(X, between(JUN, J1, X), Bag),
	yaQuoiDansCesCases(L, I, Bag, Bag2).
		
		
		

% POUR LES BLANCS EN DIAGONAL  


		 
pasDobstacleGaucheBlanc(I, J, I1, J1, L) :-
	JUN is J + 1,
	IUN is I - 1,
	findall(Y, between(I1, IUN, Y), Bag),
	findall(X, between(JUN, J1, X), Bag2),
	reverse(Bag, BagR),
	yaQuoiDansCesCasesDiagonal(L, BagR, Bag2, Bag3).
	
	
pasDobstacleDroiteBlanc(I, J, I1, J1, L) :-
	JUN is J + 1,
	IUN is I + 1,
	findall(Y, between(IUN, I1, Y), Bag),
	findall(X, between(JUN, J1, X), Bag2),
	yaQuoiDansCesCasesDiagonal(L, Bag, Bag2, Bag3).
	
	
	
possibleDeplaceBlancVertical(I, J, L, I1, J1) :-
	deplacementBlancVertical(I, J, I1, J1),
	pasDobstacleVerticalBlanc(I, J, I1, J1, L).


possibleDeplaceBlancGauche(I, J, L, I1, J1) :-
	deplacementBlancGauche(I, J, I1, J1),
	pasDobstacleGaucheBlanc(I, J, I1, J1, L).

possibleDeplaceBlancDroite(I, J, L, I1, J1) :-
	deplacementBlancDroite(I, J, I1, J1),
	pasDobstacleDroiteBlanc(I, J, I1, J1, L).

	
	
	
	
deplacementGagnantBlanc(I1, J1, []) :- fail.
	
deplacementGagnantBlanc(I1, J1, [[X, Y]|L]) :-
	Y = 7,
	I1 = X,
	J1 = Y.

deplacementGagnantBlanc(I1, J1, [[X, Y]|L]) :-
	deplacementGagnantBlanc(I1, J1, L).
	
	
	
	
recupererXetYNoir(Res, XNoir, YNoir, [XPion|LPion], [XCouleur|LCouleur], Inc) :-
	Res = XCouleur,
	XPion = noir, 
	XNoir is mod(Inc, 8),
	YNoir is div(Inc, 8).
	
recupererXetYNoir(Res, XNoir, YNoir, [XPion|LPion], [XCouleur|LCouleur], Inc) :-
	Inc1 is Inc + 1,
	recupererXetYNoir(Res, XNoir, YNoir, LPion, LCouleur, Inc1).
	



recupererCouleur(I, J, [], Couleur, Inc).
	
recupererCouleur(I, J, [X|LCouleur], Couleur, Inc) :-
	Tmp is J * 8 + I,
	Inc = Tmp,
	Couleur = X.
	
recupererCouleur(I, J,  [X|LCouleur], Couleur, Inc) :-
	Inc1 is Inc + 1,
	recupererCouleur(I, J, LCouleur, Couleur, Inc1).
	
	
	
	
mettreVideCouleur(I, J, [], Inc, []).
	
mettreVideCouleur(I, J, [X|LCouleur], Inc, [OC|LCouleurRes]) :-
	Tmp is J * 8 + I,
	Inc = Tmp,
	OC = vide,
	Inc1 is Inc + 1,
	mettreVideCouleur(I, J, LCouleur, Inc1, LCouleurRes).
	
mettreVideCouleur(I, J, [X|LCouleur], Inc, [OC|LCouleurRes]) :-
	Inc1 is Inc + 1,
	OC = X,
	mettreVideCouleur(I, J, LCouleur, Inc1, LCouleurRes).
	
		
	
	
	
mettreCouleur(X, Y, Couleur, [], Inc, []).
	
mettreCouleur(X, Y, Couleur, [O|LCouleur], Inc, [OC|LCouleurRes]) :-
	Tmp is Y * 8 + X,
	Inc = Tmp,
	OC = Couleur,
	Inc1 is Inc + 1,
	mettreCouleur(X, Y, Couleur, LCouleur, Inc1, LCouleurRes).
	
mettreCouleur(X, Y, Couleur, [O|LCouleur], Inc, [OC|LCouleurRes]) :-
	Inc1 is Inc + 1,
	OC = O,
	mettreCouleur(X, Y, Couleur, LCouleur, Inc1, LCouleurRes).
	
		
changementCouleur(I, J, LCouleur, X, Y, LCouleurRes2) :-
	recupererCouleur(I, J, LCouleur, Couleur, 0),
	mettreVideCouleur(I, J, LCouleur, 0, LCouleurRes),
	mettreCouleur(X, Y, Couleur, LCouleurRes, 0, LCouleurRes2).
	
			
	
mettreVidePion(I, J, [], Inc, []).
	
mettreVidePion(I, J, [O|LPion], Inc, [OPRes|LPionRes]) :-
	Tmp is J * 8 + I,
	Inc = Tmp,
	OPRes = vide,
	Inc1 is Inc + 1,
	mettreVidePion(I, J, LPion, Inc1, LPionRes).
	
mettreVidePion(I, J, [O|LPion], Inc, [OPRes|LPionRes]) :-
	Inc1 is Inc + 1,
	OPRes = O,
	mettreVidePion(I, J, LPion, Inc1, LPionRes).
	
	
	
		
mettrePion(X, Y, Joueur, [], Inc, []).
	
mettrePion(X, Y, Joueur, [O|LPion], Inc, [OPRes|LPionRes]) :-
	Tmp is Y * 8 + X,
	Inc = Tmp,
	OPRes = Joueur,
	Inc1 is Inc + 1,
	mettrePion(X, Y, Joueur, LPion, Inc1, LPionRes).
	
mettrePion(X, Y, Joueur, [O|LPion], Inc, [OPRes|LPionRes]) :-
	Inc1 is Inc + 1,
	OPRes = O,
	mettrePion(X, Y, Joueur, LPion, Inc1, LPionRes).
	
		
			
changementPion(I, J, LPion, Joueur, X, Y, LPionRes2) :-
	mettreVidePion(I, J, LPion, 0, LPionRes),
	mettrePion(X, Y, Joueur, LPionRes, 0, LPionRes2).
	
	
	
	
	
changementPlateau(I, J, LPion, LCouleur, X, Y, Joueur, LPionRes2, LCoulRes) :-
	changementCouleur(I, J, LCouleur, X, Y, LCoulRes),
	changementPion(I, J, LPion, Joueur, X, Y, LPionRes2).
	
	
	
noirVaGagner([], V) :- V = 1.
	
noirVaGagner([[X, 0]|L], V) :-
	%print('NOIR VA GAGNER'),nl, 
	!, V = 0.
	
noirVaGagner([[X, Y]|L], V) :-
	noirVaGagner(L, V).
	
	
		
deplacementQuiMetPasDansLaMouiseBlanc(I, J, IC, JC, X, Y, LPion, LCouleur, Joueur) :-
	plateau(CouleursSurPlateau),
	yaQuoiCommeCouleur(CouleursSurPlateau, X, Y, Res, 0),
	recupererXetYNoir(Res, XNoir, YNoir, LPion, LCouleur, 0),
	
	changementPlateau(I, J, LPion, LCouleur, X, Y, Joueur, LPionRes, LCoulRes), 
	

	
	findall([I1, J1], possibleDeplaceNoirVertical(XNoir, YNoir, LPionRes, I1, J1), L1),
	findall([I1, J1], possibleDeplaceNoirGauche(XNoir, YNoir, LPionRes, I1, J1), L2),
	findall([I1, J1], possibleDeplaceNoirDroite(XNoir, YNoir, LPionRes, I1, J1), L3),

	append(L1, L2, M1),
	append(L3, M1, M2),

	noirVaGagner(M2, V), !,
	V = 1, 
	IC = X,
	JC = Y, !.
	
	

deplacementBlanc(I, J, [], [], [], LPion, LCouleur, Joueur).
	
deplacementBlanc(I, J, IC, JC, [[X, Y]|L], LPion, LCouleur, Joueur) :-
	

	deplacementQuiMetPasDansLaMouiseBlanc(I, J, IC, JC, X, Y, LPion, LCouleur, Joueur).


%	print('['),
%	print(IC),
%	print(' '),
%	print(JC),
%	print(']'),nl.
	%deplacement(I, J, ICC, JCC, L, LPion, LCouleur, Joueur).

	
deplacementBlanc(I, J, IC, JC, [[X, Y]|L], LPion, LCouleur, Joueur) :-
	%print('back there'),
	deplacementBlanc(I, J, IC, JC, L, LPion, LCouleur, Joueur).	
	
	
	

	



	
choisirUnMouvementBlanc(I, J, LPion, LCouleur, IC, JC) :-
	findall([I1, J1], possibleDeplaceBlancVertical(I, J, LPion, I1, J1), L1),
	findall([I1, J1], possibleDeplaceBlancGauche(I, J, LPion, I1, J1), L2),
	findall([I1, J1], possibleDeplaceBlancDroite(I, J, LPion, I1, J1), L3),

	append([L1, L2, L3], M2),
	%append(L3, M1, M2),
	%print(M2),
	
	deplacementGagnantBlanc(IC, JC, M2).	
	
	
choisirUnMouvementBlanc(I, J, LPion, LCouleur, IC, JC) :-
	findall([I1, J1], possibleDeplaceBlancVertical(I, J, LPion, I1, J1), L1),
	findall([I1, J1], possibleDeplaceBlancGauche(I, J, LPion, I1, J1), L2),
	findall([I1, J1], possibleDeplaceBlancDroite(I, J, LPion, I1, J1), L3),
	
	append(L1, L2, M1),
	append(L3, M1, M2),
	
	%deplacement(I, J, IC, JC, M2, LPion, LCouleur, blanc),
	findall([ICC, JCC], deplacementBlanc(I, J, ICC, JCC, M2, LPion, LCouleur, blanc), L4),
	
	
	%print(L4),print('\n'),
	enleverVariablePolluante(L4, L5),
	%print(L5).
	
	length(L5, Length),
	random(0, Length, Random),
	%print(Random),
	
	choisirRandom(IC, JC, L5, Random, 0).
	%print('CHOISI \n'), 
	%print('['), print(IC), print(' '), print(JC), print(']').
	
	
choisirUnMouvementBlanc(I, J, LPion, LCouleur, IC, JC) :- 
	findall([I1, J1], possibleDeplaceBlancVertical(I, J, LPion, I1, J1), L1),
	findall([I1, J1], possibleDeplaceBlancGauche(I, J, LPion, I1, J1), L2),
	findall([I1, J1], possibleDeplaceBlancDroite(I, J, LPion, I1, J1), L3),
	
	append(L1, L2, M1),
	append(L3, M1, M2),
	
	length(M2, Length),
	random(0, Length, Random),

	choisirRandom(IC, JC, M2, Random, 0).


choisirUnMouvementBlanc(I, J, LPion, LCouleur, IC, JC) :- 
	findall([I1, J1], possibleDeplaceBlancVertical(I, J, LPion, I1, J1), L1),
	findall([I1, J1], possibleDeplaceBlancGauche(I, J, LPion, I1, J1), L2),
	findall([I1, J1], possibleDeplaceBlancDroite(I, J, LPion, I1, J1), L3),
	
	append(L1, L2, M1),
	append(L3, M1, M2),
	
	length(M2, Length),
	Length = 0,

	IC = 9,
	JC = 9.
	
	
enleverVariablePolluante([[X, Y]|[]], []).
	
enleverVariablePolluante([[X, Y]|L], [[O, P]|M]) :-
	O = X,
	P = Y, 
	enleverVariablePolluante(L, M).
	



choisirRandom(IC, JC, [], Random, Inc) :-
	IC = X,
	JC = Y.
	
choisirRandom(IC, JC, [[X, Y]|L], Random, Inc) :-
	Random = Inc,
	IC = X,
	JC = Y.
	
choisirRandom(IC, JC, [[X, Y]|L], Random, Inc) :-
	Inc1 is Inc + 1,
	choisirRandom(IC, JC, L, Random, Inc1).
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
% POUR LES NOIRS TOUT DROIT	


pasDobstacleVerticalNoir(I, J, I1, J1, L) :-
	JUN is J - 1,
	findall(X, between(J1, JUN, X), Bag),
	%print(Bag),
	yaQuoiDansCesCases(L, I, Bag, Bag2).	
	
	
% POUR LES NOIRS EN DIAGONAL  


		 
pasDobstacleGaucheNoir(I, J, I1, J1, L) :-
	JUN is J - 1,
	IUN is I - 1,
	findall(Y, between(I1, IUN, Y), Bag),
	findall(X, between(J1, JUN, X), Bag2),
	%print(Bag),
	%print(Bag2),
	yaQuoiDansCesCasesDiagonal(L, Bag, Bag2, Bag3).
	
	
pasDobstacleDroiteNoir(I, J, I1, J1, L) :-
	JUN is J - 1,
	IUN is I + 1,
	findall(Y, between(IUN, I1, Y), Bag),
	findall(X, between(J1, JUN, X), Bag2),
	reverse(Bag2, BagR),
	%print(Bag),
	%print(Bag2),
	yaQuoiDansCesCasesDiagonal(L, Bag, BagR, Bag3).
	
	
	
	
possibleDeplaceNoirVertical(I, J, L, I1, J1) :-
	deplacementNoirVertical(I, J, I1, J1),
	pasDobstacleVerticalNoir(I, J, I1, J1, L).


possibleDeplaceNoirGauche(I, J, L, I1, J1) :-
	deplacementNoirGauche(I, J, I1, J1),
	pasDobstacleGaucheNoir(I, J, I1, J1, L).
	

possibleDeplaceNoirDroite(I, J, L, I1, J1) :-
	deplacementNoirDroite(I, J, I1, J1),
	pasDobstacleDroiteNoir(I, J, I1, J1, L).
	
	
	
	
deplacementGagnantNoir(I1, J1, []) :- fail.
	
deplacementGagnantNoir(I1, J1, [[X, Y]|L]) :-
	Y = 0,
	I1 = X,
	J1 = Y.

deplacementGagnantNoir(I1, J1, [[X, Y]|L]) :-
	deplacementGagnantNoir(I1, J1, L).


recupererXetYBlanc(Res, XBlanc, YBlanc, [XPion|LPion], [XCouleur|LCouleur], Inc) :-
	Res = XCouleur,
	XPion = blanc, 
	XBlanc is mod(Inc, 8),
	YBlanc is div(Inc, 8).
	
recupererXetYBlanc(Res, XBlanc, YBlanc, [XPion|LPion], [XCouleur|LCouleur], Inc) :-
	Inc1 is Inc + 1,
	recupererXetYBlanc(Res, XBlanc, YBlanc, LPion, LCouleur, Inc1).
	

	
	
	
blancVaGagner([], V) :- V = 1.
	
blancVaGagner([[X, 7]|L], V) :-
	%print('NOIR VA GAGNER'),nl, 
	!, V = 0.
	
blancVaGagner([[X, Y]|L], V) :-
	blancVaGagner(L, V).
	
	
		
deplacementQuiMetPasDansLaMouiseNoir(I, J, IC, JC, X, Y, LPion, LCouleur, Joueur) :-
	plateau(CouleursSurPlateau),
	yaQuoiCommeCouleur(CouleursSurPlateau, X, Y, Res, 0),
	
	recupererXetYBlanc(Res, XBlanc, YBlanc, LPion, LCouleur, 0),

	changementPlateau(I, J, LPion, LCouleur, X, Y, Joueur, LPionRes, LCoulRes), 
	

	
	findall([I1, J1], possibleDeplaceBlancVertical(XBlanc, YBlanc, LPionRes, I1, J1), L1),
	findall([I1, J1], possibleDeplaceBlancGauche(XBlanc, YBlanc, LPionRes, I1, J1), L2),
	findall([I1, J1], possibleDeplaceBlancDroite(XBlanc, YBlanc, LPionRes, I1, J1), L3),

	append(L1, L2, M1),
	append(L3, M1, M2),

	blancVaGagner(M2, V), !,
	V = 1, 
	IC = X,
	JC = Y, !.
		
	
deplacementNoir(I, J, [], [], [], LPion, LCouleur, Joueur).
	
deplacementNoir(I, J, IC, JC, [[X, Y]|L], LPion, LCouleur, Joueur) :-
	
	deplacementQuiMetPasDansLaMouiseNoir(I, J, IC, JC, X, Y, LPion, LCouleur, Joueur).

	
deplacementNoir(I, J, IC, JC, [[X, Y]|L], LPion, LCouleur, Joueur) :-
	%print('back there'),
	deplacementNoir(I, J, IC, JC, L, LPion, LCouleur, Joueur).	
	
	
	
	
	
	
choisirUnMouvementNoir(I, J, LPion, LCouleur, IC, JC) :-
	findall([I1, J1], possibleDeplaceNoirVertical(I, J, LPion, I1, J1), L1),
	findall([I1, J1], possibleDeplaceNoirGauche(I, J, LPion, I1, J1), L2),
	findall([I1, J1], possibleDeplaceNoirDroite(I, J, LPion, I1, J1), L3),

	append([L1, L2, L3], M2),
	%append(L3, M1, M2),
	%print(M2),
	
	deplacementGagnantNoir(IC, JC, M2).	
	
	
choisirUnMouvementNoir(I, J, LPion, LCouleur, IC, JC) :-
	findall([I1, J1], possibleDeplaceNoirVertical(I, J, LPion, I1, J1), L1),
	findall([I1, J1], possibleDeplaceNoirGauche(I, J, LPion, I1, J1), L2),
	findall([I1, J1], possibleDeplaceNoirDroite(I, J, LPion, I1, J1), L3),
	
	append(L1, L2, M1),
	append(L3, M1, M2),
	
	%deplacement(I, J, IC, JC, M2, LPion, LCouleur, blanc),
	findall([ICC, JCC], deplacementNoir(I, J, ICC, JCC, M2, LPion, LCouleur, noir), L4),	
	
	%print(L4),print('\n'),
	enleverVariablePolluante(L4, L5),
	%print(L5).
	
	length(L5, Length),
	random(0, Length, Random),
	%print(Random),
	
	choisirRandom(IC, JC, L5, Random, 0).
	%print('CHOISI \n'), 
	%print('['), print(IC), print(' '), print(JC), print(']'
	
	
	
	
	
choisirUnMouvementNoir(I, J, LPion, LCouleur, IC, JC) :-
	findall([I1, J1], possibleDeplaceNoirVertical(I, J, LPion, I1, J1), L1),
	findall([I1, J1], possibleDeplaceNoirGauche(I, J, LPion, I1, J1), L2),
	findall([I1, J1], possibleDeplaceNoirDroite(I, J, LPion, I1, J1), L3),
	
	append(L1, L2, M1),
	append(L3, M1, M2),
	
	length(M2, Length),
	random(0, Length, Random),
	%print(Random),
	
	choisirRandom(IC, JC, M2, Random, 0).
	
	
	
choisirUnMouvementNoir(I, J, LPion, LCouleur, IC, JC) :-
	findall([I1, J1], possibleDeplaceNoirVertical(I, J, LPion, I1, J1), L1),
	findall([I1, J1], possibleDeplaceNoirGauche(I, J, LPion, I1, J1), L2),
	findall([I1, J1], possibleDeplaceNoirDroite(I, J, LPion, I1, J1), L3),
	
	append(L1, L2, M1),
	append(L3, M1, M2),
	
	length(M2, Length),
	Length = 0,
	
	IC = 9,
	JC = 9.	
	
	
	
	
%TEST 
	
:-begin_tests(vinDieu).
	test('yaQuoiDansCetteCase', [true(Res==vide)]) :-
		yaQuoiDansCetteCase([blanc, blanc, blanc, blanc, blanc, blanc, blanc, blanc, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, noir, noir, noir, noir, noir, noir, noir, noir], 0, 3, Res, 0).
	
	test('yaQuoiCommeCouleur', [true(Res==r)]) :-
		yaQuoiCommeCouleur([o, b, p, f, j, r, v, m, r, o, f, v, b, j, m,  p, v, f, o, r, p, m, j, b, f, p, b, o, m, v, r, j, j, r, v, m, o, b, p, f, b, j, m, p, r, o, f, v, p, m, j, b, v, f, o, r, m, v, r, j, f, p, b, o], 0, 1, Res, 0).
	
	test('pasDobstacleVerticalBlanc', [fail]) :- 
		pasDobstacleVerticalBlanc(0, 0, 0, 3, [blanc, blanc, blanc, blanc, blanc, blanc, blanc, blanc, noir, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, noir, noir, noir, noir, noir, noir, noir]).
	
	test('pasDobstacleVerticalBlanc2', [true]) :- 
		pasDobstacleVerticalBlanc(0, 0, 0, 3, [blanc, blanc, blanc, blanc, blanc, blanc, blanc, blanc, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, noir, noir, noir, noir, noir, noir, noir, noir]).	

	test('pasDobstacleGaucheBlanc', [fail]) :- 
		pasDobstacleGaucheBlanc(6, 0, 0, 6, [blanc, blanc, blanc, blanc, blanc, blanc, blanc, blanc, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, noir, vide, vide, vide, vide, vide, vide, vide, vide, noir, noir, noir, noir, noir, noir, noir]).	

	test('pasDobstacleGaucheBlanc', [true]) :- 
		pasDobstacleGaucheBlanc(1, 0, 0, 1, [blanc, blanc, blanc, blanc, blanc, blanc, blanc, blanc, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, noir, noir, noir, noir, noir, noir, noir, noir]).
	
	
	test('pasDobstacleDroiteBlanc', [fail]) :- 
		pasDobstacleDroiteBlanc(0, 0, 7, 7, [blanc, blanc, blanc, blanc, blanc, blanc, blanc, blanc, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, noir, noir, noir, noir, noir, noir, noir, noir]).	
	

	test('pasDobstacleDroiteBlanc', [true]) :- 
		pasDobstacleDroiteBlanc(0, 0, 6, 6, [blanc, blanc, blanc, blanc, blanc, blanc, blanc, blanc, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, noir, noir, noir, noir, noir, noir, noir, noir]).	








	test('pasDobstacleVerticalNoir', [fail]) :- 
		pasDobstacleVerticalNoir(3, 7, 3, 4, [blanc, blanc, blanc, blanc, blanc, blanc, blanc, blanc, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, noir, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, noir, noir, noir, vide, noir, noir, noir, noir]).
		
	test('pasDobstacleVerticalNoir2', [true]) :- 
		pasDobstacleVerticalNoir(3, 7, 3, 4, [blanc, blanc, blanc, blanc, blanc, blanc, blanc, blanc, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, noir, noir, noir, noir, noir, noir, noir, noir]).
		
		
		
	test('pasDobstacleGaucheNoir', [true]) :- 
		pasDobstacleGaucheNoir(3, 7, 0, 4, [blanc, blanc, blanc, blanc, blanc, blanc, blanc, blanc, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, noir, noir, noir, noir, noir, noir, noir, noir]).	
		
	test('pasDobstacleGaucheNoir2', [fail]) :- 
		pasDobstacleGaucheNoir(3, 7, 0, 4, [blanc, blanc, vide, blanc, blanc, blanc, blanc, blanc, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, blanc, vide, vide, vide, vide, vide, noir, noir, noir, noir, noir, noir, noir, noir]).	
	
	
	
	test('pasDobstacleDroiteNoir', [fail]) :- 
		pasDobstacleDroiteNoir(3, 7, 7, 4, [blanc, blanc, blanc, vide, blanc, blanc, blanc, blanc, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, blanc, vide, vide, vide, noir, noir, noir, noir, noir, noir, noir, noir]).
		
	test('pasDobstacleDroiteNoir2', [true]) :- 
		pasDobstacleDroiteNoir(3, 7, 7, 4, [blanc, blanc, blanc, blanc, blanc, blanc, blanc, blanc, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, noir, noir, noir, noir, noir, noir, noir, noir]).	
	
	
	
	
	
	
	test('deplacementGagnantBlanc', [true(I1==7), true(J1==7)]) :- 
		deplacementGagnantBlanc(I1, J1, [[3, 3], [4, 4], [5, 5], [6, 6], [7, 7]]).	
	test('deplacementGagnantBlanc2', [fail]) :- 
		deplacementGagnantBlanc(I1, J1, [[3, 3], [4, 4], [5, 5], [6, 6]]).	
	
	
	
	
	
	test('choisirUnMouvementBlanc', [true(IC==7), true(JC==7)]) :-
		choisirUnMouvementBlanc(0, 0, [blanc, blanc, blanc, blanc, blanc, blanc, blanc, blanc, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, noir, noir, noir, noir, noir, noir, noir, noir, vide], [o, b, p, f, j, r, v, m, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, m, v, r, j, f, p, b, o], IC, JC).

	test('recupererXetYNOIR', [true(XNoir==7), true(YNoir==7)]) :-
		recupererXetYNoir(o, XNoir, YNoir, [blanc, blanc, blanc, blanc, blanc, blanc, blanc, blanc, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, noir, noir, noir, noir, noir, noir, noir, noir], [o, b, p, f, j, r, v, m, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, m, v, r, j, f, p, b, o], 0).	
		
	test('recupererXetYNOIR2', [true(XNoir==6), true(YNoir==7)]) :-
		recupererXetYNoir(b, XNoir, YNoir, [blanc, blanc, blanc, blanc, blanc, blanc, blanc, blanc, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, noir, noir, noir, noir, noir, noir, noir, noir], [o, b, p, f, j, r, v, m, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, m, v, r, j, f, p, b, o], 0).	
	
	

		
		
		
	test('changementPion', [true(LPionRes2==[vide, blanc, blanc, blanc, blanc, blanc, blanc, blanc, vide, blanc, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, noir, noir, noir, noir, noir, noir, noir, noir, vide])]) :-
		changementPion(0, 0, [blanc, blanc, blanc, blanc, blanc, blanc, blanc, blanc, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, noir, noir, noir, noir, noir, noir, noir, noir, vide], blanc, 1, 1, LPionRes2).
		
		
	test('changementCouleur', [true(LCouleurRes2==[o, b, p, f, j, r, v, m, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, o, vide, m, v, r, j, f, p, b, vide])]) :-
		changementCouleur(7, 7, [o, b, p, f, j, r, v, m, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, m, v, r, j, f, p, b, o], 6, 6, LCouleurRes2).
	
	
	
	test('changementPlateau', [true(LPionRes=[vide, blanc, blanc, blanc, blanc, blanc, blanc, blanc, vide, blanc, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, noir, noir, noir, noir, noir, noir, noir, noir, vide]), true(LCoulRes=[vide, b, p, f, j, r, v, m, vide, o, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, m, v, r, j, f, p, b, o])]) :-
		changementPlateau(0, 0, [blanc, blanc, blanc, blanc, blanc, blanc, blanc, blanc, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, noir, noir, noir, noir, noir, noir, noir, noir], [o, b, p, f, j, r, v, m, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, m, v, r, j, f, p, b, o], 1, 1, blanc, LPionRes, LCoulRes).
	
	
	test('changementPlateau2', [true(LPionRes=[vide, blanc, blanc, blanc, blanc, blanc, blanc, blanc, blanc, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, blanc, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, noir, noir, noir, noir, noir, noir, noir, noir]), true(LCoulRes=[vide, b, p, f, j, r, v, m, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, o, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, m, v, r, j, f, p, b, o])]) :-
		changementPlateau(0, 1, [vide, blanc, blanc, blanc, blanc, blanc, blanc, blanc, blanc, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, noir, noir, noir, noir, noir, noir, noir, noir], [vide, b, p, f, j, r, v, m, o, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, m, v, r, j, f, p, b, o], 3, 4, blanc, LPionRes, LCoulRes).
	
	
	
	
	
		
		
:-end_tests(vinDieu).



%choisirUnMouvementBlanc(0, 1, [vide, blanc, blanc, blanc, blanc, blanc, blanc, blanc, blanc, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, noir, noir, noir, noir, noir, noir, noir, noir], [vide, b, p, f, j, r, v, m, o, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, m, v, r, j, f, p, b, o], IC, JC).
	

%choisirUnMouvementNoir(7, 6, [blanc, blanc, blanc, blanc, blanc, blanc, blanc, vide, vide, vide, vide, vide, vide, vide, vide, blanc, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, noir, noir, noir, noir, noir, noir, noir, noir, vide], [o, b, p, f, j, r, v, vide, vide, vide, vide, vide, vide, vide, vide, m, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, vide, o, m, v, r, j, f, p, b, vide], IC, JC).







