/**
 * class Brush
 * <pre>
 * ピリオド(.)または句点(。)で終わるところまでが、クラス一覧の概要に説明されるところであり、
 * ピリオド以降は説明の概要には含まれず、クラスの説明に含まれる。
 * このように、JavadocにはHTMLタグを使用することができる。
 * </pre>
 * @param <T1> 総称型パラメータの説明
 * @param <T2> 総称型パラメータの説明
 * @author Tatsuya Saito
 * @author Takahiro Miura
 * @author Masaki Fujihata
 * @version 0.1
 * @since 1.0
 */

package mxa21.alchemist;

import java.util.Vector;

import processing.core.PApplet;

public class Brush {
	float x;
	float y;
	float z;

	Vector pieces;
	PApplet parent;
	Alchemy alchemy;

	float fInAmount = 0.51f;
	float fOutAmount = 0.55f;

	public Brush(Alchemy alchemy) {

		this.alchemy = alchemy;

		pieces = new Vector();
		for (int i = 0; i < 20; i++) {
			// Piece piece = new Piece(i*10, 20, 20, 20);
			// Piece piece = new Piece(i*10, 20, 200-i*10, 20);
			Piece piece = new Piece(10, 10, 30, (int) alchemy.fAlpha, this);
			piece.orgx = 0;
			piece.orgy = 0;
			piece.orgz = i;
			piece.sizex = (41 - i * 2) / 2.0f;
			piece.sizey = (41 - i * 2) / 2.0f;
			pieces.add(piece);
		}
	}

	public void draw() {
		// parent.fill(0);
		parent.ellipse(x, y, 5, 5);

		for (int i = 0; i < pieces.size(); i++) {
			Piece piece = (Piece) pieces.elementAt(i);
			piece.draw();
		}
	}

	/**
	 * setting hardness of a brush
	 *
	 * @author Tatsuya Saito
	 * @param hardness
	 *            a float value for specifying hardness of a brush.
	 */
	public void setHardness(float hardness) {
		for (int i = 0; i < pieces.size(); i++) {
			Piece piece = (Piece) pieces.elementAt(i);
			piece.fHardness = hardness;
		}
	}

	/**
	 * initialize Alchemy library
	 *
	 * @author Tatsuya Saito
	 * @param x
	 *            a float value for specifying X-position of the destinaion.
	 * @param y
	 *            a float value for specifying Y-position of the destinaion.
	 * @param z
	 *            a float value for specifying Z-position of the destinaion.
	 */
	public void setPosition(float x, float y, float z) {
		for (int i = 0; i < pieces.size(); i++) {
			Piece piece = (Piece) pieces.elementAt(i);
			piece.setPosition(x, y, z);
		}
	}

	/**
	 * moving a brush
	 *
	 * @author Tatsuya Saito
	 * @param x
	 *            a float value for specifying X-position of a brush.
	 * @param y
	 *            a float value for specifying Y-position of a brush.
	 * @param z
	 *            a float value for specifying Z-position of a brush.
	 */
	public void moveTo(float x, float y, float z) {
		this.x = x;
		this.y = y;
		this.z = z;
		for (int i = 0; i < pieces.size(); i++) {
			Piece piece = (Piece) pieces.elementAt(i);
			piece.moveTo(x, y, z);
		}
	}

	/**
	 * animates the Brush
	 *
	 * This function should be called every time draw() function is called.
	 * Do as follows:
	 *
	 *  <pre>
	 *  void draw(){
	 *  	...
	 *      brush.animate();
	 *      brush.paint();
	 *  	...
	 *  }
	 *  </pre>
	 * @author Tatsuya Saito
	 */
	public void animate() {
		for (int i = 0; i < pieces.size(); i++) {
			Piece piece = (Piece) pieces.elementAt(i);
			piece.animate();
		}
	}

	/**
	 * render the recent update of the brush
	 *
	 * This function should be called every time draw() function is called.
	 * Do as follows:
	 *
	 *  <pre>
	 *  void draw(){
	 *  	...
	 *      brush.animate();
	 *      brush.paint();
	 *  	...
	 *  }
	 *  </pre>
	 * @author Tatsuya Saito
	 */
	public void paint() {
		for (int i = 0; i < pieces.size(); i++) {
			Piece piece = (Piece) pieces.elementAt(i);
			if (piece.z > 0)
				piece.paint();
		}
	}

	/**
	 * render the recent update of the brush
	 *
	 * This function should be called every time draw() function is called.
	 * Do as follows:
	 *
	 *  <pre>
	 *  void draw(){
	 *  	...
	 *      brush.animate();
	 *      brush.paint();
	 *  	...
	 *  }
	 *  </pre>
	 * @author Tatsuya Saito
	 */
	public int getSize(int index) {
		Piece piece = (Piece) pieces.elementAt(index);
		return (int) parent.sqrt(piece.sizex * piece.sizex + piece.sizey
				* piece.sizey);

	}

	public int getPieceNum() {
		return pieces.size();
	}

	public Piece getPiece(int index) {
		return (Piece) pieces.elementAt(index);
	}

	public Pigment getPiecePigment(int index) {
		Piece piece = (Piece) pieces.elementAt(index);
		return piece.pigment;
	}

	public void setPiecePigment(int index, Pigment pigment) {
		Piece piece = (Piece) pieces.elementAt(index);
		piece.pigment = pigment;
	}

	public float getAmount(int index) {
		Piece piece = (Piece) pieces.elementAt(index);
		return piece.amount;
	}
}
