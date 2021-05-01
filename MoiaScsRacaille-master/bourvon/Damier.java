public class Damier {
	
	private Case[][] monDamier;
	
	private Pion[] pionBlanc;
	private Pion[] pionNoir;
	
	
	public Damier() {
		monDamier = new Case[8][8];
		for (int i = 0; i < 8; i++) {
			for (int j = 0; j < 8; j++) {
				monDamier[i][j] = new Case();
			}
		}
		
		pionBlanc = new Pion[8];
		pionNoir = new Pion[8];
	}
	
	
	public void init() {
		for (int i = 0; i < 8; i++) {
			monDamier[i][i].setCouleur(Couleur.ORANGE);
			monDamier[i][7-i].setCouleur(Couleur.MARON);
		}
		
		//Bleu
		monDamier[0][1].setCouleur(Couleur.BLEU);
		monDamier[1][4].setCouleur(Couleur.BLEU);
		monDamier[2][7].setCouleur(Couleur.BLEU);
		monDamier[3][2].setCouleur(Couleur.BLEU);
		monDamier[4][5].setCouleur(Couleur.BLEU);
		monDamier[5][0].setCouleur(Couleur.BLEU);
		monDamier[6][3].setCouleur(Couleur.BLEU);
		monDamier[7][6].setCouleur(Couleur.BLEU);
		
		//Pourpre
		monDamier[0][2].setCouleur(Couleur.POURPRE);
		monDamier[1][7].setCouleur(Couleur.POURPRE);
		monDamier[2][4].setCouleur(Couleur.POURPRE);
		monDamier[3][1].setCouleur(Couleur.POURPRE);	
		monDamier[4][6].setCouleur(Couleur.POURPRE);
		monDamier[5][3].setCouleur(Couleur.POURPRE);
		monDamier[6][0].setCouleur(Couleur.POURPRE);
		monDamier[7][5].setCouleur(Couleur.POURPRE);
		
		//Fuchia
		monDamier[0][3].setCouleur(Couleur.FUCHIA);
		monDamier[1][2].setCouleur(Couleur.FUCHIA);
		monDamier[2][1].setCouleur(Couleur.FUCHIA);
		monDamier[3][0].setCouleur(Couleur.FUCHIA);	
		monDamier[4][7].setCouleur(Couleur.FUCHIA);
		monDamier[5][6].setCouleur(Couleur.FUCHIA);
		monDamier[6][5].setCouleur(Couleur.FUCHIA);
		monDamier[7][4].setCouleur(Couleur.FUCHIA);
		
		//Jaune
		monDamier[0][4].setCouleur(Couleur.JAUNE);
		monDamier[1][5].setCouleur(Couleur.JAUNE);
		monDamier[2][6].setCouleur(Couleur.JAUNE);
		monDamier[3][7].setCouleur(Couleur.JAUNE);	
		monDamier[4][0].setCouleur(Couleur.JAUNE);
		monDamier[5][1].setCouleur(Couleur.JAUNE);
		monDamier[6][2].setCouleur(Couleur.JAUNE);
		monDamier[7][3].setCouleur(Couleur.JAUNE);
		
		//Rouge
		monDamier[0][5].setCouleur(Couleur.ROUGE);
		monDamier[1][0].setCouleur(Couleur.ROUGE);
		monDamier[2][3].setCouleur(Couleur.ROUGE);
		monDamier[3][6].setCouleur(Couleur.ROUGE);	
		monDamier[4][1].setCouleur(Couleur.ROUGE);
		monDamier[5][4].setCouleur(Couleur.ROUGE);
		monDamier[6][7].setCouleur(Couleur.ROUGE);
		monDamier[7][2].setCouleur(Couleur.ROUGE);
		
		//Vert
		monDamier[0][6].setCouleur(Couleur.VERT);
		monDamier[1][3].setCouleur(Couleur.VERT);
		monDamier[2][0].setCouleur(Couleur.VERT);
		monDamier[3][5].setCouleur(Couleur.VERT);	
		monDamier[4][2].setCouleur(Couleur.VERT);
		monDamier[5][7].setCouleur(Couleur.VERT);
		monDamier[6][4].setCouleur(Couleur.VERT);
		monDamier[7][1].setCouleur(Couleur.VERT);
		
		
		
		for (int i = 0; i < 8; i++) {
			pionBlanc[i] = new Pion(0, i);
			pionNoir[i] = new Pion(7, i); 
		}
		
		pionBlanc[0].setCouleur(Couleur.ORANGE); 
		pionBlanc[1].setCouleur(Couleur.BLEU);
		pionBlanc[2].setCouleur(Couleur.POURPRE); 
		pionBlanc[3].setCouleur(Couleur.FUCHIA);
		pionBlanc[4].setCouleur(Couleur.JAUNE);
		pionBlanc[5].setCouleur(Couleur.ROUGE);
		pionBlanc[6].setCouleur(Couleur.VERT);
		pionBlanc[7].setCouleur(Couleur.MARON);
		
		
		pionNoir[7].setCouleur(Couleur.ORANGE); 
		pionNoir[6].setCouleur(Couleur.BLEU);
		pionNoir[5].setCouleur(Couleur.POURPRE); 
		pionNoir[4].setCouleur(Couleur.FUCHIA);
		pionNoir[3].setCouleur(Couleur.JAUNE);
		pionNoir[2].setCouleur(Couleur.ROUGE);
		pionNoir[1].setCouleur(Couleur.VERT);
		pionNoir[0].setCouleur(Couleur.MARON);
	}
	
	public String checkPion(int i, int j) {
		String s = "";
		for (Pion p : pionBlanc) {
			if (p.getX() == i && p.getY() == j) {
				if (p.getCouleur() == Couleur.ORANGE) {
					s+= "(b)o";
				} else if (p.getCouleur() == Couleur.BLEU) {
					s+= "(b)b";
				} else if (p.getCouleur() == Couleur.POURPRE) {
					s+= "(b)p";
				} else if (p.getCouleur() == Couleur.FUCHIA) {
					s+= "(b)f";
				} else if (p.getCouleur() == Couleur.JAUNE) {
					s+= "(b)j";
				} else if (p.getCouleur() == Couleur.ROUGE) {
					s+= "(b)r";
				} else if (p.getCouleur() == Couleur.VERT) {
					s+= "(b)v";
				} else if (p.getCouleur() == Couleur.MARON) {
					s+= "(b)m";
				}
				else {
					s += "\t";
				}
			}	
		}
		
		
		for (Pion p : pionNoir) {
			if (p.getX() == i && p.getY() == j) {
				if (p.getCouleur() == Couleur.ORANGE) {
					s+= "(n)o";
				} else if (p.getCouleur() == Couleur.BLEU) {
					s+= "(n)b";
				} else if (p.getCouleur() == Couleur.POURPRE) {
					s+= "(n)p";
				} else if (p.getCouleur() == Couleur.FUCHIA) {
					s+= "(n)f";
				} else if (p.getCouleur() == Couleur.JAUNE) {
					s+= "(n)j";
				} else if (p.getCouleur() == Couleur.ROUGE) {
					s+= "(n)r";
				} else if (p.getCouleur() == Couleur.VERT) {
					s+= "(n)v";
				} else if (p.getCouleur() == Couleur.MARON) {
					s+= "(n)m";
				}
				else {
					s += "\t";
				}
			}	
		}
		
		return s;
	}
	
	public String toString() {
		String s = "";
		for (int i = 0; i < 8; i++) {
			for (int j = 0; j < 8; j++) {
				s += monDamier[i][j].getCouleur() + "";
				s += checkPion(i, j);
				s += "\t";
			}
			s += "\n";
		}
		
		return s;
	}	
	
	
	public void changerPion(int xD, int yD, int xA, int yA) {
		for (Pion p : pionBlanc) {
			if (p.getX() == xD && p.getY() == yD) {
				p.setX(xA);
				p.setY(yA);
			}	
		}
		
		for (Pion p : pionNoir) {
			if (p.getX() == xD && p.getY() == yD) {
				p.setX(xA);
				p.setY(yA);
			}	
		}
	}

	public Couleur getCouleur(int xA, int yA) {
		return monDamier[yA][xA].getCouleur();
	}
	
	
	public int getXDepart(Couleur pion, int joueur) {
		if (joueur == 0) {
			for (Pion p : pionBlanc) {
				if (p.getCouleur() == pion) {
					return p.getX();
				}
			}
		}
		else {
			for (Pion p : pionNoir) {
				if (p.getCouleur() == pion) {
					return p.getX();
				}
			}
		}
		return 0;
		 
	}
	
	public int getYDepart(Couleur pion, int joueur) {
		if (joueur == 0) {
			for (Pion p : pionBlanc) {
				if (p.getCouleur() == pion) {
					return p.getY();
				}
			}
		}
		else {
			for (Pion p : pionNoir) {
				if (p.getCouleur() == pion) {
					return p.getY();
				}
			}
		}
		return 0;
		 
	}
	
	public String getListeCouleurs() {
		String res = "[";
		boolean yaUnPoint = false;
		
		for (int i = 0; i < 8; i++) {
			for (int j = 0; j < 8; j++) {
			
				for (Pion p : pionBlanc) {
					if (p.getX() == i && p.getY() == j) {
						if (p.getCouleur() == Couleur.ORANGE) {
							res += "o";
						} else if (p.getCouleur() == Couleur.BLEU) {
							res += "b";
						} else if (p.getCouleur() == Couleur.POURPRE) {
							res += "p";
						} else if (p.getCouleur() == Couleur.FUCHIA) {
							res += "f";
						} else if (p.getCouleur() == Couleur.JAUNE) {
							res += "j";
						} else if (p.getCouleur() == Couleur.ROUGE) {
							res += "r";
						} else if (p.getCouleur() == Couleur.VERT) {
							res += "v";
						} else if (p.getCouleur() == Couleur.MARON) {
							res += "m";
						}
						yaUnPoint = true;
					}
				}
				
				for (Pion p : pionNoir) {
					if (p.getX() == i && p.getY() == j) {
						if (p.getCouleur() == Couleur.ORANGE) {
							res += "o";
						} else if (p.getCouleur() == Couleur.BLEU) {
							res += "b";
						} else if (p.getCouleur() == Couleur.POURPRE) {
							res += "p";
						} else if (p.getCouleur() == Couleur.FUCHIA) {
							res += "f";
						} else if (p.getCouleur() == Couleur.JAUNE) {
							res += "j";
						} else if(p.getCouleur() == Couleur.ROUGE) {
							res += "r";
						} else if (p.getCouleur() == Couleur.VERT) {
							res += "v";
						} else if (p.getCouleur() == Couleur.MARON) {
							res += "m";
						}
						yaUnPoint = true;
					}
				}
				
				if (yaUnPoint == true) {
					yaUnPoint = false;
				} 
				else{
					res += "vide";
				}
				
				if (i == 7 && j == 7) {

				}
				else res += ",";
				
				
			}
		}
		
		res += "]";
		return res;
	}
	
	
	public String getListePions() {
		String res = "[";
		boolean yaUnPoint = false;
		
		for (int i = 0; i < 8; i++) {
			for (int j = 0; j < 8; j++) {
			
				for (Pion p : pionBlanc) {
					if (p.getX() == i && p.getY() == j) {
						res += "blanc";
						yaUnPoint = true;
					}
				}
				
				for (Pion p : pionNoir) {
					if (p.getX() == i && p.getY() == j) {
						res += "noir";
						yaUnPoint = true;
					}
				}
				
				if (yaUnPoint == true) {
					yaUnPoint = false;
				} 
				else{
					res += "vide";
				}
				
				if (i == 7 && j == 7) {

				}
				else res += ",";
				
			}
		}
		
		res += "]";
		return res;
	}
	
}
