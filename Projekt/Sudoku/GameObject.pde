public class GameObject {
  private PVector _pos;
  
  public GameObject() {
   this(0, 0); 
  }
  
  public GameObject(float x, float y) {
    this(new PVector(x, y));
  }
  
  public GameObject(PVector pos) {
   _pos = new PVector(pos.x, pos.y);
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
  
  public void display(PGraphics drawLayer) {
    
  }
  
  public void mousePressed() {
    
  }
  
  public void mouseReleased() {
    
  }
  
  public void mouseDragged() {
    
  }
}
