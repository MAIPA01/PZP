class TextButton extends Button {
  
  constructor(x, y, w, h, text) {
    super(x, y, w, h);
    this.text = new Text(x, y, text);
  }
  
  draw(drawTarget) {
    super.draw(drawTarget);
    
    drawTarget.push();
    
    this.text.draw(drawTarget);
    
    drawTarget.pop();
  }
  
  setText(text) {
    this.text.setText(text); 
  }
  
  setTextSize(size) {
    this.text.setSize(size); 
  }
  
  setTextColor(Color) {
    this.text.setColor(Color); 
  }
  
  setPosition(x, y) {
    super.setPosition(x, y);
    this.text.setPosition(x, y);
  }
}
