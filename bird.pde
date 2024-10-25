public class Bird {
    int[][] activity;
    int id;

    public Bird(int id) {
      this.id = id;
      this.activity = extractDataFromCSV(id);
    }

public int getActivityLevel(int season, int time) {
    return activity[season][time];  
}

private int[][] extractDataFromCSV(int id) {
  String filePath = "soundLibrary/bird" + (id) + "/activity.csv";  // Sound library needs to be curated accordingly with activity data
  Table table = loadTable(filePath, "header");
  
  // Create a 2D array for activity data
  int[][] birdActivity = new int[4][4];  

  // Loop through the CSV
  for (int i = 0; i < 4; i++) {
    birdActivity[i][0] = table.getInt(i,1);
    birdActivity[i][1] = table.getInt(i,2);
    birdActivity[i][2] = table.getInt(i,3);
    birdActivity[i][3] = table.getInt(i,4);
  }
  return birdActivity;
}
}
