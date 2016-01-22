function preload(){
  sound = loadSound('one ok rock-karasu.mp3');
}

function setup(){
  createCanvas(1390,600);
  sound.amp(0);
  sound.loop();
  fft = new p5.FFT();
}

function draw(){
  background(0);

  var spectrum = fft.analyze(); //returns an array of amplitude values (between 0 and 255) across the frequency spectrum. Length is equal to FFT bins (1024 by default)
  noStroke();
  fill(0,255,0); // spectrum is green
  for (var i = 0; i< spectrum.length; i++){
    var x = map(i, 0, spectrum.length, 0, width);
    var h = -height + map(spectrum[i], 0, 255, height, 0);
    rect(x*1.5, height, width*1.5 / spectrum.length, h )//multipled to stretch across screen
  }

  var waveform = fft.waveform();
  noFill();
  beginShape();
  stroke(255,0,0); // waveform is red
  strokeWeight(1);
  for (var i = 0; i< waveform.length; i++){
    var x = map(i, 0, waveform.length, 0, width);
    var y = map( waveform[i], -1, 1, 0, height);
    vertex(x,y);
  }
  endShape();

  isMouseOverCanvas();
}

// fade sound if mouse is over canvas
function isMouseOverCanvas() {
  var mX = mouseX, mY = mouseY;
  if (mX > 0 && mX < width && mY < height && mY > 0) {
      sound.amp(0.5, 0.2);
  } else {
    sound.amp(0, 0.2);
  }
}




/*
function setup() {
      createCanvas(200, 200);
      noStroke();
    }

    function draw() {
      background(204);
      var x1 = map(mouseX, 0, width, 50, 70);
      ellipse(x1, 75, 50, 50);
      var x2 = map(mouseX, 0, width, 0, 200);
      ellipse(x2, 125, 50, 50);
    }


function setup(){
  createCanvas(500,500);
  noStroke();
}
function draw(){
  background(0);
  var locX=map(mouseX,0,width,0,255);
  var c=color(locX,locX,0);
  fill(c);
  rect(0,255,500,50);
}
*/