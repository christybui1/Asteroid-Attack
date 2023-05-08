class Bullet {
 
  //variables
  int x;
  int y;
  int d;
  int speed;
  PImage bulletImage; //add a PImage variable 

  //methods that return position and size of an object
  public float getX(){
   return x; 
  }
  public float getY(){
   return y; 
  }
  public float getWidth() {
   return bulletImage.width; 
  }
  public float getHeight(){
   return bulletImage.height; 
  }
  
  //constuctor (meant to initialize all aforementioned variables)
  Bullet(int startingX, int startingY, PImage bulletImage){ //parameters = are variables listed as part of a method declartion
    x = startingX;
    y = startingY;
    d = 10;
    speed = 15;
    this.bulletImage = bulletImage; // load the image in the constructor
  }
  
  //functions
  void display(){
   image(bulletImage, x, y, d, d); //display the bullet image
  }
  
  void move(){
    y -= speed;  // y = y - speed
  }
  
}
