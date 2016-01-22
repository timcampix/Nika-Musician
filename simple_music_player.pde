import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*; //<--plays music and metadata
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Minim minim;
AudioPlayer player; //song object
AudioMetaData meta;
FFT fft;

void setup() {
  size(512, 500);

  minim=new Minim (this);
  //b from loadFile(a,b) ensures buffer size will stay consistent with screensize
  player=minim.loadFile("one ok rock-karasu.mp3", 512);
  meta=player.getMetaData();
  player.play();

  //FFT
/*IllegalArgumentException: FFT: timeSize must be a power of two
Solution:
*/
  fft = new FFT(player.bufferSize(), player.sampleRate());
}

int ys=50;
int yi=15;

void draw() {
  background(0);

  //FFT
  fft.forward(player.mix);
  stroke(255, 0, 0, 128);
  //draws as series of vertical lines
  for (int i=0; i<fft.specSize (); i++) {
     line(i,height,i,height-fft.getBand(i)*10);
  }


  /*
      SONG INFO
   */
  int y=ys;
  textSize(32);
  String s="Music Player";
  text(s, 100, 35);
  textSize(15);
  text("Filename: "+meta.fileName(), 5, y);
  text("Length (in millisecond): "+meta.length(), 5, y+=yi);
  text("Title: "+meta.title(), 5, y+=yi);
  text("Track: "+meta.track(), 5, y+=yi);
  text("Date: "+meta.date(), 5, y+=yi);
  text("Encoded: "+meta.encoded(), 5, y+=yi);

  /*
  Waveform
   */

  stroke(255);
  for (int i=0; i<player.bufferSize ()-1; i++) {
    line(i, 50+player.left.get(i)*50, i+1, 50+player.left.get(i+1)*50);
    println ("Left : "+player.left.get(i));
    line(i, 150+player.right.get(i)*50, i+1, 150+player.right.get(i+1)*50);
    println("Right : "+player.right.get(i));
    line(i, 200+player.mix.get(i)*50, i+1, 200+player.mix.get(i+1)*50); 
    println("Mix : "+player.mix.get(i));
  }
  

}

