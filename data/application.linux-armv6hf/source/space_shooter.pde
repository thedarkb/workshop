PImage bg1;
PImage sprite;
PImage rock;
int pX = 224;
int bgC = 0;
int movSpeed = 10;
float pscore = 0;
boolean[] live = {false, false, false, false, false, false, false, false, false, false};
int[] positions ={-50,-50,-50,-50,-50,-50,-50,-50,-50,-50};
float enSpd =0;
boolean pState = true;


void setup () {
  bg1 = loadImage("bg.jpg");
  sprite = loadImage("ship.png");
  rock = loadImage("rock.png");
  size(512,512);
  textSize(20);
  pState = true;
}

void draw () {
  if (pState == true) {
    image(bg1, 0, bgC, width,height);
    image(bg1, 0, bgC-512, width, height);
  
    if (keyPressed && (keyCode==LEFT) && (pX>22)) {
      pX-=movSpeed;
    } else if (keyPressed && (keyCode==RIGHT) && (pX<426)) {
      pX+=movSpeed;
    }    
    image(sprite, pX, 438, 64, 64);
    
    for (int i=0; i<10; i++) {
      if (!live[i]) {
        if (random(0,1000) < 10) {
          live[i] = true; 
        }
      }
    }
    
    for (int i=0; i<10;i++) {
      if (live[i]){image(rock,i*50,positions[i],50,50);}
    }
    
    for (int i=0; i<10; i++) {
      if (live[i]) {
        positions[i]+=10;
        if (positions[i]>512) {positions[i]=-50;live[i]=false;}
        if (positions[i]>448 && (i*50)>(pX-32) && (i*50)<(pX+32)) {pState=false;}
      }
    }
    
    text(pscore, 0, 20);
    pscore++;
    bgC++;
    
    if (bgC>=512) {bgC=0;}
    
  } else if (!(keyPressed && key == ' ')) {
    background(0);
    text("Game Over!", 126,256);
    text("You scored: "+pscore, 126, 320);
    text("Press space to try again.", 126, 192);
  } else {
    pState = true;
    for (int i=0; i<10; i++) {
      positions[i]=-50;
      live[i]=false;
    }
    pX = 224;
  }
}
