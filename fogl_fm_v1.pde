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
int[][] startTime = new int[numBirds][numSounds];
boolean[][] soundsPlayed = new boolean[numBirds][numSounds];

void setup() {
  size(400, 400);
  
  birdSounds = new SoundFile[numBirds][]; 
  
  for (int i = 0; i < numBirds; i++) {
    birdSounds[i] = new SoundFile[numSounds]; 


    for (int h = 0; h < numSounds; h++) {
      String filePath = "/soundLibrary/bird" + (i) + "/" + (h + 1) + ".mp3";
      birdSounds[i][h] = new SoundFile(this, filePath);
      startTime[i][h] = int(random(0,60000));
      soundsPlayed[i][h] = false;
    }
  }  
  
  int currentSeason = 1;
  int currentTime = 1;
  int totalActivity = 0;
  
  for (int i = 0; i < numBirds; i++) {
    allBirds[i] = new Bird(i);
    birdActivity[i] = allBirds[i].getActivityLevel(currentSeason, currentTime);
    System.out.println("round"+i);
    System.out.println(birdActivity[i]);
    totalActivity = totalActivity + birdActivity[i];
  }
  
  System.out.println(totalActivity);
    
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
      if(millis() >= startTime[i][h] && !soundsPlayed[i][h]){
        birdSounds[i][h].play();    
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

public class BirdActivity {
    int[][] activity;

    public BirdActivity() {
    activity = new int[4][4];
    }

    public int getActivity(int season, int time) {
        return activity[season][time];  
    }
}
