class Player {
  
  //variables
  int x;
  int y;
  int w;
  int h;
  boolean isMovingLeft; 
  boolean isMovingRight;
  int speed;
  PImage playerImage; //add a PImage variable 
  
  //constructor
  Player(int startingX, int startingY, int startingW, int startingH){
    x = startingX;
    y = startingY;
    w = startingW; 
    h = startingH;
    
    isMovingLeft = false; //=false; is so player is not moving at beginning of game
    isMovingRight = false;
    
    speed = 10;
    
    playerImage = loadImage("player.png");
     
  }
  
  //functions
  void display(){
    // draw image of player
   image(playerImage, x,y,w,h);
  }
  
  void move(){
    if (isMovingLeft == true){
      x -= speed; // x = x - speed;
  }
  
  if (isMovingRight == true){
   x += speed; // x = x + speed; 
  }
 }
 
 //void update () {
 //  if (arduino.available() > 0) {
 //    String joystickData = arduino.ReadStringUntil('\n');
 //    if (joystickData != null) {
 //      joystickData = joystickData.trim();
 //      String[] data = split(joystickData, ',');
 //      if (data.length == 2){
 //       float x = map(float(data[0]), 0, 1023, =-50, 50);
 //       this.x += x * this.speedl
 //      }
 //    }
 //  }
 
}
