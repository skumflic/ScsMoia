public class Case {

	Couleur pion;
	Couleur c;
	
	public Case() {
		
	}
	
	public void setCouleur(Couleur c) {
		this.c = c;
	}
	
	public Couleur getCouleur() {
		return c;
	}
	
	public void setCouleurPion(Couleur pion) {
		this.pion = pion;
	}
	
	public Couleur getCouleurPion(Couleur pion) {
		return pion;
	}
	
}
