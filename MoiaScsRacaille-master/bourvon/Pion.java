public class Pion {
	private int x, y;
	Couleur c;
	
	public Pion(int x, int y) {
		this.x = x;
		this.y = y;
	}
	
	
	public void setCouleur(Couleur c) {
		this.c = c;
	}
	
	public Couleur getCouleur() {
		return c;
	}
	
	
	public void setX(int x) {
		this.x = x;
	}
	
	public void setY(int y) {
		this.y = y;
	}
	
	
	public int getX() {
		return x;
	}
	
	public int getY() {
		return y;
	}
	
	
}
