class TextButton extends Button {
  
  constructor(x, y, w, h, text) {
    super(x, y, w, h);
    this.text = new Text(x, y, text);
  }
  
  draw(drawTarget) {
    super.draw(drawTarget);
    
    drawTarget.pushMatrix();
    drawTarget.pushStyle();
    
    this.text.draw(drawTarget);
    
    drawTarget.popStyle();
    drawTarget.popMatrix();
  }
  
  setText(text) {
    this.text.setText(text); 
  }
  
  setTextColor(Color) {
    this.text.setColor(Color); 
  }
  
  setPosition(x, y) {
    super.setPosition(x, y);
    this.text.setPosition(x, y);
  }
}
