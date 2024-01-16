public class GameObject {
  private PVector _pos;
  private boolean _enabled;
  
  public GameObject() {
   this(0, 0); 
  }
  
  public GameObject(float x, float y) {
    this(new PVector(x, y));
  }
  
  public GameObject(PVector pos) {
   _pos = new PVector(pos.x, pos.y);
   _enabled = true;
  }
  
  public void setPosition(float x, float y) {
    setPosition(new PVector(x, y));
  }
  
  public void setPosition(PVector pos) {
    _pos.x = pos.x;
    _pos.y = pos.y;
  }
  
  public PVector getPosition() {
    return _pos;
  }
  
  public boolean isEnabled() {
     return _enabled; 
  }
  
  public void enable(boolean enable) {
     _enabled = enable;
  }
  
  public void draw(PGraphics drawTarget) {
    
  }
  
  public void mousePressed() {
    
  }
  
  public void mouseReleased() {
    
  }
  
  public void mouseDragged() {
    
  }
}
