/**
 * class Piece
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

public class Piece {

	// current position;
	float x;
	float y;
	float z;

	float sizex;
	float sizey;

	// orignal position of the piece
	float distx;
	float disty;
	float distz;

	// these variables specify the shape of the brush
	float orgx;
	float orgy;
	float orgz;

	float oldx;
	float oldy;
	float oldz;

	// masatsu
	float fFriction = 2.0f;

	// katasa
	float fHardness = 1.0f;

	Pigment pigment;

	float amount;

	Brush parent;

	public Piece(Brush parent) {
		this.parent = parent;
		pigment = new Pigment(20, 20, 20, parent.alchemy.fAlpha);
	}

	public Piece(int r, int g, int b, int a, Brush parent) {
		this.parent = parent;
		pigment = new Pigment(r, g, b, a);
	}

	public void draw() {
		parent.parent.stroke(0);
		parent.parent.noFill();
		parent.parent.ellipse(x, y, sizex, sizey);
	}

	public void paint() {
		amount -= parent.fOutAmount;
		if (amount < 0)
			amount = 0;

		// parent.parent.fill(pigment.red, pigment.green, pigment.blue, amount);
		parent.parent.noStroke();
		parent.parent.ellipse(x, y, sizex, sizey);

		// parent.parent.stroke(pigment.red, pigment.green, pigment.blue, amount);
		parent.parent.noFill();
		parent.parent.strokeWeight(parent.parent.sqrt(sizex * sizex + sizey * sizey) / 2);
		parent.parent.line(oldx, oldy, x, y);
	}

	public void moveTo(float x, float y, float z) {
		distx = orgx + x;
		disty = orgy + y;
		distz = orgz + z;
	}

	public void animate() {
		amount += parent.fInAmount;
		if (amount > parent.alchemy.fAlpha)
			amount = parent.alchemy.fAlpha;

		oldx = x;
		oldy = y;
		oldz = z;

		if (z > 1.0f)
			fFriction = parent.parent.constrain(z, 1.0f, fHardness);
		else
			fFriction = 1.0f;

		x += (distx - x) / fFriction;
		y += (disty - y) / fFriction;
		z += (distz - z) / 1.0f;// fFriction;
	}

	public void setPosition(float x, float y, float z) {
		this.distx = x;
		this.disty = y;
		this.distz = z;
		x = x;
		y = y;
		z = z;
	}

	public void setSize(int sizex, int sizey){
		this.sizex = sizex;
		this.sizey = sizey;

	}
}
