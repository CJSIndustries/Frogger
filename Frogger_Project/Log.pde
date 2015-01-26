class Log {
  float xpos;                        // Declare variables for the log 
  float ypos;
  float xspeed;
  Log(float xpos_, float ypos_, float xspeed_) {
    xpos = xpos_;
    ypos = 230-(ypos_*45);
    xspeed = xspeed_;
  }
  void display() { //>>>>>>>>>>>>>>>>
    noStroke();        //>>>>>>>>>>>>>>>>>>>>>>      draw the logs 
    fill(93, 68, 13);// >>>>>>>>>>>>>>>
    rect(xpos, ypos, 120, 40); //>>>>>>>>>>>>         
  }
  void move() { //                        
    xpos = xpos + xspeed;
    if (xpos > width) {
      xpos = -120;              //         make some logs go to the left and some go to the right 
    }
    if (xpos < -120) {
      xpos = width;
    }
  }
  boolean collides() {
    if (frogy + 20 > ypos && frogy + 20 < ypos + 40 && frogx + 20 > xpos && frogx + 20 < xpos + 120) {
      frogx = frogx + xspeed;
      return true;                // if colkison is detected witht the log, subtract a life and restart from the start point 
    } else {
      life = life--;
      return false;
    }
  }
}
