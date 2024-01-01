public class TextButton extends Button {
  private String _text;
  private color _textColor;
  
  public TextButton(String text, float x, float y, float w, float h) {
   super(x, y, w, h);
   _text = text;
   _textColor = color(0);
  }
  
  public void display() {
    super.display();
    
    pushMatrix();
    pushStyle();
    
    fill(_textColor);
    float textHeight = (textAscent() + textDescent()) * 0.75f;
    PVector pos = getPosition();
    text(_text, pos.x - textWidth(_text) / 2f, pos.y + textHeight / 2f);
    
    popStyle();
    popMatrix();
  }
  
  public void setText(String text) {
   _text = text; 
  }
  
  public void setTextColor(color textColor) {
   _textColor = textColor; 
  }
}
