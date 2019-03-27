PImage bg, soil, life, soldier, cabbage;
PImage title, startNormal, startHovered;
PImage gameover, restartNormal, restartHovered;
PImage groundhogIdle, groundhogDown, groundhogLeft, groundhogRight;


final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_LOSE = 2;
int state = GAME_START;

int soilderDeep = floor(random(3)) + 3 ;
int soilderX = -50;
int soilderXSpeed = 5;

int cabbageX =(floor(random(7)))*80;
int cabbageY =(floor(random(3))+2)*80;
boolean cabbagegrow = true;

int lifescore = 2;
int heartFirst = 10;
int heartPlus = 70;

int groundhogMove;
int groundhogX = 320;
int groundhogY = 80;
int groundhogNewX, groundhogNewY;
boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

void setup() {
	size(640, 480, P2D);
  bg = loadImage("img/bg.jpg");
  soil = loadImage("img/soil.png");
  life = loadImage("img/life.png");
  soldier = loadImage("img/soldier.png");
  cabbage = loadImage("img/cabbage.png");
  title = loadImage("img/title.jpg");
  startNormal = loadImage("img/startNormal.png");
  startHovered = loadImage("img/startHovered.png");
  gameover = loadImage("img/gameover.jpg");
  restartNormal = loadImage("img/restartNormal.png");
  restartHovered = loadImage("img/restartHovered.png");
  groundhogIdle = loadImage("img/groundhogIdle.png");
  groundhogDown = loadImage("img/groundhogDown.png");
  groundhogLeft = loadImage("img/groundhogLeft.png");
  groundhogRight = loadImage("img/groundhogRight.png");
}

void draw() {
    switch (state){
    case GAME_START:
        image(title, 0,0);
        image(startNormal, 248,360);
        if (mouseX > 248 && mouseX < 392
            && mouseY > 360 && mouseY < 420){
          image(startHovered, 248,360);
          if (mousePressed){
            state = GAME_RUN;
          }
        }
      break;
      
    case GAME_RUN:
        image(bg, 0,0);
        image(soil, 0,160);
    //grass
        noStroke(); 
        colorMode( RGB );
        fill(124,204,5);
        rect (0,145,640,15);
    //sun1
        fill(255, 255, 0);
        ellipse(590,50,130,130);
        fill(253, 184, 19);
        ellipse(590,50,120,120);
    //groundhog
        image(groundhogIdle ,groundhogX,groundhogY);
    //soilder
        soilderX += soilderXSpeed;
        image(soldier ,soilderX,(soilderDeep*80));
        if (soilderX > 640){
          soilderX = -50;
          soilderDeep = floor(random(3)) + 2 ;
        }
    //cabbage
        if (cabbagegrow){
          image(cabbage ,cabbageX,cabbageY);
          if (cabbageX < groundhogX+80 && cabbageX+80 > groundhogX &&
              cabbageY < groundhogY+80 && (cabbageY)+80 > groundhogY){
            cabbagegrow = false;
          }
        }else{
            lifescore += 1;
            cabbageX =(floor(random(7)))*80;
            cabbageY =(floor(random(3))+2)*80;
            cabbagegrow = true;
         }
    //hit
        if (soilderX < groundhogX+80 && soilderX+80 > groundhogX &&
            (soilderDeep*80) < groundhogY+80 && (soilderDeep*80)+80 > groundhogY){
          lifescore -= 1;
          groundhogX = 320;
          groundhogY = 80;
        }
    //heart
         if (lifescore == 0){
            state = GAME_LOSE;
        }if (lifescore > 0){
           image(life, heartFirst,10);
        }if (lifescore > 1){
           image(life, heartFirst+(heartPlus)*1,10);
        }if (lifescore > 2){
           image(life, heartFirst+(heartPlus)*2,10);
        }if (lifescore > 3){
           image(life, heartFirst+(heartPlus)*3,10);
        }if (lifescore > 4){
           image(life, heartFirst+(heartPlus)*4,10);
        }if (lifescore > 5){
           lifescore = 2;
           soilderXSpeed += 2;
        }
      break;

    case GAME_LOSE:
        image(gameover, 0,0);
        image(restartNormal, 248,360);
        if (mouseX > 248 && mouseX < 392 &&
            mouseY > 360 && mouseY < 420){
          image(restartHovered, 248,360);
          if (mousePressed){
            state = GAME_RUN;
            lifescore = 2;
            groundhogX = 320;
            groundhogY = 80;
            soilderX = -50;
            soilderXSpeed = 5;
          }
        }
      break;
  }
}

void keyPressed() {
  if (key == CODED) {
    switch (keyCode) {
      case UP:
        upPressed = true;
        if (upPressed){
          if (groundhogY > 80){
            groundhogY -= 80;
          }
          upPressed = false;
        }
        break;
      case DOWN:
        downPressed = true;
        if (downPressed){
          if (groundhogY < 400){
          groundhogY += 80;
          }
          leftPressed = false;
        }
        break;
      case LEFT:
        leftPressed = true;
        if (leftPressed){
          if (groundhogX > 0){
          groundhogX -= 80;
          }
          leftPressed = false;
        }
        break;
      case RIGHT:
        rightPressed = true;
        if (rightPressed){
          if (groundhogX < 560){
          groundhogX += 80;
          }
          rightPressed = false;
        }
        break;
    }
  }
}
