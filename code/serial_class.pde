import processing.serial.*;
import java.lang.String.*;


class SerialData {
  private final String portname = "COM3"; // or "COM5"
  public Serial port;
  private final int lf = 10;  // ASCII linefeed == 10

  private static final int SERIAL_DATA_LEN = 11;
  public double xAcc,yAcc,zAcc,xr,yr,fsr,magnitude,deg,zr,xOut,yOut;

  public void __setup(PApplet applet)
  {
    port = new Serial(applet, portname, 9600);

    boolean once = true;

    while (once) {
      if(port.available() > 0 && port.readStringUntil(lf) != null) {
            once = false;
      }
    }
  }

  public void __draw()
  {
     boolean once = true;

     while (once){
       if (port.available() > 0) {
         String serialData = port.readStringUntil(lf);
         if(serialData != null){
            once = false;
            String delims = "\t";
            String[] tokens = serialData.split(delims);
            assert(tokens.length == SERIAL_DATA_LEN);

            xAcc = Double.parseDouble(tokens[0]);
            yAcc = Double.parseDouble(tokens[1]);
            zAcc = Double.parseDouble(tokens[2]);
            xr = Double.parseDouble(tokens[3]);
            yr = Double.parseDouble(tokens[4]);
            fsr = Double.parseDouble(tokens[5]);
            magnitude = Double.parseDouble(tokens[6]);
            deg = Double.parseDouble(tokens[7]);
            zr = Double.parseDouble(tokens[8]);
            xOut = Double.parseDouble(tokens[9]);
            yOut = Double.parseDouble(tokens[10]);

            // for testing
    //        System.out.println(xAcc);
    //        System.out.println(yAcc);
    //        System.out.println(zAcc);
    //        System.out.println(xr);
    //        System.out.println(yr);
    //        System.out.println(fsr);
    //        System.out.println(magnitude);
    //        System.out.println(deg);
    //        System.out.println(zr);
    //        System.out.println(xOut);
    //        System.out.println(yOut);
    //
    //        System.out.println();
         }
     }
    }
  }
}
