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
 
 public void display(PGraphics drawLayer) {
   drawLayer.pushMatrix();
   drawLayer.pushStyle();
   
   float startX = width / 2f - (9 * cellSizeX) / 2f;
   float startY = height / 2f - (9 * cellSizeY) / 2f;
   
   // draw Buttons
   for (int i = 0; i < cellButtons.size(); i++) {
    cellButtons.get(i).display(drawLayer); 
   }
   
   // draw Lines
   for (int i = 0; i <= 9; i++) {
     if (i % 3 == 0) drawLayer.strokeWeight(4);
     else drawLayer.strokeWeight(2);
     drawLayer.line(startX + i * cellSizeX, startY, startX + i * cellSizeX, startY + 9 * cellSizeY);
     drawLayer.line(startX, startY + i * cellSizeY, startX + 9 * cellSizeX, startY + i * cellSizeY);
   }
   
   // draw Numbers
   drawLayer.textSize(24);
   float textHeight = (drawLayer.textAscent() + drawLayer.textDescent()) * 0.75f;
   for (int x = 0; x < 9; x++) {
    for (int y = 0; y < 9; y++) {
      if (_cells[x][y] != 0) {
        if (_cells[x][y] == choosed) drawLayer.fill(255, 0, 0);
        else drawLayer.fill(255);
        String text = "" + _cells[x][y];
        drawLayer.text(text, startX + x * cellSizeX + cellSizeX / 2f - drawLayer.textWidth(text) / 2f, startY + y * cellSizeY + cellSizeY / 2f + textHeight / 2f);
      }
    }
   }
   
   drawLayer.popStyle();
   drawLayer.popMatrix();
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
     Button button = new Button(buttonPosX, buttonPosY, cellSizeX, cellSizeY);
     button.setColor(color(128));
     button.addAction(() -> {
       _cells[x][y] = this.choosed;
     });
     cellButtons.add(button);
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
 
 public boolean checkBoard() {
   
   // check rows and columns
   for (int i = 0; i < 9; i++) {
     ArrayList<Integer> inColumn = new ArrayList<Integer>();
     ArrayList<Integer> inRow = new ArrayList<Integer>();
     for (int j = 0; j < 9; j++) {
       // check row
       if (_cells[j][i] == 0) return false;
       if (inRow.contains(_cells[j][i])) return false;
       inRow.add(_cells[j][i]);
       
       // check column
       if (_cells[i][j] == 0) return false;
       if (inColumn.contains(_cells[i][j])) return false;
       inColumn.add(_cells[i][j]);
     }
   }
   
   // check boxes
   for (int bx = 0; bx < 3; bx++) {
     int startX = bx * 3;
     for (int by = 0; by < 3; by++) {
         int startY = by * 3;
         ArrayList<Integer> inBox = new ArrayList<Integer>();
         for (int x = startX; x < startX + 3; x++) {
            for (int y = startY; y < startY + 3; y++) {
               if (_cells[x][y] == 0) return false;
               if (inBox.contains(_cells[x][y])) return false;
               inBox.add(_cells[x][y]);
            }
         }
     }
   }
   
   return true;
 }
}
