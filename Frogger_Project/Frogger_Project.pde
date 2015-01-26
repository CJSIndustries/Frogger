//game
Car[] cars = new Car[5]; // number of cars
Log[] logs = new Log[5]; // number of logs
int life = 10;
int score = 0;
PImage frog;
float frogx, frogy; //Frog Position
boolean gamerun = false;
//title screen
int count =25;
PVector[] loc = new PVector[count];
PVector[] vel = new PVector[count];
PVector[] acc = new PVector[count];
float[] sz = new float[count];
PImage F;
PImage back;

void setup () {
  //game setup
  frog = loadImage("Frogger.png");
  size(800, 600); //size of screen
  smooth();
  for (int i = 0; i < cars.length; i ++ ) {
    cars[i] = new Car(0, i, random(-5, 5));
    for (int j = 0; j < logs.length; j ++ ) {
      logs[j] = new Log(0, j, random(-5, 5)); //determines color and speed of logs. Same code as the cars used, adjusted for the logs.
    }
    // determines starting position frog
    frogx = width/2 - 20;
    frogy = height - 40;
  }
  //title screen setup
  back = loadImage("Untitled.png");  
  background(back);
  noStroke();
  F = loadImage("Frogger.png");
  textMode(CENTER);
  for (int i = 0; i < count; i++) {  
    sz[i] = 30;         
    loc[i] = new PVector(random(sz[i], width-sz[i]), random(sz[i], height-sz[i])); 
    vel[i] = new PVector(0, random(0, 5));       
    acc[i] = new PVector(0, 0);
  }
}

void draw() {
  //if game isn't running display title screen
  if (gamerun == false) {
    background(back);                               /////////////////////////
    textSize(80);                                                            //////////////////////
    fill(#71B709);
    text("'Hop Off'", 235, 65 );                    //Upload the image for the main menu background 
    textSize(25);                                                            //////////////////////
    fill(#E31502);                                 /////////////////////////
    text("C.J.S. Industries", 0, 578);
    fill(0);
    text("Click To Start", 575, 400);
    noStroke();
    for (int i = 0; i < count; i++) {                     /////////////////
      vel[i].add(acc[i]);
      loc[i].add(vel[i]);
      for (int j = 0; j < count; j++) {
        if (i!=j) {
          if (loc[i].dist(loc[j]) < sz[i]/2 + sz[j]/2) {
            if (loc[i].x < loc[j].x) {   
              vel[i].x = -abs(vel[i].x);
              vel[j].x = abs(vel[j].x);
            } else {
              vel[i].x = abs(vel[i].x);                      
              vel[j].x = -abs(vel[j].x);            //giving the logs and cars velocity do they can move... One log goes in the opposite direction 
            }
            if (loc[i].y < loc[j].y) {   
              vel[i].y = -abs(vel[i].y);
              vel[j].y = abs(vel[j].y);
            } else {
              vel[i].y = abs(vel[i].y);
              vel[j].y = -abs(vel[j].y);
            }
          }
        }
      }
      image(F, loc[i].x, loc[i].y, sz[i], sz[i]);
      if (loc[i].x + sz[i]/2 > width || loc[i].x - sz[i]/2 < 0) {
        vel[i].x *= -1;
      }
      if (loc[i].y + sz[i]/2 > height || loc[i].y - sz[i]/2 < 0) {
        vel[i].y *= -1;
      }
    }
  }
  //if game is running play game
  if (gamerun == true) {          
    background (255);  // drawing of lanes and water
    fill (64, 112, 152); // Water
    noStroke ();
    rect (0, 0, 800, 300);
    fill (62, 62, 62); // Road
    noStroke ();
    rect (0, 300, 800, 300);
    fill (53, 93, 67); // top grass "safe zone"
    noStroke ();
    rect (0, 0, 800, 50);
    fill (53, 93, 67); // middle grass
    noStroke ();
    rect (0, 270, 800, 50);
    fill (53, 93, 67); // bottom grass
    noStroke ();
    rect (0, 550, 800, 50);
    fill (34, 77, 43); //start of outlines for safe zones
    noStroke ();
    rect (0, 0, 800, 10);
    fill(255);
    textSize(25);
    text("Life " + life, 20, 585);
    text("Score: " + score, 650, 585);
    if (life == 0) { 
      fill(0);
    }
    for (int i = 0; i < logs.length; i ++ ) {   // display for the logs
      logs[i].move();
      logs[i].display();
    }
    if (frogy > 40  && frogy < 269) {        // gives paramters for water collision should frog not make it onto a log
      boolean safe = false;               //  if frog hits water, frog gets killed and returns to beginning
      for (int i = 0; i < logs.length; i++) {
        if (logs[i].collides()) { 
          safe = true;
        }
      }
      if (safe == false) {   // Resets the frog to it's normal position if it is killed, as well as subtracts one from the life counter
        frogx = width/2 - 20;
        frogy = height - 40;
        life --;
      }
    }
    if (frogy < 0) {
      score ++;
      frogx = width/2 - 20;
      frogy = height - 40;
    }
    //draw frog
    fill (140, 227, 169);
    image(frog, frogx, frogy, 40, 40);
    for (int i = 0; i < cars.length; i ++ ) {
      cars[i].move();
      cars[i].display();
    }
    if (frogx < 0 || frogx + 40 > width || frogy + 40 > height) {
      frogx = width/2 - 20;
      frogy = height - 40;
    }
    if (life < 1) {
      background(0, 0, 0);        // everytime you use up your 9 lives, the screen becomes black and the game ends 
      textSize(100);
      fill(255, 255, 255);
      text("GAME OVER", 115, 200);
      fill(255, 255, 255);
      textSize(60);
      text("Score " + score, 280, 300);
      textSize(30);
      fill(255, 255, 255);
      text("Press Shift to Play again!", 210, 400); // once the game ends, press the shift button to restart 
    }
  }
}

void mousePressed() {
  gamerun = true;
}

// control frog; mapping arrow keys to move the frog in the corrosponding direction
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      frogy = frogy - 47;
    }
    if (keyCode == DOWN) {
      frogy = frogy + 47;
    }
    if (keyCode == LEFT) {
      frogx = frogx - 47;
    }
    if (keyCode == RIGHT) {
      frogx = frogx + 47;
    }
    if (keyCode == SHIFT) {
      life = 10;
      score = 0;
      frogx = width/2 - 20;
      frogy = height - 40;
    }
  }
}

