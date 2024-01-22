class PietnastkaBoard extends GameObject {
  
  constructor(x, y) {
    super(x, y);
    this.cells = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
    
    this.TUP = 0;
    this.TRIGHT = 1;
    this.TDOWN = 2;
    this.TLEFT = 3;
    
    this.triangles = [];
    for (let i = 0; i < 4; i++) {
      let sizeX = 75;
      let sizeY = 25;
      
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
      
      this.triangles.push(new QuickObject(x, y, drawFunc));
    }
    
    this.buttonWidth = 80;
    this.buttonHeight = 80;
    this.strokeWeight = 2;
    this.textSize = 25;
    this.cellsButtons = [];
    this.generate();
  }
  
  generate() {
    this.cells = shuffle(this.cells);
    
    this.cellsButtons = [];
    let pos = super.getPosition();
    
    let startX = pos.x - 2 * this.buttonWidth + this.buttonWidth / 2;
    let startY = pos.y - 2 * this.buttonHeight + this.buttonHeight / 2;
    
    for (let i = 0; i < this.cells.length; i++) {
      if (this.cells[i] != 0) {
        let cellButton = new TextButton(startX + (i % 4) * this.buttonWidth, startY + floor(i / 4) * this.buttonHeight, this.buttonWidth, this.buttonHeight, "" + this.cells[i]);
        cellButton.setStrokeWeight(this.strokeWeight);
        cellButton.setStrokeColor(color(0));
        cellButton.setHasStroke(true);
        cellButton.setTextSize(this.textSize);
        this.cellsButtons.push(cellButton);
      }
    }
  }
  
  draw(drawTarget) {
    drawTarget.push();
    
    let pos = super.getPosition();
    drawTarget.rectMode(CENTER);
    drawTarget.fill(color(128));
    drawTarget.strokeWeight(this.strokeWeight);
    drawTarget.stroke(color(0));
    drawTarget.rect(pos.x, pos.y, this.buttonWidth * 4, this.buttonHeight * 4);
    
    /*for (let i = 0; i < this.cellsButtons.length; i++) {
      this.cellsButtons[i].draw(drawTarget);
    }*/
    
    /*for (let i = 0; i < this.triangles.length; i++) {
      this.triangles[i].draw(drawTarget); 
    }*/
    this.triangles[this.TLEFT].draw(drawTarget);
    drawTarget.pop();
  }
  
  mouseClicked() {
    
  }
}
