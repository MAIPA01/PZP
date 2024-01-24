class PietnastkaBoard extends GameObject {
  
  constructor(x, y) {
    super(x, y);
    this.cells = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
    
    this.animating = false;
    this.fromPos = createVector();
    this.deltaPos = createVector();
    this.buttonID = 0;
    this.animTime = 0.25;
    this.currAnimTime = 0;
    
    this.buttonWidth = 80;
    this.buttonHeight = 80;
    this.strokeWeight = 2;
    
    this.TUP = 0;
    this.TRIGHT = 1;
    this.TDOWN = 2;
    this.TLEFT = 3;
    
    this.triangles = [];
    for (let i = 0; i < 4; i++) {
      let sizeX = this.buttonWidth / 2;
      let sizeY = this.buttonHeight / 5;
      
      let drawFunc = (ref, drawTarget) => {
        drawTarget.push();
        
        let pos = ref.getPosition();
        
        drawTarget.fill(color(255, 255, 0));
        drawTarget.noStroke();
        drawTarget.translate(pos.x, pos.y);
        drawTarget.rotate(radians(90 * i));
        drawTarget.triangle(-sizeX / 2, sizeY / 2, sizeX / 2, sizeY / 2, 0, -sizeY / 2);
        
        drawTarget.pop();
      }
      
      let angle = radians(90 * i);
      let cosa = cos(angle);
      let sina = sin(angle);
      let arrow = new QuickObjectButton(x, y, abs(sizeX * cosa + sizeY * sina), abs(sizeY * cosa + sizeX * sina), drawFunc);
      arrow.setColor(color(0, 0, 0, 0));
      arrow.addAction(() => {
        if (mouseButton == LEFT) {
          this.arrowFunc(i);
        }
      });
      this.triangles.push(arrow);
    }
    
    this.textSize = 25;
    this.generate();
  }
  
  generate() {
    this.cells = shuffle(this.cells);
    
    this.updateButtons();
  }
  
  updateButtons() {
    this.cellsButtons = [];
    let pos = super.getPosition();
    
    let startX = pos.x - 2 * this.buttonWidth + this.buttonWidth / 2;
    let startY = pos.y - 2 * this.buttonHeight + this.buttonHeight / 2;
    
    for (let i = 0; i < this.cells.length; i++) {
      let x = i % 4;
      let y = floor(i / 4);
      if (this.cells[i] != 0) {
        let cellButton = new TextButton(startX + x * this.buttonWidth, startY + y * this.buttonHeight, this.buttonWidth, this.buttonHeight, "" + this.cells[i]);
        cellButton.setStrokeWeight(this.strokeWeight);
        cellButton.setStrokeColor(color(0));
        cellButton.setHasStroke(true);
        cellButton.setTextSize(this.textSize);
        this.cellsButtons.push(cellButton);
      }
      else {
        this.updateArrows(x, y);
        this.cellsButtons.push(new GameObject(startX + x * this.buttonWidth, startY + y * this.buttonHeight));
      }
    }
  }
  
  updateArrows(x, y) {
    let pos = super.getPosition();
    let startX = pos.x - 2 * this.buttonWidth + this.buttonWidth / 2;
    let startY = pos.y - 2 * this.buttonHeight + this.buttonHeight / 2;
    
    if (x != 3) {
      let twidth = this.triangles[this.TLEFT].getWidth();
      this.triangles[this.TLEFT].enable(true);
      this.triangles[this.TLEFT].setPosition(startX + (x * this.buttonWidth) + (this.buttonWidth / 2) - (twidth / 2) - this.strokeWeight, startY + y * this.buttonHeight);
    }
    else {
      this.triangles[this.TLEFT].enable(false);
    }
    
    if (x != 0) {
      let twidth = this.triangles[this.TRIGHT].getWidth();
      this.triangles[this.TRIGHT].enable(true);
      this.triangles[this.TRIGHT].setPosition(startX + (x * this.buttonWidth) - (this.buttonWidth / 2) + (twidth / 2) + this.strokeWeight, startY + y * this.buttonHeight);
    }
    else {
      this.triangles[this.TRIGHT].enable(false); 
    }
    
    if (y != 3) {
      let theight = this.triangles[this.TUP].getHeight();
      this.triangles[this.TUP].enable(true);
      this.triangles[this.TUP].setPosition(startX + x * this.buttonWidth, startY + (y * this.buttonHeight) + (this.buttonHeight / 2) - (theight / 2) - this.strokeWeight);
    }
    else {
      this.triangles[this.TUP].enable(false); 
    }
    
    if (y != 0) {
      let theight = this.triangles[this.TDOWN].getHeight();
      this.triangles[this.TDOWN].enable(true);
      this.triangles[this.TDOWN].setPosition(startX + x * this.buttonWidth, startY + (y * this.buttonHeight) - (this.buttonHeight / 2) + (theight / 2) + this.strokeWeight);
    }
    else {
      this.triangles[this.TDOWN].enable(false); 
    }
  }
  
  arrowFunc(arrowType) {
    let id = this.cells.indexOf(0);
    let x = floor(id % 4);
    let y = floor(id / 4);
    
    let pos = super.getPosition();
    let startX = pos.x - 2 * this.buttonWidth + this.buttonWidth / 2;
    let startY = pos.y - 2 * this.buttonHeight + this.buttonHeight / 2;
    
    let xToMove;
    let yToMove;
    
    if (arrowType == this.TUP) {
      xToMove = x;
      yToMove = y + 1;
    }
    else if (arrowType == this.TRIGHT) {
      xToMove = x - 1;
      yToMove = y;
    }
    else if (arrowType == this.TDOWN) {
      xToMove = x;
      yToMove = y - 1;
    }
    else if (arrowType == this.TLEFT) {
      xToMove = x + 1;
      yToMove = y;
    }
    
    let idToMove = yToMove * 4 + xToMove;
    this.cells[id] = this.cells[idToMove];
    this.cells[idToMove] = 0;
    this.updateArrows(xToMove, yToMove);
    
    // przesunięcie buttona
    this.fromPos = this.cellsButtons[idToMove].getPosition();
    this.deltaPos.x = startX + x * this.buttonWidth - this.fromPos.x;
    this.deltaPos.y = startY + y * this.buttonHeight - this.fromPos.y;
    this.buttonID = id;
    this.animating = true;
    this.currAnimTime = 0;
    
    //this.cellsButtons[idToMove].setPosition(startX + x * this.buttonWidth, startY + y * this.buttonHeight);
    let button = this.cellsButtons[idToMove];
    this.cellsButtons[idToMove] = this.cellsButtons[id];
    this.cellsButtons[id] = button;
  }
  
  checkBoard() {
    for (let i = 0; i < 16; i++) {
      if (i == 15 && this.cells[i] != 0) {
        return false;
      }
      if (i != 15 && this.cells[i] != i + 1) {
        return false; 
      }
    }
    return true;
  }
  
  isAnimating() {
    return this.animating;
  }
  
  draw(drawTarget) {
    drawTarget.push();
    
    let pos = super.getPosition();
    drawTarget.rectMode(CENTER);
    drawTarget.fill(color(128));
    drawTarget.strokeWeight(this.strokeWeight);
    drawTarget.stroke(color(0));
    drawTarget.rect(pos.x, pos.y, this.buttonWidth * 4, this.buttonHeight * 4);
    
    if (this.animating) {
      if (getFrameRate() != 0) {
        this.currAnimTime += 1 / getFrameRate();
      }
      
      let posX, posY;
      if (this.currAnimTime < this.animTime) {
        posX = this.fromPos.x;
        posY = this.fromPos.y;
        posX += (this.currAnimTime * this.deltaPos.x) / this.animTime;
        posY += (this.currAnimTime * this.deltaPos.y) / this.animTime;
      }
      else {
        this.animating = false;
        posX = this.fromPos.x + this.deltaPos.x;
        posY = this.fromPos.y + this.deltaPos.y;
      }
      
      this.cellsButtons[this.buttonID].setPosition(posX, posY);
    }
    
    for (let i = 0; i < this.cellsButtons.length; i++) {
      this.cellsButtons[i].draw(drawTarget);
    }
    
    if (!this.animating) {
      for (let i = 0; i < this.triangles.length; i++) {
        if (this.triangles[i].isEnabled()) {
          this.triangles[i].draw(drawTarget);
        }
      }
    }
    drawTarget.pop();
  }
  
  mouseClicked() {
    if (!this.animating) {
      for (let i = 0; i < this.triangles.length; i++) {
        if (this.triangles[i].isEnabled()) {
          this.triangles[i].mouseClicked(); 
        }
      }
    }
  }
  
  saveBoard() {
    for (let i = 0; i < this.cells.length; i++) {
      localStorage.setItem("Game.Board.Cells[" + i + "]", this.cells[i]);
    }
    localStorage.setItem("Game.Board.Exist", true);
    return true;
  }
  
  loadBoard() {
    let exists = localStorage.getItem("Game.Board.Exist");
    if (exists != null) {
     for (let i = 0; i < this.cells.length; i++) {
       this.cells[i] = int(localStorage.getItem("Game.Board.Cells[" + i + "]"));
     }
     
     this.updateButtons();
     return true;
    }
    return false;
  }
  
  getJson() {
    let boardJson = JSON.parse("{}"); 
    
    boardJson['Cells'] = this.cells;
    
    return boardJson;
  }
  
  loadJson(boardJson) {
    this.cells = boardJson['Cells'];
    
    this.updateButtons();
  }
}
