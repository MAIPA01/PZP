public class TextButton extends Button {
  private String _text;
  private color _textColor;
  
  public TextButton(String text, float x, float y, float w, float h) {
   super(x, y, w, h);
   _text = text;
   _textColor = color(0);
  }
  
  public void display(PGraphics drawLayer) {
    super.display(drawLayer);
    
    drawLayer.pushMatrix();
    drawLayer.pushStyle();
    
    drawLayer.fill(_textColor);
    float textHeight = (drawLayer.textAscent() + drawLayer.textDescent()) * 0.75f;
    PVector pos = getPosition();
    drawLayer.text(_text, pos.x - drawLayer.textWidth(_text) / 2f, pos.y + textHeight / 2f);
    
    drawLayer.popStyle();
    drawLayer.popMatrix();
  }
  
  public void setText(String text) {
   _text = text; 
  }
  
  public void setTextColor(color textColor) {
   _textColor = textColor; 
  }
}
