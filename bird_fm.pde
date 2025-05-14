import processing.data.Table;
import processing.sound.*;

boolean isPlaying = false;
int numBirds = 20;            
int numSounds = 10;  
SoundFile[][] birdSounds;             
Bird[] allBirds = new Bird[numBirds];
int[] birdActivity = new int[numBirds];
int[][] startTime = new int[numBirds][numSounds];
boolean[][] soundsPlayed = new boolean[numBirds][numSounds];  
int currentSeason;  // 0 = spring, 1 = summer, 2 = autumn, 3 = winter
int currentTime;    // 0 = morning, 1 = day, 2 = evening, 3 = night
int playStartTime = 0;
int PLAY_DURATION = 300000; // 5 minutes in 


void setup() {
  fullScreen();   
  textSize(40);   // Adjust text size for visibility
  textAlign(CENTER, CENTER);
  
  birdSounds = new SoundFile[numBirds][numSounds]; 
  
  // Load all bird sounds into an array of soundFiles
  for (int i = 0; i < numBirds; i++) {
    for (int h = 0; h < numSounds; h++) {
      String filePath = "/soundLibrary/bird" + (i) + "/" + (h + 1) + ".mp3";
      birdSounds[i][h] = new SoundFile(this, filePath);
      startTime[i][h] = int(random(0,300000));  // Assign a start time to each sound
      soundsPlayed[i][h] = false;
    }
  }   
}

void draw() {
  
  PImage bg = loadImage("data/bird-fm-bg.png");   
  image(bg, 0, 0, width, height);

  drawButton(435, 890, "Spring", currentSeason == 0);
  drawButton(735, 890, "Summer", currentSeason == 1);
  drawButton(1035, 890, "Fall", currentSeason == 2);
  drawButton(1335, 890, "Winter", currentSeason == 3);
  
  drawButton(585, 970, "Morning", currentTime == 0);
  drawButton(885, 970, "Noon", currentTime == 1);
  drawButton(1135, 970, "Evening", currentTime == 2);
  drawButton(1435, 970, "Night", currentTime == 3);
  
  drawCircleButton(140, 930, true, isPlaying == true);
  drawCircleButton(1725, 930, false, isPlaying == false);
  
  if (isPlaying) {
  int elapsed = millis() - playStartTime;

  for (int i = 0; i < numBirds; i++) {             
    for (int h = 0; h < birdActivity[i]; h++) {    
      if (elapsed >= startTime[i][h] && !soundsPlayed[i][h]) {
        birdSounds[i][h].play(random(0.7, 1.5), random(-0.8, 0.8), random(0.2, 1));    
        soundsPlayed[i][h] = true;
      }
    }
  }

  // If time is up, restart playback automatically
  if (elapsed > PLAY_DURATION) {
    stopSoundscape();
    playSoundscape();
  }
}

}

void keyPressed() {
  if (key == 'p' || key == 'P') {
    playSoundscape();
  }
  if (key == 's' || key == 'S') {
    stopSoundscape();
  }
}

void playSoundscape() {
  for (int i = 0; i < numBirds; i++) {
    allBirds[i] = new Bird(i); 
    birdActivity[i] = allBirds[i].getActivityLevel(currentTime, currentSeason);
    
    for (int h = 0; h < numSounds; h++) {
      startTime[i][h] = int(random(0, PLAY_DURATION)); // reset timing
      soundsPlayed[i][h] = false; // reset play flags
    }
  }
  
  isPlaying = true;
  playStartTime = millis(); // mark start time
}


void stopSoundscape() {
  // Stop all currently playing sounds
  for (int i = 0; i < numBirds; i++) {
    for (int h = 0; h < numSounds; h++) {
      if (birdSounds[i][h].isPlaying()) {
        birdSounds[i][h].stop();
      }
      soundsPlayed[i][h] = false;  // Reset flags
      startTime[i][h] = 0;         // Reset start times (or keep random if you prefer)
    }
    birdActivity[i] = 0;           // Reset activity levels
  }
  
  isPlaying = false;               // Stop the playback state
}



// Function to draw each button
void drawButton(float x, float y, String label, boolean active) {
  rectMode(CENTER);

  if (active) {
    fill(42, 34, 22);     
  } else {
    fill(62, 53, 38);
  }
  
  // Draw the button shape
  rect(x, y, 300, 80, 0); 

  // Draw the label text
  noStroke();   
  fill(160,141,111);
  textAlign(CENTER, CENTER);
  text(label, x, y);  
}

void drawCircleButton(float x, float y, boolean play, boolean active) {

  if (active) {
    fill(42, 34, 22);     
  } else {
    fill(62, 53, 38);
  }
  
  noStroke();
  
  // Draw the button shape
  circle(x, y, 160); 

  // Draw the label icon
  if (play) {
    fill(160,141,111);
    triangle(x-15,y-26,x-15,y+26,x+30,y);
  } else {
    fill(160,141,111);
    rect(x,y,45,45,0);
  }
}


// Handle mouse clicks to select buttons
void mousePressed() {
  if (isButtonClicked(435,890)) {
    stopSoundscape();
    currentSeason = 0;
    playSoundscape();    
  } else if (isButtonClicked(735,890)) {
    stopSoundscape();
    currentSeason = 1;
    playSoundscape();    
  } else if (isButtonClicked(1035,890)) {
    stopSoundscape();
    currentSeason = 2;
    playSoundscape();    
  } else if (isButtonClicked(1335,890)) {
    stopSoundscape();
    currentSeason = 3;
    playSoundscape();    
  } 
    
  if (isButtonClicked(585, 970)) {
    stopSoundscape();
    currentTime = 0;
    playSoundscape();    
  } else if (isButtonClicked(885, 970)) {
    stopSoundscape();
    currentTime = 1;
    playSoundscape();    
  } else if (isButtonClicked(1185, 970)) {
    stopSoundscape();
    currentTime = 2;
    playSoundscape();    
  } else if (isButtonClicked(1485, 970)) {
    stopSoundscape();
    currentTime = 3;
    playSoundscape();    
  } 
  
  if (isCircleButtonClicked(140, 930)) playSoundscape();
  else if (isCircleButtonClicked(1725, 930)) stopSoundscape();
}

// Function to detect if a button is clicked based on its center coordinates
boolean isButtonClicked(float x, float y) {
  return mouseX > x - 150 && mouseX < x + 150 && mouseY > y - 40 && mouseY < y + 40;
}

boolean isCircleButtonClicked(float x, float y) {
  return mouseX > x - 80 && mouseX < x + 80 && mouseY > y - 80 && mouseY < y + 80;
}
