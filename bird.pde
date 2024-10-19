public class Bird {
    int[][] activity;
    int id;

    // Constructor to initialize the activity array
    public Bird(int id) {
      this.id = id;
      this.activity = extractDataFromCSV(id);
    }

public int getActivityLevel(int season, int time) {
    return activity[season][time];  
}

private int[][] extractDataFromCSV(int id) {
  String filePath = "bird" + (id + 1) + "/activity.csv";  // Path format: bird1/activity.csv, bird2/activity.csv...
  Table table = loadTable(filePath, "header");
  
  // Create a 2D array to store data points (4 rows for time of day, 4 columns for seasons)
  int[][] dataPoints = new int[4][4];  
  
  // Times of day that correspond to the rows
  String[] timesOfDay = {"Morning", "Afternoon", "Evening", "Night"};
  
  // Loop through the rows of the CSV
  for (int i = 0; i < 4; i++) {
    TableRow row = table.findRow(timesOfDay[i], 0);  // Find the row matching the time of day
    
    // Extract values for each season (Spring, Summer, Autumn, Winter) and store in array
    dataPoints[i][0] = row.getInt("Spring");
    dataPoints[i][1] = row.getInt("Summer");
    dataPoints[i][2] = row.getInt("Autumn");
    dataPoints[i][3] = row.getInt("Winter");
  }
  return dataPoints;
}
//private int[][] extractDataFromCSV(int id) {
//        return new int[][] {
//            {1, 2, 3, 4},  // Season 0
//            {5, 6, 7, 8},  // Season 1
//            {9, 10, 11, 12},   // Season 2
//            {13, 14, 15, 16}   // Season 3
//        };
//  }

// ID to species

//private int assignID(String species){
//  switch (species) {              // Automatically assign ID
//            case "blackbird":
//                return 0;
//            case "blackcap":
//                return 1;
//            case "bluetit":
//                return 2;
//            case "chaffinch":
//                return 3;
//            case "chiffchaff":
//                return 4;
//            case "fieldfare":
//                return 5;
//            case "goldcrest":
//                return 6;
//            case "goldfinch":
//                return 7;
//            case "greattit":
//                return 8;
//            case "housesparrow":
//                return 9;
//            case "magpie":
//                return 10;
//            case "nightingale":
//                return 11;
//            case "nuthatch":
//                return 12;
//            case "redstart":
//                return 13;
//            case "robin":
//                return 14;
//            case "rockdove":
//                return 15;
//            case "siskin":
//                return 16;
//            case "skylark":
//                return 17;
//            case "starling":
//                return 18;
//            case "treesparrow":
//                return 19;
//            case "waxwing":
//                return 20;
//            case "whinchat":
//                return 21;
//            case "woodpecker":
//                return 22;
//            case "woodpigeon":
//                return 23;
//            default:
//            return 0;
//        }
//}
}
