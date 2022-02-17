import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
AudioBuffer ab;
AudioInput ai;
AudioPlayer ap;


float average = 0;
float lerpedA = average;
float[] g = new float[500];

float thetaX;
float thetaY;



void setup()
{
  size(500,500,P3D);
//  fullScreen();
//  background(0);
minim = new Minim(this);
//ai = minim.getLineIn(Minim.MONO,1024,44100,16); //(audio type,frame size, sample rate, bit)
//ab = ai.mix;
ap = minim.loadFile("Caravan Palace - Black Betty_160k.mp3",width);
ap.play();
ab = ap.mix;
colorMode(HSB);
}



void draw()
{
 background(0);
 float sum = 0;
  

 
 for(int i = 0; i < g.length; i ++){
   float Color = map(i,0,width,0,255);
//   float lerpedG = ab.get(i);
  g[i] = lerp(g[i],ab.get(i),0.09);
   stroke(Color,255,255);
  strokeWeight(2);
  line(i,(g[i] * height) ,i,(g[i] * height/2));
  line(i,height+(g[i] * height) ,i,height+(g[i] * height/2));
 // line(i,height/2-(g[i] * height/2) ,height/2+(g[i] * height/2), i);
  sum += abs(ab.get(i));
 }
 for(int i = 0; i < 500; i ++){
     float Color = map(i,0,height,0,255);
        stroke(Color,255,255);
  strokeWeight(2);
   g[i] = lerp(g[i],ab.get(i),0.09);
     line(0-(g[i] * height),i ,0-(g[i] * height/2),i);
    line(width+(g[i] * height),i ,width+(g[i] * height/2),i);
 }
//println(lerpedG);

// noStroke();
 average = sum/ab.size();
 stroke((average)*666,125,200);
 noFill();
lerpedA = lerp(lerpedA,average,0.09);


pushMatrix();
translate(width/2, height/2,0);
 rotateX(thetaX);
 rotateY(thetaY);
 box(lerpedA*1000);
 popMatrix();

thetaX += 0.1;
thetaY += 0.1;
//   println(average*666);

}
