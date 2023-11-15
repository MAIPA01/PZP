public class Slider {
  private float _x;
  private float _y;
  
  private float _width;
  private float _height;
  
   private float _value;
   private float _maxValue;
   private float _minValue;
   
   private TextButton _handler;
   
   private boolean _dragging = false;
   
   public Slider(float x, float y, float Width, float Height, float minValue, float maxValue) {
    _x = x;
    _y = y;
    _width = Width;
    _height = Height;
    
    _minValue = minValue;
    _maxValue = maxValue;
    
    _handler = new TextButton(-_width / 2f, 0, _width * 0.1f, _height * 1.1f, color(0), color(0), "", 1, color(0), null);
   }
   
   public void draw() {
     pushMatrix();
     pushStyle();
     translate(_x, _y);
     fill(200);
     rect(0, 0, _width, _height);
     _handler.draw();
     
     if (_dragging) {
       float posChange = mouseX - pmouseX;
       _handler.setX(_handler.getX() + posChange);
       if (_handler.getX() > _width / 2f) {
         _handler.setX(_width / 2f);
       }
       if (_handler.getX() < -_width / 2f) {
        _handler.setX(-_width / 2f); 
       }
       _value = (_handler.getX() + _width / 2f) / _width;
     }
     
     popStyle();
     popMatrix();
   }
   
   public void mousePressed() {
     if (_handler.isIn(mouseX - _x, mouseY - _y)) {
      _dragging = true;
     }
   }
   
   public void mouseReleased() {
    _dragging = false; 
   }
   
   public float getValue() {
      return _minValue + (_maxValue - _minValue) * _value; 
   }
}
