public class TextButton extends Button {
  private Text _text;
  
  public TextButton(String text, float x, float y, float w, float h) {
   super(x, y, w, h);
   _text = new Text(x, y, text);
   _text.setColor(color(0));
  }
  
  public void draw(PGraphics drawTarget) {
    super.draw(drawTarget);
    
    drawTarget.pushMatrix();
    drawTarget.pushStyle();
    
    _text.draw(drawTarget);
    
    drawTarget.popStyle();
    drawTarget.popMatrix();
  }
  
  public void setText(String text) {
    _text.setText(text);
  }
  
  public void setTextColor(color textColor) {
    _text.setColor(textColor);
  }
  
  public void setPosition(float x, float y) {
    this.setPosition(new PVector(x, y)); 
  }
  
  public void setPosition(PVector pos) {
    super.setPosition(pos);
    _text.setPosition(pos);
  }
}
