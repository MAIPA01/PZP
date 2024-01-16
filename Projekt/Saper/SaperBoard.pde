class SaperBoard extends GameObject {
  
  private int _w, _h;
  private int _cellsNumberX, _cellsNumberY;
  
  private int _bombsNumber = 10;
  
  private ArrayList<SaperCell> _cells = new ArrayList<SaperCell>();
  
  private boolean _gameEnded = false;
  
  public SaperBoard(int w, int h, int cellsNumberX, int cellsNumberY) {
    _w = w;
    _h = h;
    _cellsNumberX = cellsNumberX;
    _cellsNumberY = cellsNumberY;
  }
  
  public void draw(PGraphics drawTarget) {
    for (int i = 0; i < _cells.size(); i++) {
     _cells.get(i).draw(drawTarget);
    }
  }
  
  public void mousePressed() {
    if (!_gameEnded) {
      for (int i = 0; i < _cells.size(); i++) {
        _cells.get(i).mousePressed();
      }
    }
  }
  
  public void setBombsNumber(int num) {
    _bombsNumber = min(num, _cellsNumberX * _cellsNumberY);
  }
  
  public void setCellsNumberX(int num) {
    _cellsNumberX = num;
    _bombsNumber = min(_bombsNumber, _cellsNumberX * _cellsNumberY);
  }
  
  public void setCellsNumberY(int num) {
    _cellsNumberY = num;
    _bombsNumber = min(_bombsNumber, _cellsNumberX * _cellsNumberY);
  }
  
  public void generate() {
    _gameEnded = false;
    
    int cellSizeX = _w / _cellsNumberX;
    int cellSizeY = _h / _cellsNumberY;
    
    float startX = (width / 2f) - (_cellsNumberX / 2f) * cellSizeX;
    float startY = (height / 2f) - (_cellsNumberY / 2f) * cellSizeY;
    
    ArrayList<Integer> emptyCells = new ArrayList<Integer>();
    for (int i = 0; i < _cellsNumberX * _cellsNumberY; i++) {
       emptyCells.add(i);
    }
    
    ArrayList<Integer> bombCells = new ArrayList<Integer>();
    for (int i = 0; i < _bombsNumber; i++) {
      int cellNum = (int)random(0, emptyCells.size());
      bombCells.add(emptyCells.get(cellNum));
      emptyCells.remove(emptyCells.get(cellNum));
    }
    
    _cells.clear();
    for (int idX = 0; idX < _cellsNumberX; idX++) {
      for (int idY = 0; idY < _cellsNumberY; idY++) {
        float x = startX + idX * cellSizeX;
        float y = startY + idY * cellSizeY;
        
        if (bombCells.contains(idX * _cellsNumberY + idY)) {
          SaperCell cell = new SaperCell(x, y, cellSizeX, cellSizeY);
          
          cell.addAction(() -> {
            println("GameOver :)");
          });
          
          _cells.add(cell);
        }
        else {
          int bombsNum = 0;
          for (int iX = max(idX - 1, 0); iX <= min(idX + 1, _cellsNumberX - 1); iX++) {
            for (int iY = max(idY - 1, 0); iY <= min(idY + 1, _cellsNumberY - 1); iY++) {
               if (iX != idX || iY != idY) {
                 if (bombCells.contains(iX * _cellsNumberY + iY)) {
                   bombsNum++; 
                 }
               }
            }
          }
          
          SaperCell cell = new SaperCell(x, y, cellSizeX, cellSizeY, bombsNum);
          final int currIdX = idX;
          final int currIdY = idY;
          
          cell.addAction(() -> {
            if (cell.isEmpty()) {
              for (int iX = max(currIdX - 1, 0); iX <= min(currIdX + 1, _cellsNumberX - 1); iX++) {
                for (int iY = max(currIdY - 1, 0); iY <= min(currIdY + 1, _cellsNumberY - 1); iY++) {
                   if (iX != currIdX || iY != currIdY) {
                     SaperCell nearCell = _cells.get(iX * _cellsNumberY + iY);
                     if (nearCell.isEmpty() && !nearCell.isEnabled()) {
                        nearCell.Invoke();
                     }
                   }
                }
              }
            }
          });
          
          _cells.add(cell);
        }
      }
    }
  }
}
