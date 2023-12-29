import java.util.Random;
import java.util.Arrays;

public enum SUDOKU_LEVEL { 
  EASY (9), 
  MEDIUM (20), 
  HARD (40);
  
  private int cellsNumber;
  
  SUDOKU_LEVEL (int cellsNumber) {
    this.cellsNumber = cellsNumber;
  }
  
  public int getCellsNumber() {
   return cellsNumber; 
  }
};

public class SudokuBoard {
 
 private float cellSizeX = 30f;
 private float cellSizeY = 30f;
 private int[][] _cells;
 
 private ArrayList<Button> cellButtons = new ArrayList<Button>();
 
 private int choosed = 0;
 
 SudokuBoard() {
    _cells = new int[9][];
    for (int i = 0; i < 9; i++) {
     _cells[i] = new int[9];
    }
 }
 
 public void display() {
   pushMatrix();
   pushStyle();
   
   float startX = width / 2f - (9 * cellSizeX) / 2f;
   float startY = height / 2f - (9 * cellSizeY) / 2f;
   
   // draw Buttons
   for (int i = 0; i < cellButtons.size(); i++) {
    cellButtons.get(i).display(); 
   }
   
   // draw Lines
   for (int i = 0; i <= 9; i++) {
     if (i % 3 == 0) strokeWeight(4);
     else strokeWeight(2);
     line(startX + i * cellSizeX, startY, startX + i * cellSizeX, startY + 9 * cellSizeY);
     line(startX, startY + i * cellSizeY, startX + 9 * cellSizeX, startY + i * cellSizeY);
   }
   
   // draw Numbers
   textSize(24);
   float textHeight = (textAscent() + textDescent()) * 0.75f;
   for (int x = 0; x < 9; x++) {
    for (int y = 0; y < 9; y++) {
      if (_cells[x][y] != 0) {
        if (_cells[x][y] == choosed) fill(255, 0, 0);
        else fill(255);
        String text = "" + _cells[x][y];
        text(text, startX + x * cellSizeX + cellSizeX / 2f - textWidth(text) / 2f, startY + y * cellSizeY + cellSizeY / 2f + textHeight / 2f);
      }
    }
   }
   
   popMatrix();
   popStyle();
 }
 
 void clearBoard() {
   cellButtons.clear();
   for (int x = 0; x < 9; x++) {
    for (int y = 0; y < 9; y++) {
     _cells[x][y] = 0; 
    }
   }
 }
 
 void generateBoard() {
   clearBoard();
   
    Random rnd = new Random();
   
   // First run
   ArrayList<ArrayList<Integer>> cellsPosibilities = new ArrayList<ArrayList<Integer>>();
  for (int i = 0; i < 81; i++) {
      cellsPosibilities.add(new ArrayList<Integer>(Arrays.asList(1, 2, 3, 4, 5, 6, 7, 8, 9)));
   }
   
   // Choose random cell
   int index = rnd.nextInt(81);
   
   // Choose random option
   int option = rnd.nextInt(cellsPosibilities.get(index).size());
   
   // Put option to cell
   _cells[index / 9][index % 9] = cellsPosibilities.get(index).get(option);
   
   // Iterate until end
   while (true) {
      boolean end = true;
     // calculate new options
     for (int i = 0; i < 81; i++) {
        cellsPosibilities.set(i, possibleInputs(i / 9, i % 9));
        if (cellsPosibilities.get(i).size() != 0) {
         end = false; 
        }
     }
     
     if (end) {
      break; 
     }
     
     // get list of cells with less possibilities
     int min = 9;
     for (int i = 0; i < 81; i++) {
       int size = cellsPosibilities.get(i).size();
       if (size != 0) {
        if (size < min) {
         min = size;
        }
       }
     }
     
     ArrayList<Integer> lessPosibilities = new ArrayList<Integer>();
     for (int i = 0; i < 81; i++) {
      if (cellsPosibilities.get(i).size() == min) {
       lessPosibilities.add(i);
      }
     }
     
     // choose random cell
     index = lessPosibilities.get(rnd.nextInt(lessPosibilities.size()));
     
     // choose random option
     option = rnd.nextInt(cellsPosibilities.get(index).size());
     
     // put option to cell
     _cells[index / 9][index % 9] = cellsPosibilities.get(index).get(option);
   }
 }
 
 ArrayList<Integer> possibleInputs(int x, int y) {
   if (_cells[x][y] != 0) {
    return new ArrayList<Integer>(); 
   }
   ArrayList<Integer> possibilities = new ArrayList<Integer>(Arrays.asList(1, 2, 3, 4, 5, 6, 7, 8, 9));
   
   // check rows && columns
   for (int i = 0; i < 9; i++) {
     // rows
     if (i != x && _cells[i][y] != 0) {
       if (possibilities.contains(_cells[i][y])) {
        possibilities.remove(possibilities.indexOf(_cells[i][y])); 
       }
     }
     
     if (i != y && _cells[x][i] != 0) {
      if (possibilities.contains(_cells[x][i])) {
        possibilities.remove(possibilities.indexOf(_cells[x][i]));
      }
     }
   }
   
   // check box
   int boxStartX = (x / 3) * 3;
   int boxStartY = (y / 3) * 3;
   for (int bx = boxStartX; bx < boxStartX + 3; bx++) {
    for (int by = boxStartY; by < boxStartY + 3; by++) {
      if ((bx == x && by == y) || _cells[bx][by] == 0) continue;
      
      if (possibilities.contains(_cells[bx][by])) {
        possibilities.remove(possibilities.indexOf(_cells[bx][by]));
      }
    }
   }
   
   return possibilities;
 }
 
 public void generateLevel(SUDOKU_LEVEL level) {
   generateBoard();
   
   Random rnd = new Random(); //<>//
   
   ArrayList<Integer> possibleIndexes = new ArrayList<Integer>();
   for (int i = 0; i < 81; i++) {
    possibleIndexes.add(i); 
   }
   for (int i = 0; i < level.getCellsNumber(); i++) {
     int index = possibleIndexes.get(rnd.nextInt(possibleIndexes.size()));
     final int x = index / 9;
     final int y = index % 9;
     _cells[x][y] = 0;
     possibleIndexes.remove(possibleIndexes.indexOf(index));
     
     float startX = width / 2f - (9 * cellSizeX) / 2f;
     float startY = height / 2f - (9 * cellSizeY) / 2f;
     
     float buttonPosX = startX + x * cellSizeX + cellSizeX / 2f;
     float buttonPosY = startY + y * cellSizeY + cellSizeY / 2f;
     cellButtons.add(new Button(buttonPosX, buttonPosY, cellSizeX, cellSizeY, color(128)));
     cellButtons.get(i).addAction(() -> { _cells[x][y] = this.choosed; });
   }
 }
 
 public void setChoosed(int choosed) {
   this.choosed = choosed;
 }
 
 public void mousePressed() {
   for (int i = 0; i < cellButtons.size(); i++) {
    cellButtons.get(i).mousePressed(); 
   }
 }
 
 void checkBoard() {
   
 }
}
