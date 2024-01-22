class QuickObject extends GameObject {
  
  constructor(x, y, drawFunc) {
    super(x, y);
    this.drawFunc = drawFunc;
  }
  
  draw(drawTarget) {
    drawTarget.push();
    
    this.drawFunc(this, drawTarget);
    
    drawTarget.pop();
  }
  
}
