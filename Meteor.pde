class Meteor {
  
  //variables
  float x;
  float y;
  float size;
  float speed;
  PImage meteorImage;
  
  //methods that return position and size of an object
  public float getX(){
   return x; 
  }
  public float getY() {
   return y;
  }
  public float getWidth() {
    if (meteorImage != null) {
   return meteorImage.width;
  } else {
    return 0;
  }
  }
  
  public float getHeight() {
    if (meteorImage != null){
    return meteorImage.height;
  } else {
    return 0;
  }
  }
  
  //constructor
    Meteor(float x, float y, float speed, PImage meteorImage) {
  this.x = x;
  this.y = y;
  this.size = random(20, 50);
  this.speed = speed;
  this.meteorImage = meteorImage;
  }


  //functions
  void display(){
    if (meteorImage != null)
   image(meteorImage, x, y, size, size);
  }
  
  void move() {
    y += speed/4;
    if (y > height) {
     y = random(-500, -50);
     x = random(width);
     speed = random(2, 5);
    }
 }
}
  
