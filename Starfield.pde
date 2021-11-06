starL[] carl = new starL[101];

float cannonRotate;
float recoil = 0;
float ballX, ballY, aimX, aimY, compX, compY, angle, grav;
int ballspeed;

///////////////////////////////////////////////////////////////////////////////////////////////

void setup() {
  size(1600, 800);
  noStroke();
  ballX = 0;
  ballY = 0;
  aimX = 1;
  aimY = 0;
  grav = 0;
  carl[100] = new cannonBall();
}

///////////////////////////////////////////////////////////////////////////////////////////////

void mouseClicked() {
  aimX = (float)mouseX-50;
  aimY = (float)mouseY-700;
  grav = 0;
  recoil = 10;
  
  if (aimX >= 0)
    angle = atan(aimY/aimX);
  else
    angle = PI+atan(aimY/aimX);
  
  for (int i = 0; i < 100 && carl[i] == null; i++) {
    carl[i] = new starL();
  }
  carl[100] = new cannonBall();
}

///////////////////////////////////////////////////////////////////////////////////////////////

void draw() {
  translate(50, 700);
  background(104, 118, 138);
  
  for(float i = 0; i <= 625; i+=5) {
    fill(104+(i/40),118+(i/40),138+(i/40));
    rect(-50, i-600, 1600, 5);
  }
  ///////////////////////////////////////////////////////////
  for (int i = 0; i < 100 && carl[i] != null; i++) {
    carl[i].show();
    carl[i].next();
    if (carl[i].opacity <= 0)
      carl[i] = null;
  }
  if (carl[100].yPos < 25) {
    System.out.println(grav/60);
    grav++;
  }
  else {
    carl[100].speed = 0;
    carl[100].yPos = 25;
  }
  carl[100].show();
  carl[100].next();
  carl[100].opacity+=20;
  ///////////////////////////////////////////////////////////
  fill(25);
  if (recoil > 0)
    recoil -= 0.2;
  else
    recoil = 0;
  
  rotate(angle);
  beginShape();
  vertex(-10-recoil, -10);
  vertex(90-recoil, -8);
  vertex(90-recoil, 8);
  vertex(-10-recoil, 10);
  endShape(CLOSE);
  ellipse(-10-recoil, 0, 40, 20);
  rotate(-angle);
  
  fill(57,48,42);
  beginShape();
  vertex(10, 0);
  vertex(-10, 0);
  vertex(-30, 20);
  vertex(-30, 30);
  vertex(30, 30);
  vertex(30, 20);
  endShape(CLOSE);
  
  for(float i = -50; i <= 1600; i+=10) {
    fill(45+(i/40),71-(i/40),37-(i/40));
    rect(i, 30, 10, 70);
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////

class starL {
  float rotation, speed, size, xPos, yPos;
  int opacity, g;
  color balls;
  starL() {
    rotation = (float)(-Math.random()*PI/24+PI/48);
    speed = (float)(Math.random()*10);
    opacity = 200;
    size = 5;
    xPos = 70*cos(angle);
    yPos = 70*sin(angle);
    balls = color(255, 150, 100);
    g = 0;
  }

  void show() {
    rotate(rotation);
    fill(balls, opacity);
    ellipse(xPos, yPos, size, size);
    rotate(-rotation);
  }

  void next() {
    xPos += speed*cos(angle);
    yPos += speed*sin(angle)+g*(grav/60);
    if (opacity > 0)
      opacity-=10;
  }
}

///////////////////////////////////////////////////////////

class cannonBall extends starL {
  cannonBall() {
    rotation = 0;
    speed = 25;
    size = 14;
    xPos = 70*cos(angle);
    yPos = 70*sin(angle);
    balls = color(50);
    g = 25;
  }
}
