public class RectangleButton extends Button {
  private float _width;
  private float _height;
  
  private String _text;
  
  public RectangleButton() {
    super();
    _width = 0;
    _height = 0;
    _text = "";
  }
  
  public RectangleButton(float x, float y, float Width, float Height, String text, color Color, color selectedColor) {
   super(x, y, Color, selectedColor);
   _width = Width;
   _height = Height;
   _text = text;
  }
  
   public void draw() {
    pushMatrix();
    pushStyle();
    
    color currColor = getCurrentColor();
    
    rectMode(CENTER);
    translate(getX(), getY());
    fill(currColor);
    rect(0, 0, _width, _height);
    
    if ((red(currColor) + green(currColor) + blue(currColor)) / 3f > 128) {
     currColor = color(0); 
    }
    else {
     currColor = color(255); 
    }
    
    fill(currColor);
    textAlign(CENTER);
    textSize(_height);
    text(_text, 0, _height / 2f - 3);
    
    popStyle();
    popMatrix();
   }
   
  public boolean isIn(float x, float y) {
    return x >= getX() - _width / 2f && x <= getX() + _width / 2f && y >= getY() - _height / 2f && y <= getY() + _height / 2f;
   }
}
