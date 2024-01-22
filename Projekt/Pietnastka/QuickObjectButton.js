class QuickObjectButton extends Button {
  
  constructor(x, y, w, h, drawFunc) {
    super(x, y, w, h);
    this.quickObject = new QuickObject(x, y, drawFunc);
  }
  
  draw(drawTarget) {
    super.draw(drawTarget);
    
    drawTarget.push();
    
    this.quickObject.draw(drawTarget);
    
    drawTarget.pop();
  }
  
  setPosition(x, y) {
    super.setPosition(x, y);
    this.quickObject.setPosition(x, y);
  }
  
}
