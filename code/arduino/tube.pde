#define NUM_ITEM 10
#define rad2deg 57.29578
#define deg2rad 0.0175

int valBright = 0;
double x;
double y;
double z;
double xg;
double yg;

static double xarr[] = {0,0,0,0,0,0,0,0,0,0};
static double yarr[] = {0,0,0,0,0,0,0,0,0,0};
static double zarr[] = {0,0,0,0,0,0,0,0,0,0};
static double xrarr[] = {0,0,0,0,0,0,0,0,0,0};
static double yrarr[] = {0,0,0,0,0,0,0,0,0,0};

double last_yOut = 0;
double yOut = 0;
double last_xOut = 0;
double xOut = 0;

double deg = 0.0;
double last_rateAxg = 0.0;

double dt = 0.1;

double xvel = 0;
double last_xvel = 0;
double last_y = 0;
double last_deg = 0;

double psi = 0.0;
double theta = 0.0;
double phi = 0.0;
double last_psi = 0.0;
double last_theta = 0.0;
double last_phi = 0.0;
double last_psidot = 0.0;
double last_thetadot = 0.0;
double last_phidot = 0.0;

double xeul = 0.0;
double yeul = 0.0;
double last_xeul = 0.0;
double last_yeul = 0.0;

double xomg = 0.0;
double last_xomg = 0.0;

void setup() // run once, when the sketch starts
{
  pinMode (5, OUTPUT);
  Serial.begin(19200);
}

void loop()                     // run over and over again
{
  valBright = analogRead(5);
  valBright = map(valBright, 1, 1022, 0, 255);

  // process the accelerometer
  x = analogRead(0);
  x = map(x, 1, 1022, 1, 10000);
  x = (3311 - x)*(9.8 / 667) ;
  y = analogRead(1);
  y = map(y, 1, 1022, 1, 10000);
  y = (3277 - y)*(9.8 / 671) ;
  z = analogRead(2);
  z = map(z, 1, 1022, 1, 10000);
  z = (3262 - z)*(9.8 / 676) ;

  x = moving_avg(x,xarr);
  y = moving_avg(y,yarr);
  z = moving_avg(z,zarr);

  double mag = sqrt(x*x + y*y + z*z);

  double Axr = acos(x/mag);
  double Ayr = acos(y/mag);
  double Azr = acos(z/mag);

  double cosX = x/mag;
  double cosY = y/mag;
  double cosZ = z/mag;

  double test = sqrt(cosX*cosX + cosY*cosY + cosZ*cosZ);

  // process the gyro
  xg = analogRead(4);
  yg = analogRead(3);

  double rateAxg = ((xg*3.3/1023 - 0.921)/0.002) * deg2rad; //add constatc brrti tambah
  double rateAyg = ((yg*3.3/1023 - 0.92)/0.002) * deg2rad;

  rateAxg = moving_avg(rateAxg,xrarr);
  rateAyg = moving_avg(rateAyg,yrarr);

  if ( rateAxg > 0 )
    rateAxg = rateAxg * 2;

  if ( abs(mag - 9.8) < 1.5 )
    yOut = z * 6;
  else
    yOut = last_yOut;

  if ( yOut > 20.0 )
    yOut = 20.0;
  if ( yOut < -20.0 )
    yOut = -20.0;

  if ( x > 0 && y > 0 )
    deg = abs(atan(x/y)) * rad2deg + 180 ;
  else if ( x > 0 && y < 0 )
    deg = 360 - abs(atan(x/y)) * rad2deg ;
  else if ( x < 0 && y < 0 )
    deg = abs(atan(x/y)) * rad2deg + 0 ;
  else if ( x < 0 && y > 0 )
    deg = 180 - abs(atan(x/y)) * rad2deg  ;

  // find w3 from deg
  if ( abs(last_deg - deg) > 200 ){
    if ( last_deg > deg )
      last_deg = last_deg - 360;
    else
      last_deg = last_deg + 360;
  }
  double w3 = (6*(deg - last_deg)) * deg2rad ;


  if ( abs(y) < 0.5)
    y = 0.0;

  if ( abs(rateAxg) < 0.05 )
    rateAxg = 0.0;
  if ( abs(rateAyg) < 0.05 )
    rateAyg = 0.0;
  if ( abs(w3) < 0.1 )
    w3 = 0.0;

//  // Alyssa's kinematics eq
//  // euler's method for angular orientation and angular velocity
//  psi = last_psi + dt * ( sin(last_phi) / cos(last_theta) * rateAyg + cos(last_phi) / cos(last_theta) * w3 ) ;
//
//  theta = last_theta + dt * ( cos(last_phi) * rateAyg - sin(last_phi) * w3 );
//  //theta = -1 * theta;
//  phi = last_phi + dt * ( rateAxg + sin(last_phi) * tan(last_theta) * rateAyg + cos(last_phi) * tan(last_theta) * w3) ;
//  //phi = -1 * phi;
//
//  if ( theta > 1.5 || theta < 0.0)
//    theta = 0.7;
//  if ( psi > 1.5 || theta < 0.0)
//    psi = 0.7;
//  if ( phi > 1.5 || theta < 0.0)
//    phi = 0.7;
//
//
//  // euler's method for integrating velocity to determine the x and y coordinate
//
//  xeul = last_xeul + dt *100* ( rateAxg * ( -1 * sin(psi) * cos(phi) + cos(psi) * sin(theta) * sin(phi) ) + rateAyg * ( cos(psi) * cos(theta) ) );
//
//  yeul = last_yeul + dt *100* ( -1 * rateAxg * ( cos(psi) * cos(phi) + sin(psi) * sin(theta) * sin(phi) ) + rateAyg * ( sin(psi) * cos(theta) ) );
//
//  if ( xeul > 20.0 )
//    xeul = 20.0;
//  if ( xeul < -20.0 )
//    xeul = -20.0;

  // last idea
  xomg = last_xomg + ( rateAxg * sin(deg*deg2rad) + rateAyg * cos(deg*deg2rad)*25 );


  if ( xomg > 20.0 )
    xomg = 20.0;
  if ( xomg < -20.0 )
    xomg = -20.0;

  analogWrite(5, valBright);

   Serial.print(x);
   Serial.print("\t");
   Serial.print(y);
   Serial.print("\t");
   Serial.print(z);
   Serial.print("\t");
   Serial.print(rateAxg);
   Serial.print("\t");
   Serial.print(rateAyg);
   Serial.print("\t");
   Serial.print(valBright);
   Serial.print("\t");
   Serial.print(mag);
   Serial.print("\t");
   Serial.print(deg);
   Serial.print("\t");
   Serial.print(w3);
   Serial.print("\t");
   Serial.print(xomg);
   Serial.print("\t");
   Serial.print(yOut);
   Serial.print("\n");

   last_yOut = yOut;
   last_xOut = xOut;
   last_xvel = xvel;
   last_y = y;
   last_rateAxg = rateAxg;
   last_deg = deg;

   last_psi = psi;
   last_theta = theta;
   last_phi = phi;

   last_xeul = xeul;
   last_yeul = yeul;

   last_xomg = xomg;
   //delay(100);
}

double moving_avg(double num, double *arr)
{
    int i;
    float sum = 0;

    for (i = NUM_ITEM - 1;i > 0;i--) {
        arr[i] = arr[i - 1];
    }

    arr[0] = num;


    for (i = 0;i < NUM_ITEM;i++) {
        sum += arr[i];
    }

    return sum / NUM_ITEM;
}

