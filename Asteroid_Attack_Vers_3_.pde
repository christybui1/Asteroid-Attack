//import processing.serial.*;
//Serial arduino;

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*; //used the minim library for sound 


//declaring all variables
PImage photo; //Declaring background image
Player p1; //declaring my variables in player class
PImage bulletImage; 
PImage playerImage;
ArrayList<Bullet> bulletList; //declaring bullet class
PImage meteorImage;
ArrayList<Meteor> meteors;
Minim minim; //declare minim variable to initialize in setup
AudioSample shootingSound; //declare audio with the variable shootingSound
boolean gameStarted = false;
boolean GameOver = false;
boolean win = false;  //keeps track of whether player has won game
int startTime;
int score = 0;
int elapsedTime = 0; //declared the elapsedTime variable
boolean welcomePageToggle = true;
//Serial myPort; //Create object from serial class


//function to toggle between the welcome page and game over page
void togglePage() {
   welcomePageToggle = !welcomePageToggle; 
}

void drawWelcomePage() {
 //display a welcome message
 textSize(30);
 textAlign(CENTER);
 fill(180);
 text("Asteroid Attack!\n" +
 "You are on a 10 second mission to shoot as many asteroids as you can!\n" +
 "Instructions: \n" +
 "-Use joystick to move left and right\n" +
  "-Press X to start game\n" +
 "-Press space bar to shoot\n" +
 "A score of at least 50 will save Planet Earth", width/2, height/2 - 150);
}


void checkGameOver(){
  if (score >= 50) {
    text("Congrats! You've saved Earth!", width/2, height/2);
    text("Your score: " + score, width/2, height/2 + 50);
  } else {
    text("You lost the game and Earth has perished.", width/2, height/2);
    text("Your score: " + score, width/2, height/2 + 50);
  }
}


void setup() {
  size(900, 700);
  
  //initializing all variables
    photo = loadImage("grid.jpeg"); //Loading background image into program 
    p1 = new Player(width/2, height-50, 40, 40 ); //initialize my variables in Player class
    bulletList = new ArrayList<Bullet>(); //have to create an array list to fire multiple bullets
    bulletImage = loadImage("laserGreen.png"); //load the bullet image
    playerImage = loadImage("player.png"); //load player image
    meteorImage = loadImage ("meteorSmall.png"); //load meteor image
    meteors = new ArrayList<Meteor>(); //loading the meteor array list
    meteors.add(new Meteor(0, 0, 0, null)); //add atleast one meteor to the list 
    minim = new Minim(this); //connecting minim to our sketch
    shootingSound = minim.loadSample("shoot.wav"); //loading shootingSound variable

    
 // Create 100 Meteor objects with random positions at the top of the screen
  if (meteorImage != null) {
  for (int i = 0; i < 97; i++) {
    if (meteorImage != null) {
    meteors.add(new Meteor(random(width), random(-500, -100), random(2,5), meteorImage));
   }
  } 
 }

 //arduino = new Serial(this, Serial.list()[0](9600);
}

void draw() {
  image(photo, 0, 0);
  
  p1.display(); //render my player class
  p1.move(); //render player to move 

//for loop that updates position of all bullets
for (Bullet aBullet : bulletList){
 aBullet.display();
 aBullet.move();
}

if (gameStarted){
//for loop to move all meteor objects
for (int i = 1; i < meteors.size(); i++) {
  meteors.get(i).display();
  meteors.get(i).move();
 
 //check if meteor is off screen and reset its position
 if (meteors.get(i).y > height) {
   meteors.get(i).y = random(-500, -50);
   meteors.get(i).x = random(width);
   meteors.get(i).speed = random(2, 5);
  }
 }
  
 //Check for collision between bullets and meteors
 for (int i = 0; i < bulletList.size(); i++){
   Bullet bullet = bulletList.get(i);
   for (int j = 0; j < meteors.size(); j++){ 
      Meteor meteor = meteors.get(j);
   if (bullet.getX() < meteor.getX() + meteor.getWidth() &&
      bullet.getX() + bullet.getWidth() > meteor.getX () &&
     bullet.getY() < meteor.getY() + meteor.getHeight() &&
     bullet.getY() + bullet.getHeight() > meteor.getY()){
    //Collision detected, remove bullet and meteor
    bulletList.remove(i);
    meteors.remove(j);
    //adding score variable. every time player shoots meteor, increment score by one
    score++; 
    print(score);
  }
 }
}

//Measure elapsed time since game started
int elapsedTime = millis() - startTime;
//End game after 10 seconds
  if (elapsedTime/1000 <= 10) {
    //print(elapsedTime/1000);
    //print(GameOver);
  }
  else {
    //print(elapsedTime/1000);
    GameOver = true; 
    welcomePageToggle = false;
    gameStarted = false;
    //print(GameOver);
  }  
}

 //If game toggle page is false choose between welcome page and game over page 
 if (!gameStarted) {
   //if welcome page is true then show welcome page
    if (welcomePageToggle) {
       drawWelcomePage(); 
    }
     else {
   checkGameOver(); 
   print("Game over");
     }
 } else { 
 // Game is started 
}
//player.update();
//player.draw();

//if (arduino.available() > 0){
//   String joystickData = arduino.readStringUntil('\n');
//    if (joystick Data != null){
//     joystickData = joystickData.trim();
//     String[] data = split(joystickData, ',');
//     if (data.length ==2){
//       float x = map(float(data[0]), 0, 1023, -50, 50);
//       playerX += x * playerSpeed;
//    }
//  }
//}

}


void keyPressed(){  //this declares the player to move 
  if (key == 'a'){
    p1.isMovingLeft = true;
  }
 
  if (key == 'd'){
    p1.isMovingRight = true;
  }
  
  if (key == ' '){
    bulletList.add(new Bullet(p1.x, p1.y, bulletImage)); //this puts the bullet at players position
    shootingSound.trigger(); //play shooting sound
  }   
  
  //this key is how to start the game
  if (key == 'x'){
   gameStarted = true; 
   startTime = millis();
  }
}

 
void keyReleased(){  //this declares player to stay still when keys aren't pressed
  if (key == 'a'){
    p1.isMovingLeft = false;
  }
  
  if (key == 'd'){
    p1.isMovingRight = false;
  }
}  

 
