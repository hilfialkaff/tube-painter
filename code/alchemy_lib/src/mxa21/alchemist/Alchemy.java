/**
 * class Alchemy
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

import processing.core.PApplet;

public class Alchemy {
	PApplet parent;

	float fAlpha = 5.0f;

	/**
	 * initialize Alchemy library
	 * 
	 * @author Tatsuya Saito
	 * @param parent
	 *            An instance of PApplet
	 *            In setup function of a Processing sketch, do as follows:
	 *            <pre>
	 * void setup(){
	 *    Alchemy alchemy = new Alchemy(this);
	 *    
	 *     ...
	 * }
	 *            </pre>
	 */
	public Alchemy(PApplet parent) {
		this.parent = parent;
	}

	public void animate() {

	}

	public void draw() {

	}

	/**
	 * Validates a chess move.
	 * 
	 * @author Tatsuya Saito
	 * @return An instance of Brush class
	 * 
	 */
	public Brush brush() {
		Brush brush = new Brush(this);
		brush.parent = parent;
		return brush;
	}
}