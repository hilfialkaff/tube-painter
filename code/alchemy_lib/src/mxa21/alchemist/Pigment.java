/**
 * class Pigment
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

public class Pigment {
	public float red;
	public float blue;
	public float green;
	public float alpha;

	public Pigment(float red, float green, float blue, float alpha) {
		this.red = red;
		this.blue = blue;
		this.green = green;
		this.alpha = alpha;
	}
}
