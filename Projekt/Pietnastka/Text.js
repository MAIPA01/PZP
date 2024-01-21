class Text extends GameObject {
  
  constructor(x, y, text) {
    super(x, y);
    this.text = text;
    this.textColor = color(0);
    this.textSize = 20;
    this.textAlign = CENTER;
  }
  
  setColor(Color) {
    this.textColor = Color;
  }
  
  setText(text) {
    this.text = text; 
  }
  
  setSize(size) {
    this.textSize = size; 
  }
  
  setAlign(align) {
    this.textAlign = align; 
  }
  
  draw(drawTarget) {
    drawTarget.pushMatrix();
    drawTarget.pushStyle();
    
    drawTarget.textSize(this.textSize);
    drawTarget.fill(this.textColor);
    drawTarget.textAlign(this.textAlign, CENTER);
    
    pos = super.getPosition();
    drawTarget.text(this.text, pos.x, pos.y);
    
    drawTarget.popStyle();
    drawTarget.popMatrix();
  }
}
