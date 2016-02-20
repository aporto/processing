PImage garoaImg;
PImage  mask;

ArrayList <PImage>  exploImg  = new ArrayList();

class Gota { 
  int x;
  int y;
  int startY;
  int status;
  int subCounter;
  Boolean explodindo; 
  
  Gota(int x, int y) {
    this.x=x;
    this.y=y;
    this.status=0;    
    this.subCounter = 0;
  }
  
  void Down() {
      if (this.status == 0) { 
          this.y = this.y + 2;
      } else if (this.status < 1000) {
          this.subCounter++;
          if (this.subCounter > 0) {
              this.status++;
              this.subCounter = 0;
          }
          if (this.status == 4) {
              this.status = 1000;
          }
      }          
  }
  
  void Explode() {
      this.status = 1;
  }
}
 
ArrayList <Gota>  gotas  = new ArrayList();

void setup() {
    size(578, 800);    
    garoaImg = loadImage("garoa_sem_garoa_800.png");
    mask = loadImage("garoa_branco_800.png");  
    exploImg.add(loadImage("explo1.png"));
    exploImg.add(loadImage("explo2.png"));
    exploImg.add(loadImage("explo3.png"));
    exploImg.add(loadImage("explo4.png"));
  
    fill (0,255,0);
    noStroke();
    int x=0;
    int y=0;
    for (int i=1;i<1998;i++) {
        int k = y % 2;
        Gota gota = new Gota(x * 33 + k * 16 + 22, y * 33 - 3800);
        gotas.add (gota);
        x++;
        if (x > 16-k) {
            x = 0;
            y++;// = y + 33;
        }
    }  
}

void draw() {
    background(0, 104, 55);  
    fill (0,255,0);
  
    Gota gota;
    for (int i=1; i < gotas.size();i++) {
        gota = gotas.get(i);
        gota.Down();
        
        if (gota.y < 1) {
            continue;
        }
        
        int c1 = mask.get(gota.x + 5, gota.y + 5);    
        int c2 = mask.get(gota.x - 5, gota.y + 5);
        if ((c1 >= -1) || (c2 >= -1)) {
            if (gota.status == 0) {
                gota.Explode();
            }
        }
        if (gota.status == 0) {        
            ellipse (gota.x, gota.y, 12, 12);
        } else if (gota.status < 1000) {        
            image(exploImg.get(gota.status), gota.x-10, gota.y-5);
        }
    }
  
    image(garoaImg, 0, 0);  
    //saveFrame();
}