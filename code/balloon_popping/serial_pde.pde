import processing.serial.*;
import java.lang.String.*;


  final String portname = "COM7"; // or "COM5"
  final int BAUD_RATE = 9600;
  
  Serial port;
  final int lf = 10;  // ASCII linefeed == 10

  static final int SERIAL_DATA_LEN = 11;
  double xAcc,yAcc,zAcc,xr,yr,fsr,magnitude,deg,zr,xOut,yOut;  
  String serialData = "";
  int counter = 0;
  
  void __setup(PApplet applet)
  {  
    port = new Serial(applet, portname, BAUD_RATE);
  }
      
      float calibrate_x()
{
  return ((float)xAcc+20) * (CANVAS_WIDTH / 40);
}

float calibrate_y()
{
  return (CANVAS_HEIGHT - ((float)yAcc+20) * (CANVAS_HEIGHT / 40));
}

final static int TOKEN_LENGTH = 5;

void serialEvent(int serial) {
  if(serial != lf) {
    serialData += char(serial);
  }

  else {
    println(serialData);
    String delims = "\t";
    String[] tokens = serialData.split(delims); 
    if (tokens.length == TOKEN_LENGTH){
      xAcc = Double.parseDouble(tokens[0]);
      yAcc = Double.parseDouble(tokens[1]);
      fsr = Double.parseDouble(tokens[2]);
      deg = Double.parseDouble(tokens[3]);
      //zr = Double.parseDouble(tokens[4]);
      print(xAcc);
      print(yAcc);
      print(fsr);
      print(deg);
      //print(zr);
    }
      
    serialData = "";
  }
}






//  void serialEvent(int serial) {
//    if(serial != lf) {
//      serialData += char(serial);
//      // println("serial: " + char(serial));
//    }
//    else {
//      if((counter % NUM_EVENTS) == 0) {
//         xAcc = Double.parseDouble(serialData);
//         println("x: " + xAcc);
//      } else if ((counter % NUM_EVENTS) == 1){
//        yAcc = Double.parseDouble(serialData);
//        println("y: " + yAcc);
//      } else {
//        fsr = Double.parseDouble(serialData);
//        println("fsr: " + fsr);
//      }
//       serialData = "";
//       counter++;
//     }
//  }
