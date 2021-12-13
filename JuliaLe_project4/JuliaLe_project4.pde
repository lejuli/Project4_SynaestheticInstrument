import ddf.minim.analysis.*;
import ddf.minim.*;
import ddf.minim.signals.*;
 
Minim minim;
AudioOutput out;
PImage coral, dpurp,green, lblue, lgreen, lpink, lyell, mag, navy, org, pink, purple, red,teal, vert, vio, yellow;

void setup()
{
  size(800, 600, P2D);
  minim = new Minim(this);
  out = minim.getLineOut(Minim.STEREO);
  coral=loadImage("coral.jpg");
  dpurp=loadImage("dpurp.jpg");
  dpurp.resize(800,600);
  green=loadImage("green.jpg");
  lblue=loadImage("lblue.jpg");
  lgreen=loadImage("lgreen.jpg");
  lpink=loadImage("lpink.jpg");
  lyell=loadImage("lyell.jpg");
  mag=loadImage("mag.jpg");
  navy=loadImage("navy.jpg");
  org=loadImage("org.jpg");
  pink=loadImage("pink.jpg");
   pink.resize(800,600);
  purple=loadImage("purple.jpg");
  purple.resize(800,600);
  red=loadImage("red.jpg");
  red.resize(800,600);
  teal=loadImage("teal.jpg");
  vert=loadImage("vert.jpg");
  vio=loadImage("vio.jpg");
  yellow=loadImage("yellow.jpg");
}
 
void draw()
{
  background(0);
   switch(key){
       case 'z': image(coral, 0,0);break;
       case 's': image(dpurp, 0,0);break;
       case 'x':  image(green, 0,0); break;
       case 'd':  image(lblue, 0,0); break;
       case 'c':  image(lgreen, 0,0); break;
       case 'v':  image(lpink, 0,0); break;
       case 'g':  image(lyell, 0,0); break;
       case 'b':  image(mag, 0,0); break;
       case 'h':  image(navy, 0,0); break;
       case 'n':  image(org, 0,0); break;
       case 'j': image(pink, 0,0); break;
       case 'm': image(purple, 0,0); break;
       case ',': image(red, 0,0); break;
       case 'l': image(teal, 0,0); break;
       case '.': image(vert, 0,0); break;
       case ';': image(vio, 0,0); break;
       case '/': image(yellow, 0,0); break;
       
   }
}
 
void keyPressed()
{
  SineWave mySine;
  MyNote newNote;

  float pitch = 0;
  switch(key) {
    case 'z': pitch = 262; break;
    case 's': pitch = 277; break;
    case 'x': pitch = 294; break;
    case 'd': pitch = 311; break;
    case 'c': pitch = 330; break;
    case 'v': pitch = 349; break;
    case 'g': pitch = 370; break;
    case 'b': pitch = 392; break;
    case 'h': pitch = 415; break;
    case 'n': pitch = 440; break;
    case 'j': pitch = 466; break;
    case 'm': pitch = 494; break;
    case ',': pitch = 523; break;
    case 'l': pitch = 554; break;
    case '.': pitch = 587; break;
    case ';': pitch = 622; break;
    case '/': pitch = 659; break;
  }
  
   if (pitch > 0) {
      newNote = new MyNote(pitch, 0.2);
   }
}

void stop()
{
  out.close();
  minim.stop();
 
  super.stop();
}

class MyNote implements AudioSignal
{
     private float freq;
     private float level;
     private float alph;
     private SineWave sine;
     
     MyNote(float pitch, float amplitude)
     {
         freq = pitch;
         level = amplitude;
         sine = new SineWave(freq, level, out.sampleRate());
         alph = 0.9;
         out.addSignal(this);
     }

     void updateLevel()
     {
         level = level * alph;
         sine.setAmp(level);
         
         if (level < 0.01) {
             out.removeSignal(this);
         }
     }
     
     void generate(float [] samp)
     {
         sine.generate(samp);
         updateLevel();
     }
     
    void generate(float [] sampL, float [] sampR)
    {
        sine.generate(sampL, sampR);
        updateLevel();
    }

}
