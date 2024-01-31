class SaperBoard extends GameObject {
  
  private int _cellWidth, _cellHeight;
  private int _columns, _rows;
  
  private int _bombsNumber = 10;
  
  private ArrayList<SaperCell> _cells = new ArrayList<SaperCell>();
  
  private boolean _gameEnded = false;
  private boolean _lost = false;
  
  public SaperBoard(int cellWidth, int cellHeight, int columns, int rows) {
    _cellWidth = cellWidth;
    _cellHeight = cellHeight;
    _columns = columns;
    _rows = rows;
  }
  
  public void draw(PGraphics drawTarget) {
    for (int i = 0; i < _cells.size(); i++) {
     _cells.get(i).draw(drawTarget);
    }
  }
  
  public void mouseClicked() {    
    if (!_gameEnded) {
      for (int i = 0; i < _cells.size(); i++) {
        _cells.get(i).mouseClicked();
      }
    }
  }
  
  public void setPosition(float x, float y) {
    this.setPosition(new PVector(x, y)); 
  }
  
  public void setPosition(PVector pos) {
    PVector lpos = getPosition();
    super.setPosition(pos);
    PVector diff = new PVector(pos.x - lpos.x, pos.y - lpos.y);
    
    for (int i = 0; i < _cells.size(); i++) {
      SaperCell cell = _cells.get(i);
      PVector cellPos = cell.getPosition();
      cell.setPosition(cellPos.x + diff.x, cellPos.y + diff.y);
    }
  }
  
  public void setRowsNumber(int num) {
    _rows = num;
    _bombsNumber = min(_bombsNumber, _rows * _columns);
  }
  
  public void setColumnsNumber(int num) {
    _columns = num;
    _bombsNumber = min(_bombsNumber, _rows * _columns);
  }
  
  public boolean checkBoard() {
    if (_lost) return false;
    
    int goodFlags = 0;
    boolean allNotBombsEnabled = true;
    for (int i = 0; i < _cells.size(); i++) {
      SaperCell cell = _cells.get(i);
      if (cell.isFlaged() && cell.isBomb()) {
        goodFlags++;
      }
      if (!cell.isBomb() && !cell.isEnabled()) {
         allNotBombsEnabled = false;
      }
    }
    return goodFlags == _bombsNumber || allNotBombsEnabled;
  }
  
  public boolean isGameEnded() {
    return _gameEnded; 
  }
  
  public void generate(int bombsNumber) {
    _gameEnded = false;
    _bombsNumber = bombsNumber;
    
    float startX = (width / 2f) - (_columns / 2f) * _cellWidth + _cellWidth / 2f;
    float startY = (height / 2f) - (_rows / 2f) * _cellHeight + _cellHeight / 2f;
    
    ArrayList<Integer> emptyCells = new ArrayList<Integer>();
    for (int i = 0; i < _rows * _columns; i++) {
       emptyCells.add(i);
    }
    
    ArrayList<Integer> bombCells = new ArrayList<Integer>();
    for (int i = 0; i < _bombsNumber; i++) {
      int cellNum = (int)random(0, emptyCells.size());
      bombCells.add(emptyCells.get(cellNum));
      emptyCells.remove(emptyCells.get(cellNum));
    }
    
    _cells.clear();
    for (int idX = 0; idX < _columns; idX++) {
      for (int idY = 0; idY < _rows; idY++) {
        float x = startX + idX * _cellWidth;
        float y = startY + idY * _cellHeight;
        
        final int currIdX = idX;
        final int currIdY = idY;
        
        SaperCell cell = null;
        if (bombCells.contains(idX * _rows + idY)) {
          cell = new SaperCell(x, y, _cellWidth, _cellHeight);
          
          cell.addAction(() -> {
            if (mouseButton == LEFT) {
              _gameEnded = true;
              _lost = true;
            }
          });
        }
        else {
          int bombsNum = 0;
          for (int iX = max(idX - 1, 0); iX <= min(idX + 1, _columns - 1); iX++) {
            for (int iY = max(idY - 1, 0); iY <= min(idY + 1, _rows - 1); iY++) {
               if (iX != idX || iY != idY) {
                 if (bombCells.contains(iX * _rows + iY)) {
                   bombsNum++;
                 }
               }
            }
          }
          
          cell = new SaperCell(x, y, _cellWidth, _cellHeight, bombsNum);
          
          if (cell.isEmpty()) {
            cell.addAction(() -> {
              if (mouseButton == LEFT) {
                for (int iX = max(currIdX - 1, 0); iX <= min(currIdX + 1, _columns - 1); iX++) {
                  for (int iY = max(currIdY - 1, 0); iY <= min(currIdY + 1, _rows - 1); iY++) {
                     if (iX != currIdX || iY != currIdY) {
                       SaperCell nearCell = _cells.get(iX * _rows + iY);
                       if (!nearCell.isFlaged()) {
                         int lastMB = mouseButton;
                         mouseButton = LEFT;
                         if (nearCell.isEmpty() && !nearCell.isEnabled()) {
                            nearCell.Invoke();
                         }
                         else if (!nearCell.isEmpty() && !nearCell.isEnabled()) {
                            nearCell.Invoke();
                         }
                         mouseButton = lastMB;
                       }
                     }
                  }
                }
              }
            });
          }
        }
        cell.addAction(() -> {
          if (checkBoard()) {
            _gameEnded = true;
          }
          
          if (_gameEnded) {
            for (int iX = 0; iX < _columns; iX++) {
              for (int iY = 0; iY < _rows; iY++) {
                if (iX != currIdX || iY != currIdY) {
                  _cells.get(iX * _rows + iY).enable(true);
                }
              }
            } 
          }
        });
        
        _cells.add(cell);
      }
    }
  }
  
  public JSONObject getJSONObject() {
    JSONObject boardJson = new JSONObject();
    
    boardJson.setInt("Rows", _rows);
    boardJson.setInt("Columns", _columns);
    boardJson.setInt("Bombs", _bombsNumber);
    
    JSONArray cellsArray = new JSONArray();
    for (int i = 0; i < _rows * _columns; i++) {
      cellsArray.append(_cells.get(i).getJSONObject()); 
    }
    boardJson.setJSONArray("Cells", cellsArray);
    
    return boardJson;
  }
  
  public void loadJSONObject(JSONObject boardJson) {
     _rows = boardJson.getInt("Rows");
     _columns = boardJson.getInt("Columns");
     _bombsNumber = boardJson.getInt("Bombs");
     
     _cells.clear();
     float startX = (width / 2f) - (_columns / 2f) * _cellWidth + _cellWidth / 2f;
     float startY = (height / 2f) - (_rows / 2f) * _cellHeight + _cellHeight / 2f;
     
     JSONArray cellsArray = boardJson.getJSONArray("Cells");
     for (int idX = 0; idX < _columns; idX++) {
       for (int idY = 0; idY < _rows; idY++) {
         float x = startX + idX * _cellWidth;
         float y = startY + idY * _cellHeight;
         
         SaperCell cell = new SaperCell(x, y, _cellWidth, _cellHeight, cellsArray.getJSONObject(idX * _rows + idY));
         
         if (cell.isBomb()) {
           cell.addAction(() -> {
            if (mouseButton == LEFT) {
              _gameEnded = true;
            }
          }); 
         }
         else if (cell.isEmpty()) {
           final int currIdX = idX;
           final int currIdY = idY;
           
           cell.addAction(() -> {
              if (mouseButton == LEFT) {
                for (int iX = max(currIdX - 1, 0); iX <= min(currIdX + 1, _columns - 1); iX++) {
                  for (int iY = max(currIdY - 1, 0); iY <= min(currIdY + 1, _rows - 1); iY++) {
                     if (iX != currIdX || iY != currIdY) {
                       SaperCell nearCell = _cells.get(iX * _rows + iY);
                       if (!nearCell.isFlaged()) {
                         int lastMB = mouseButton;
                         mouseButton = LEFT;
                         if (nearCell.isEmpty() && !nearCell.isEnabled()) {
                            nearCell.Invoke();
                         }
                         else if (!nearCell.isEmpty() && !nearCell.isEnabled()) {
                            nearCell.Invoke();
                         }
                         mouseButton = lastMB;
                       }
                     }
                  }
                }
              }
            });
         }
         
         cell.addAction(() -> {
          if (checkBoard()) {
            _gameEnded = true;
          }
        });
         
         _cells.add(cell);
       }
     }
  }
}
