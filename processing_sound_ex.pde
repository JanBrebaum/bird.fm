///**
// * Processing Sound Library, Example 3
// *
// * This example shows how to make a simple sampler and sequencer
// * with the Sound library. In this sketch, five different samples are
// * loaded and played back at different pitches, in this case five
// * different octaves. The sequencer triggers an event every 200-1000
// * milliseconds randomly. Each time a sound is played a colored
// * rect with a random color is displayed.
// *
// * Load this example with included sound files from the Processing Editor:
// * Examples > Libraries > Sound > Soundfile > Sampler
// */

//import processing.sound.*;

//SoundFile[] blackbird, blackcap, bluetit, chaffinch, chiffchaff, fieldfare, goldcrest, greattit, housesparrow, magpie, nightingale, nuthatch, redstart, robin, rockdove, siskin, skylark, starling, treesparrow, waxwing, whinchat, woodpecker, woodpigeon;

//// The playSound array is defining how many samples will
//// be played at each trigger event
//int[] playSound = {1, 1, 1, 1, 1};

//// The trigger is an integer number in milliseconds so we
//// can schedule new events in the draw loop
//int trigger;

//// This array holds the pixel positions of the rectangles
//// which are drawn each event
//int[] posx = {0, 128, 256, 384, 512};


//void setup() {
//  size(640, 360);
//  background(255);

//  // Create an array of empty soundfiles
//  file = new SoundFile[numsounds];

//  // Load 5 soundfiles from a folder in a for loop.
//  // By naming the files 1., 2., 3., n.aif it is easy to iterate
//  // through the folder and load all files in one line of code.
//  for (int i = 0; i < numsounds; i++) {
//    file[i] = new SoundFile(this, (i+1) + ".aif");
//  }

//  // Create a trigger which will be the basis for our random sequencer.
//  trigger = millis();
//}

//void draw() {

//  // If the determined trigger moment in time matches up with the
//  // computer clock events get triggered.
//  if (millis() > trigger) {
//    // Redraw the background every time to erase old rects
//    background(255);

//    // By iterating through the playSound array we check for 1 or 0,
//    // 1 plays a sound and draws a rect, for 0 nothing happens.

//    for (int i = 0; i < numsounds; i++) {
//      // Check which indexes are 1 and 0.
//      if (playSound[i] == 1) {
//        float rate;
//        // Choose a random color and get set to noStroke()
//        fill(int(random(255)), int(random(255)), int(random(255)));
//        noStroke();
//        // Draw the rect in the positions we defined earlier in posx
//        rect(posx[i], 50, 128, 260);
//        // Choose a random index of the octave array
//        rate = octave[int(random(0, 5))];
//        // Play the soundfile from the array with the respective rate and loop set to false
//        file[i].play(rate, 1.0);
//      }

//      // Renew the indexes of playSound so that at the next event the order is different and randomized.
//      playSound[i] = int(random(0, 2));
//    }

//    // Create a new triggertime in the future, with a random offset between 200 and 1000 milliseconds
//    trigger = millis() + int(random(200, 1000));
//  }
//}

  //// Define how many sounds each bird category has (replace with actual numbers)
  //numSounds[0] = 14;  // Example: first bird has 5 sounds
  //numSounds[1] = 8;  // Example: second bird has 4 sounds
  //numSounds[2] = 12;
  //numSounds[3] = 9;
  //numSounds[4] = 10;
  //numSounds[5] = 8;
  //numSounds[6] = 8;
  //numSounds[7] = 4;
  //numSounds[8] = 4;
  //numSounds[9] = 4;
  //numSounds[10] = 4;
  //numSounds[11] = 4;
  //numSounds[12] = 4;
  //numSounds[13] = 4;
  //numSounds[14] = 4;
  //numSounds[15] = 4;
  //numSounds[16] = 4;
  //numSounds[17] = 4;
  //numSounds[18] = 4;
  //numSounds[19] = 4;
  //numSounds[20] = 4;
  //numSounds[21] = 4;
  //numSounds[22] = 4;
  //numSounds[23] = 4;
