class GameObject {
  
  constructor(x = 0, y = 0) {
    this.pos = createVector(x, y);
    this.enabled = true;
  }
   
  setPosition(x, y) {
    this.pos.x = x;
    this.pos.y = y;
  }
  
  getPosition() {
    return createVector(this.pos.x, this.pos.y); 
  }
  
  isEnabled() {
    return this.enabled; 
  }
  
  enable(enable) {
    this.enabled = enable; 
  }
  
  draw(drawTarget) {
    
  }
  
  mousePressed() {
    
  }
  
  mouseReleased() {
    
  }
  
  mouseClicked() {
    
  }
  
  mouseDragged() {
    
  }
}
