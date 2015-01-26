class Car {
  float xpos;                      // Declare variables 
  float ypos;
  float xspeed;
   Car(float xpos_, float ypos_, float xspeed_) {
    xpos = xpos_;
    ypos = 508-(ypos_*45);
    xspeed = xspeed_;
  }
   void display() {
    noStroke();
    fill(200,49,32);
    rect(xpos,ypos,100,40);
  }                                                                              // Draw the rectangle 
   void move() {
    xpos = xpos + xspeed;
    if (xpos > width) {         ///////////////////////////////////////////////////
      xpos = -100;                                      ////////////////////////////>>>>>Some of the cars go to the left and some go to the the right 
    }                           ///////////////////////////////////////////////////
    if (xpos < -100){            ///////////////////////////////////////////////
      xpos = width;
    }
     //colision detection of frog and car
    if((frogy + 20 > ypos && frogy + 20 < ypos + 40 && frogx + 40 > xpos && frogx < xpos + 100)) {
      frogx = 375;
      frogy = 560;
      life = life - 1;                          //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Subtract life from the graph every time the frog gets hit by the car 
     }
  }
}
