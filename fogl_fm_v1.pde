import java.util.ArrayList;
import processing.data.Table;
import processing.data.TableRow;
import processing.sound.*;

boolean isPlaying = false;
int numBirds = 7;            
int numSounds = 9;  
SoundFile[][] birdSounds;             
Bird[] allBirds = new Bird[numBirds];
int[] birdActivity = new int[numBirds];
int[] randomNumbers = new int[numSounds];
int[][] startTime = new int[numBirds][numSounds];
boolean[][] soundsPlayed = new boolean[numBirds][numSounds];

void setup() {
  size(400, 400);
  
  birdSounds = new SoundFile[numBirds][]; 
  
  // Array with random numbers to randomize sound
  for (int i = 0; i < numSounds; i++){
    randomNumbers[i] = i + 1;
  }
  
  // Swap to random numbers in the array
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
      startTime[i][h] = int(random(0,60000));  // Assign a start time to each sound
      soundsPlayed[i][h] = false;
    }
  }  
  
  // Hardcoded variables for season & time
  int currentSeason = 0;  // 0 = spring, 1 = summer, 2 = autumn, 3 = winter
  int currentTime = 0;    // 0 = morning, 1 = day/afternoon, 2 = evening, 3 = night
  
  // Fill array with bird activity extracted from CSV 
  for (int i = 0; i < numBirds; i++) {
    allBirds[i] = new Bird(i); 
    birdActivity[i] = allBirds[i].getActivityLevel(currentSeason, currentTime);   // 1D array only with activity for the current season & time
  }   
}

void draw() {
  background(0);
  
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(24);
  if (isPlaying) {
    text("Soundscape Playing... Press 'S' to Stop", width / 2, height / 2);
  } else {
    text("Press 'P' to Play Soundscape", width / 2, height / 2);
  }
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
  isPlaying = true;
  while(isPlaying){
    for (int i = 0; i < numBirds; i++) {             
      for (int h = 0; h < birdActivity[i]; h++) {    
        if(birdActivity[i] > 9){
          birdActivity[i] = 9;
        }
      if(millis() >= startTime[i][h] && !soundsPlayed[i][h]){
        birdSounds[i][h].play(random(0.7, 1.5), random(-0.8, 0.8), random(0.2,1));    
        soundsPlayed[i][h] = true;
      }
      }
    }
    }
}

// Function to stop the soundscape
//void stopSoundscape() {
//  if (isPlaying) {
//    //sample1.stop();
//    //sample2.stop();
//    //sample3.stop();
//    isPlaying = false;
//  }
//}

//public class BirdActivity {
//    int[][] activity;

//    public BirdActivity() {
//    activity = new int[4][4];
//    }

//    public int getActivity(int season, int time) {
//        return activity[season][time];  
//    }
//}
