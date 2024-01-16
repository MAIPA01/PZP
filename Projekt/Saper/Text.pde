class Text extends GameObject {  
  private String _text;
  private color _textColor;
  
  public Text() {
   this(0, 0, ""); 
  }
  
  public Text(float x, float y, String text) {
    super(x, y);
   _text = text;
  }
  
  public void setColor(color textColor) {
   _textColor = textColor; 
  }
  
  public void setText(String text) {
    _text = text; 
  }
  
  public void draw(PGraphics drawTarget) {
    drawTarget.pushMatrix();
    drawTarget.pushStyle();
    
    float h = (drawTarget.textAscent() + drawTarget.textDescent()) * 0.75f;
    float w = drawTarget.textWidth(_text);
    PVector pos = getPosition();
    
    drawTarget.fill(_textColor);
    drawTarget.textSize(20);
    drawTarget.text(_text, pos.x - w / 2f, pos.y + h / 2f);
    
    drawTarget.popMatrix();
    drawTarget.popStyle();
  }
}
