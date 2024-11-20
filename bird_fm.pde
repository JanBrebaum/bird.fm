import processing.data.Table;
import processing.sound.*;

boolean isPlaying = false;
int numBirds = 20;            
int numSounds = 10;  
SoundFile[][] birdSounds;             
Bird[] allBirds = new Bird[numBirds];
int[] birdActivity = new int[numBirds];
int[] randomNumbers = new int[numSounds];
int[][] startTime = new int[numBirds][numSounds];
boolean[][] soundsPlayed = new boolean[numBirds][numSounds];  
int currentSeason;  // 0 = spring, 1 = summer, 2 = autumn, 3 = winter
int currentTime;    // 0 = morning, 1 = day, 2 = evening, 3 = night

void setup() {
  fullScreen();   
  textSize(40);   // Adjust text size for visibility
  textAlign(CENTER, CENTER);
  
  birdSounds = new SoundFile[numBirds][]; 
  
  // Array with random numbers to randomize sound
  for (int i = 0; i < numSounds; i++){
    randomNumbers[i] = i + 1;
  }
  
  // Swap with random numbers in the array
  for (int i = 0; i < numSounds; i++) {
    int j = int(random(numSounds));
    int k = randomNumbers[i];
    randomNumbers[i] = randomNumbers[j];
    randomNumbers[j] = k;
  }
  
  // Load all bird sounds into an array of soundFiles
  for (int i = 0; i < numBirds; i++) {
    birdSounds[i] = new SoundFile[numSounds]; 

    
    for (int h = 0; h < numSounds; h++) {
      String filePath = "/soundLibrary/bird" + (i) + "/" + (h + 1) + ".mp3";
      birdSounds[i][h] = new SoundFile(this, filePath);
      startTime[i][h] = int(random(0,300000));  // Assign a start time to each sound
      soundsPlayed[i][h] = false;
    }
  }   
}

void draw() {
  background(100); 
  
  text("Select Season:", width / 2, height / 4 - 100);
  
  drawButton(width / 2 - 450, height / 4, "Spring", currentSeason == 0);
  drawButton(width / 2 - 150, height / 4, "Summer", currentSeason == 1);
  drawButton(width / 2 + 150, height / 4, "Fall", currentSeason == 2);
  drawButton(width / 2 + 450, height / 4, "Winter", currentSeason == 3);
  
  text("Select Time of Day:", width / 2, height / 2 - 100);
  
  drawButton(width / 2 - 450, height / 2, "Morning", currentTime == 0);
  drawButton(width / 2 - 150, height / 2, "Noon", currentTime == 1);
  drawButton(width / 2 + 150, height / 2, "Evening", currentTime == 2);
  drawButton(width / 2 + 450, height / 2, "Night", currentTime == 3);
  
  drawButton(width / 2, (height / 4) * 3, "Play", isPlaying);
}

void keyPressed() {
  if (key == 'p' || key == 'P') {
    playSoundscape();
  }
  if (key == 's' || key == 'S') {
    isPlaying = false;
  }
}

void playSoundscape() {
    
  // Fill array with bird activity extracted from CSV 
  for (int i = 0; i < numBirds; i++) {
    allBirds[i] = new Bird(i); 
    birdActivity[i] = allBirds[i].getActivityLevel(currentTime, currentSeason);   // 1D array only with activity for the current season & time
  }  
  
  isPlaying = true;
  
  while(isPlaying){
    for (int i = 0; i < numBirds; i++) {             
      for (int h = 0; h < birdActivity[i]; h++) {    
        if(millis() >= startTime[i][h] && !soundsPlayed[i][h]){
          birdSounds[i][h].play(random(0.7, 1.5), random(-0.8, 0.8), random(0.2,1));    
          soundsPlayed[i][h] = true;
        }
      }
    }
  }
}

// Function to draw each button
void drawButton(float x, float y, String label, boolean active) {
  rectMode(CENTER);

  if (active) {
    stroke(0, 255, 0);  
    fill(0, 255, 0);    
  } else {
    noFill();           
    stroke(0);          
  }
  strokeWeight(2);
  
  // Draw the button shape
  rect(x, y, 250, 80, 30); 

  // Draw the label text
  noStroke();   
  fill(0);
  textAlign(CENTER, CENTER);
  text(label, x, y);  
}


// Handle mouse clicks to select buttons
void mousePressed() {
  if (isButtonClicked(width / 2 - 450, height / 4)) currentSeason = 0;
  else if (isButtonClicked(width / 2 - 150, height / 4)) currentSeason = 1;
  else if (isButtonClicked(width / 2 + 150, height / 4)) currentSeason = 2;
  else if (isButtonClicked(width / 2 + 450, height / 4)) currentSeason = 3;
  
  if (isButtonClicked(width / 2 - 450, height / 2)) currentTime = 0;
  else if (isButtonClicked(width / 2 - 150, height / 2)) currentTime = 1;
  else if (isButtonClicked(width / 2 + 150, height / 2)) currentTime = 2;
  else if (isButtonClicked(width / 2 + 450, height / 2)) currentTime = 3;
  
  if (isButtonClicked(width / 2, (height / 4) * 3)) playSoundscape();
}

// Function to detect if a button is clicked based on its center coordinates
boolean isButtonClicked(float x, float y) {
  return mouseX > x - 125 && mouseX < x + 125 && mouseY > y - 40 && mouseY < y + 40;
}
