class Text extends GameObject {  
  private String _text;
  private color _textColor;
  private float _textSize;
  private int _textAlign = CENTER;
  
  
  public Text() {
   this(0, 0, ""); 
  }
  
  public Text(float x, float y, String text) {
    super(x, y);
   _text = text;
   _textSize = 20;
  }
  
  public void setColor(color textColor) {
   _textColor = textColor; 
  }
  
  public void setText(String text) {
    _text = text; 
  }
  
  public void setTextSize(float textSize) {
    _textSize = textSize; 
  }
  
  public void setAlign(int align) {
    if (align != LEFT && align != RIGHT && align != CENTER) return;
    _textAlign = align;
  }
  
  public void draw(PGraphics drawTarget) {
    drawTarget.pushMatrix();
    drawTarget.pushStyle();
    
    drawTarget.textSize(_textSize);
    float h = (drawTarget.textAscent() + drawTarget.textDescent()) * 0.75f;
    float w = drawTarget.textWidth(_text);
    PVector pos = getPosition();
    
    drawTarget.fill(_textColor);
    float x = pos.x;
    drawTarget.textAlign(_textAlign, CENTER);
    drawTarget.text(_text, pos.x, pos.y);
    
    drawTarget.popMatrix();
    drawTarget.popStyle();
  }
}
