import java.io.*;
import java.net.*;
import java.lang.*;
import java.nio.ByteOrder;
import java.nio.ByteBuffer;
import java.nio.charset.Charset;
import java.util.concurrent.TimeUnit;
import se.sics.jasper.*;
import java.util.*;


public class joueur
{

	public static void main(String[] args)
	{
		boolean finished = false;

		if (args.length != 4)
		{
			System.out.println("See usage : \n"
							   + "\t~ java joueur ARG1 ARG2 ARG3 \n"
							   + "\tARG1 : name of player \n"
							   + "\tARG2 : color wished (0 for white, 1 for black) \n"
							   + "\tARG3 : port server \n"
							   + "\tARG4 : adress \n");

			return;
		}

		// SICSTUS PART
		SICStus sp = null;

		try
		{
			sp = new SICStus();

			// Chargement d'un fichier prolog .pl
			sp.load("../pilou/prolog/plateau.pl");
			System.out.println("Load of the file : done");
		}
		catch (Exception e)
		{
			System.err.println("Exception SICStus Prolog : " + e);
			e.printStackTrace();
			System.exit(-2);
		}

		// CREATE DAMIER
		Damier damier = new Damier();
		damier.init();
		System.out.println("Load of the damier : done");
		// System.out.println(damier.toString());

		try
		{
			// CREATE SOCKET
			Socket socket = new Socket(args[3], Integer.parseInt(args[2]));

			// LETS PARTY
			envoyerParti(socket, args[0], Integer.parseInt(args[1]));
			int color = recoisParti(socket, Integer.parseInt(args[1]));
			System.out.println("color : " + color);
			if (color == 0)
			{
				System.out.println("color : WHITE");
			}
			else
			{
				System.out.println("color : BLACK");
			}

			int proprieteCoup = 0;
			// NOW WE CAN PLAY
			// FIRST MOVE
			boolean monTour		  = false;
			boolean jouer		  = true;
			Couleur couleurAJouer = Couleur.ORANGE;

			if (color == 0)
			{
				System.out.println("I'm FIRST");
				envoyerCoup(socket, color, damier, sp, true, couleurAJouer, 1);

				proprieteCoup = recevoirReponseCoup(socket);
				if (proprieteCoup != 0)
					jouer = false;
				monTour   = false;
			}
			else
			{
				System.out.println("I'm SECOND");
				proprieteCoup = recevoirReponseCoup(socket);
				if (proprieteCoup != 0)
					jouer = false;

				couleurAJouer = recevoirCoup(socket, damier);
				System.out.println("Couleur à jouer : " + couleurAJouer);
				monTour = true;
			}

			int i = 0;
			// THEN OTHER MOVE
			while (jouer)
			{
				System.out.println("\n\n\n\n\n\n");
				try
				{
					Thread.sleep(1000);
				}
				catch (Exception e)
				{
					System.out.println("" + e);
				}


				if (monTour)
				{

					System.out.println("C'EST MON TOUR1");
					envoyerCoup(socket, color, damier, sp, false, couleurAJouer, 1);
					proprieteCoup = recevoirReponseCoup(socket);
					if (proprieteCoup != 0)
						break;
					monTour = false;
				}
				else
				{

					System.out.println("PAS MON TOUR1");
					proprieteCoup = recevoirReponseCoup(socket);
					if (proprieteCoup != 0)
						break;
					couleurAJouer = recevoirCoup(socket, damier);
					System.out.println("Couleur à jouer : " + couleurAJouer);
					monTour = true;
				}

				// System.out.println(damier.toString());
			}


			try
			{
				Thread.sleep(2000);
			}
			catch (Exception e)
			{
				System.out.println("" + e);
			}
			Damier damier2 = new Damier();
			damier2.init();

			couleurAJouer = Couleur.ORANGE;
			System.out.println("WE ARE GOING TO PLAY SECOND GAME");

			// DEUXIEME PARTI
			if (color == 1)
			{
				System.out.println("I'm FIRST2");
				envoyerCoup(socket, color, damier2, sp, true, couleurAJouer, 2);

				recevoirReponseCoup(socket);
				monTour = false;
			}
			else
			{
				System.out.println("I'm SECOND2");
				recevoirReponseCoup(socket);
				couleurAJouer = recevoirCoup(socket, damier2);
				System.out.println("Couleur à jouer : " + couleurAJouer);
				monTour = true;
			}


			while (true)
			{
				System.out.println("\n\n\n\n\n\n");
				try
				{
					Thread.sleep(3000);
				}
				catch (Exception e)
				{
					System.out.println("" + e);
				}


				if (monTour)
				{

					System.out.println("C'EST MON TOUR");
					envoyerCoup(socket, color, damier2, sp, false, couleurAJouer, 2);
					proprieteCoup = recevoirReponseCoup(socket);
					monTour		  = false;
				}
				else
				{

					System.out.println("PAS MON TOUR");
					proprieteCoup = recevoirReponseCoup(socket);
					couleurAJouer = recevoirCoup(socket, damier2);
					System.out.println("Couleur à jouer : " + couleurAJouer);
					monTour = true;
				}

				System.out.println(damier2.toString());

				if (proprieteCoup != 0)
					break;
			}

			socket.close();
		}
		catch (IOException e)
		{
			System.out.println("" + e);
		}
	}

	public static void envoyerParti(Socket socket, String namePlayer, int color)
	{
		try
		{
			OutputStream	   os  = socket.getOutputStream();
			OutputStreamWriter osw = new OutputStreamWriter(os);
			DataOutputStream   dos = new DataOutputStream(socket.getOutputStream());
			BufferedWriter	 bw  = new BufferedWriter(osw);


			int requeteP;
			requeteP = reverseInt(0);
			dos.writeInt(requeteP);
			String sendMessage = namePlayer;
			byte[] message	 = new byte[32];
			int tmp			   = sendMessage.length();


			for (int i = 0; i < 32; i++)
			{
				if (i < tmp)
				{
					dos.writeByte(namePlayer.charAt(i));
				}
				else
				{
					dos.writeByte('\0');
				}
				System.out.println("i : " + i);
				// sendMessage += 0;
			}


			dos.writeInt(reverseInt(color));


			// dos.write(sendMessage.getBytes());


			bw.flush();
		}
		catch (UnknownHostException e)
		{
			e.printStackTrace();
		}
		catch (IOException e)
		{
			e.printStackTrace();
		}
	}

	public static int recoisParti(Socket socket, int colorPrevu)
	{
		int color = 0;

		try
		{
			DataInputStream in = new DataInputStream(socket.getInputStream());


			byte[] buffer = new byte[40];

			in.read(buffer);

			ByteBuffer bb = ByteBuffer.wrap(buffer);
			bb.order(ByteOrder.LITTLE_ENDIAN);

			int codeRetour = bb.getInt(0);

			String nomAdversaire = "";

			for (int i = 4; i < 39; i++)
			{
				buffer[i] = bb.get(i);
				nomAdversaire += (char)bb.get(i);
				if (buffer[i] == 0)
				{
					break;
				}
				// System.out.println("Received : " + i + " " + buffer[i]);
			}


			color = bb.getInt(36);

			if (color == 1 && colorPrevu == 0)
			{
				color = 1;
			}
			else if (color == 1 && colorPrevu == 1)
			{
				color = 0;
			}
			else
			{
				color = colorPrevu;
			}

			System.out.println("Received : " + codeRetour);
			System.out.println("Color : " + color);
			System.out.println("name : " + nomAdversaire);

			if (codeRetour != 0)
			{
				// erreur sur la demande ?
			}
		}
		catch (UnknownHostException e)
		{
			e.printStackTrace();
		}
		catch (IOException e)
		{
			e.printStackTrace();
		}

		return color;
	}

	public static void envoyerCoup(Socket socket, int color, Damier dam, SICStus sp, boolean firstCoup, Couleur couleurAJouer, int numParti)
	{
		int xDepart = 0, yDepart = 0;
		int xArrive = 1, yArrive = 1;
		int typeCoup = 0;

		try
		{

			OutputStream	   os  = socket.getOutputStream();
			OutputStreamWriter osw = new OutputStreamWriter(os);
			DataOutputStream   dos = new DataOutputStream(socket.getOutputStream());
			BufferedWriter	 bw  = new BufferedWriter(osw);


			// envoi TIdReq

			dos.writeInt(reverseInt(1));

			// envoi numero partie
			dos.writeInt(reverseInt(numParti));


			if (!firstCoup)
			{
				yDepart = dam.getXDepart(couleurAJouer, color);
				xDepart = dam.getYDepart(couleurAJouer, color);

				System.out.println("X: " + xDepart);
				System.out.println("Y: " + yDepart);

				String res = demanderAProlog(sp, dam, color, xDepart, yDepart);
				System.out.println(res);

				xArrive = getXResult(res);
				yArrive = getYResult(res);


				if (xArrive == 9 && yArrive == 9)
					typeCoup = 1;
			}

			if (firstCoup && color == 1)
			{
				xDepart = 7;
				yDepart = 7;
				xArrive = 6;
				yArrive = 6;
			}


			// envoi typeCoup (0 : deplacement, 1 : passe)
			dos.writeInt(reverseInt(typeCoup));

			// info du pion joue TPion.
			// 1er write : couleur du joueur (0 ou 1)
			// 2eme write : couleur du pion joué (O..7)
			dos.writeInt(reverseInt(color));
			int couleurJouer = 0;
			if (couleurAJouer == Couleur.ORANGE)
				couleurJouer = 0;
			else if (couleurAJouer == Couleur.BLEU)
				couleurJouer = 1;
			else if (couleurAJouer == Couleur.POURPRE)
				couleurJouer = 2;
			else if (couleurAJouer == Couleur.FUCHIA)
				couleurJouer = 3;
			else if (couleurAJouer == Couleur.JAUNE)
				couleurJouer = 4;
			else if (couleurAJouer == Couleur.ROUGE)
				couleurJouer = 5;
			else if (couleurAJouer == Couleur.VERT)
				couleurJouer = 6;
			else if (couleurAJouer == Couleur.MARON)
				couleurJouer = 7;


			dos.writeInt(reverseInt(couleurJouer));
			// System.out.println("depart (" + xDepart + "," + yDepart + ")");
			// System.out.println("arrive (" + xArrive + "," + yArrive + ")");

			// deplacementPion
			// case depart
			if (xArrive == 9 && yArrive == 9)
			{
				// case depart
				dos.writeInt(reverseInt(xDepart));
				dos.writeInt(reverseInt(yDepart));


				// case arrive
				dos.writeInt(reverseInt(xDepart));
				dos.writeInt(reverseInt(yDepart));
			}
			else
			{
				// case depart
				dos.writeInt(reverseInt(xDepart));
				dos.writeInt(reverseInt(yDepart));


				// case arrive
				dos.writeInt(reverseInt(xArrive));
				dos.writeInt(reverseInt(yArrive));
			}

			dam.changerPion(yDepart, xDepart, yArrive, xArrive);
			System.out.println("COUP ENVOYE");
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}

	public static int recevoirReponseCoup(Socket socket)
	{
		int res = 0;
		try
		{
			DataInputStream in = new DataInputStream(socket.getInputStream());

			byte[] buffer = new byte[12];

			in.read(buffer);

			ByteBuffer bb = ByteBuffer.wrap(buffer);
			bb.order(ByteOrder.LITTLE_ENDIAN);

			int codeReponse = bb.getInt(0);

			int validiteCoup = bb.getInt(4);

			int proprieteCoup = bb.getInt(8);


			System.out.println("Received : " + codeReponse);
			System.out.println("Validité coup : " + validiteCoup);
			System.out.println("Propriete coup : " + proprieteCoup);

			res = proprieteCoup;
		}
		catch (UnknownHostException e)
		{
			e.printStackTrace();
		}
		catch (IOException e)
		{
			e.printStackTrace();
		}

		return res;
	}

	public static Couleur recevoirCoup(Socket socket, Damier dam)
	{
		Couleur next = Couleur.ROUGE;
		try
		{
			DataInputStream in = new DataInputStream(socket.getInputStream());

			byte[] buffer = new byte[36];

			in.read(buffer);

			ByteBuffer bb = ByteBuffer.wrap(buffer);
			bb.order(ByteOrder.LITTLE_ENDIAN);

			int TIdRep			  = bb.getInt(0);
			int numeroParti		  = bb.getInt(4);
			int typeCoup		  = bb.getInt(8);
			int couleurAdversaire = bb.getInt(12);
			int couleurPion		  = bb.getInt(16);

			int xDepart = bb.getInt(20);
			int yDepart = bb.getInt(24);
			int xArrive = bb.getInt(28);
			int yArrive = bb.getInt(32);

			System.out.println("TIdRep : " + TIdRep);
			System.out.println("Numero parti : " + numeroParti);
			System.out.println("Type coup (0 : deplacer / 1 : passe) : " + typeCoup);
			System.out.println("couleur adversaire : " + couleurAdversaire);
			System.out.println("couleur pion joue : " + couleurPion);
			System.out.println("depart (" + xDepart + "," + yDepart + ")");
			System.out.println("arrive (" + xArrive + "," + yArrive + ")");


			dam.changerPion(yDepart, xDepart, yArrive, xArrive);
			next = dam.getCouleur(xArrive, yArrive);
		}
		catch (UnknownHostException e)
		{
			e.printStackTrace();
		}
		catch (IOException e)
		{
			e.printStackTrace();
		}
		// System.out.println("COUP RECU");


		return next;
	}

	public static String demanderAProlog(SICStus sp, Damier dam, int color, int xDepart, int yDepart)
	{
		HashMap results = new HashMap();
		String  saisie  = new String("");

		String res = "";

		int xArrive = 0, yArrive = 0;
		try
		{
			Query  qu;
			String s = "";
			if (color == 0)
			{
				s +=
					"choisirUnMouvementBlanc(" + xDepart + ", " + yDepart + ", " + dam.getListePions() + ", " + dam.getListeCouleurs() + ", IC, JC).";
				System.out.println(s);
				qu = sp.openQuery(s, results);
			}
			else
			{
				s += "choisirUnMouvementNoir(" + xDepart + ", " + yDepart + ", " + dam.getListePions() + ", " + dam.getListeCouleurs() + ", IC, JC).";
				// System.out.println(s);
				qu = sp.openQuery(s, results);
			}
			// parcours des solutions
			boolean moreSols = qu.nextSolution();


			boolean continuer = !(results.isEmpty());


			res = results.toString();
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}

		return res;
	}


	public static int getYResult(String result)
	{
		int res = 0;
		res		= Integer.parseInt(Character.toString(result.charAt(4)));
		// System.out.println("Y ARRIVE : " + res);
		return res;
	}

	public static int getXResult(String result)
	{
		int res = 0;
		res		= Integer.parseInt(Character.toString(result.charAt(10)));
		// System.out.println("X ARRIVE : " + res);
		return res;
	}


	public static int reverseInt(int value)
	{
		int b1 = (value >> 0) & 0xff;
		int b2 = (value >> 8) & 0xff;
		int b3 = (value >> 16) & 0xff;
		int b4 = (value >> 24) & 0xff;

		return b1 << 24 | b2 << 16 | b3 << 8 | b4 << 0;
	}

	public static byte reverseByte(byte n)
	{
		int n1 = (n >> 0) & 0xF0;
		int n2 = (n >> 4) & 0X0F;

		return (byte)(n1 << 4 | n2 << 0);
	}
}
