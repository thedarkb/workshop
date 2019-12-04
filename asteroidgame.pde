PImage bg1; //background layer
PImage sprite; //the ship
PImage rock; //the rocks
int pX = 224; //the ship's position
int bgC = 0; //background scroll
int movSpeed = 10; //player movement speed
float pscore = 0; //player score
boolean[] live = {false, false, false, false, false, false, false, false, false, false}; //There are ten asteroids, this array keeps track of their statuses
int[] positions ={-50,-50,-50,-50,-50,-50,-50,-50,-50,-50}; //Keeps track of the positions of the asteroids.
boolean pState = true; //Keeps track of whether the player is alive or dead.
boolean title = true; //Keeps track of whether the title screen has been shown.
int difficulty; //the frequency at which the asteroids appear
float distance = 4000; //distance to cover before ending triggers
boolean win = false; //ending triggers if true
PImage base; //ending animation
int baseX = -512; //ending sprite position


void setup () {
  bg1 = loadImage("bg.jpg");
  sprite = loadImage("ship.png");
  rock = loadImage("rock.png");
  base = loadImage("greeble.jpg");
  size(512,512);
  textSize(20);
  pState = true;
}

void draw () {
  if (title) { //checks if the title screen should be shown.
    background(0);
    text("Control the ship with left and right.", 126,256);
    text ("Press space to begin.", 30,280);
    if (keyPressed && key == ' ') {title = false;difficulty=2000;} //Starts the game when the difficulty is selected.
  } else if (pState == true) { //checks if the player is alive
    image(bg1, 0, bgC-512, width, height); //The background image is drawn twice to give the illusion of a continuous background image
    image(bg1, 0, bgC, width,height);
    
    if (keyPressed && (keyCode==LEFT) && (pX>22)) { //I'm not happy with the way this works
      pX-=movSpeed;
    } else if (keyPressed && (keyCode==RIGHT) && (pX<426)) {
      pX+=movSpeed;
    }    
    image(sprite, pX, 438, 64, 64); //Draws player
    
    for (int i=0; i<10; i++) {
      if (!live[i]) {
        if (random(0,5000-pscore*1.3) < 10) { //Sets one of the asteroids in motion on if random number is less than ten.
          if (!(pscore > 3488)){live[i] = true;} 
        }
      }
    }
    
    for (int i=0; i<10;i++) {
      if (live[i]){image(rock,i*50,positions[i],50,50);} //Draws an asteroid's sprite only if it's in motion.
    }
    
    for (int i=0; i<10; i++) {
      if (live[i]) {
        positions[i]+=pscore/1000+10;
        if (positions[i]>448 && (i*50)>(pX-32) && (i*50)<(pX+32)) {pState=false;} //If an asteroid hits the player, it ends the game.
        if (positions[i]>512) {positions[i]=-50;live[i]=false;} //Stops asteroids that fall off the screen, then resets them to their initial position.
      }
    }
    if(pscore > 3500) {image(base,0,baseX,512,512);baseX++;}
    text((distance-pscore)+" AU from base.", 0, 20); //Draws the distance from the base in the top left corner.
    pscore++; //Increments score.
    if (distance-pscore < 1) {pState=false;win=true;}
    bgC++; //Moves background image
    if (bgC>=512) {bgC=0;} //Resets background animation when background is about to scroll off the screen.
    
  } else if (!(keyPressed && key == ' ')) { //awaits the player to press space to restart the game
    background(0);
    if (win) {
      text("You reached the base!", 126,256);
      //text("You scored: "+pscore, 126, 320);
    } else {
      text("Game Over!", 126,256);
      text("You scored: "+pscore, 126, 320);      
    }
    
    text("Press space to play again.", 126, 192);
  } else {
    pState = true; //Sets the player status back to "alive"
    for (int i=0; i<10; i++) {
      positions[i]=-50; //resets the position of all asteroids
      live[i]=false; //halts all asteroids in motion.
    }
    pX = 224; //resets player position
    pscore = 0; //resets score
    title = false; //returns to title screen
    baseX=-512;
    win = false;
  }
  }
