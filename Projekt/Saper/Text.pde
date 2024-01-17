class Text extends GameObject {  
  private String _text;
  private color _textColor;
  private float _textSize;
  private int _textAllign = CENTER;
  
  
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
  
  public void setAllign(int allign) {
    if (allign != LEFT && allign != RIGHT && allign != CENTER) return;
    _textAllign = allign; 
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
    // TO DOKOŃCZYĆ
    if (_textAllign == LEFT) x += w;
    else if (_textAllign == CENTER) x -= w / 2f;
    else if (_textAllign == RIGHT) x -= w;
    drawTarget.text(_text, x, pos.y + h / 2f);
    
    drawTarget.popMatrix();
    drawTarget.popStyle();
  }
}
