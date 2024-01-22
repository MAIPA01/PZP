class Button extends GameObject {
  
  constructor(x, y, w, h, col = color(255), hasStroke = false, strokeWeight = 2, strokeColor = color(0)) {
    super(x, y);
    this.w = w;
    this.h = h;
    this.col = col;
    this.hasStroke = hasStroke;
    this.strokeWeight = strokeWeight;
    this.strokeColor = strokeColor;
    this.actions = [];
  }
  
  addAction(action) {
     this.actions.push(action);
  }
  
  invoke() {
    for (let i = 0; i < this.actions.length; i++) {
      this.actions[i](); 
    }
  }
  
  draw(drawTarget) {
    drawTarget.push();
    
    drawTarget.rectMode(CENTER);
    
    if (this.hasStroke) {
      drawTarget.strokeWeight(this.strokeWeight);
      drawTarget.stroke(this.strokeColor);
    }
    else {
      drawTarget.noStroke(); 
    }
    
    drawTarget.fill(this.col);
    
    let pos = super.getPosition();
    drawTarget.translate(pos.x, pos.y);
    drawTarget.rect(0, 0, this.w, this.h);
    
    drawTarget.pop();
  }
  
  isInside(x, y) {
    let pos = super.getPosition();
    return x >= pos.x - this.w / 2 && x <= pos.x + this.w / 2 && y >= pos.y - this.h / 2 && y <= pos.y + this.h / 2;
  }
  
  mouseClicked() {
    if (this.isInside(mouseX, mouseY)) {
      this.invoke();
    }
  }
  
  setStrokeWeight(strokeWeight) {
    this.strokeWeight = strokeWeight; 
  }
  
  setStrokeColor(strokeColor) {
    this.strokeColor = strokeColor; 
  }
  
  setHasStroke(hasStroke) {
    this.hasStroke = hasStroke; 
  }
  
  setColor(Color) {
    this.col = Color; 
  }
  
  getHeight() {
    return this.h; 
  }
  
  getWidth() {
    return this.w; 
  }
  
  setWidth(w) {
    this.w = w; 
  }
  
  setHeight(h) {
    this.h = h; 
  }
}
