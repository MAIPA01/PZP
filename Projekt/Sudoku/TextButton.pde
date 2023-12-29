public class TextButton extends Button {
  private String _text;
  
  public TextButton(String text, float x, float y, float w, float h) {
   super(x, y, w, h);
   _text = text;
  }
  
  public void display() {
    super.display();
    
    pushMatrix();
    pushStyle();
    
    fill(0);
    text(_text, super._x, super._y);
    
    popStyle();
    popMatrix();
  }
}
