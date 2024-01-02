public class ScrollView extends GameObject {
  private ArrayList<GameObject> _objects;
  
  // View
  PGraphics _viewMask;
  
  private float _minY, _maxY;
  private float _currScrollY;
  
  private int _w, _h;
  private color _bgColor = color(0);
  
  // Scroll
  private boolean _scrollEnable = false;
  private float _scrollWidth = 1;
  private float _scrollHeight = 1;
  private color _scrollColor = color(255);
  private color _scrollBgColor = color(128);
  
  // drag
  private boolean _canDrag = false;
  private boolean _scrollDrag = false;
  private boolean _isDragging = false;
  
  public ScrollView(int w, int h, float minY, float maxY) {
   this(0, 0, w, h, minY, maxY); 
  }
  
  public ScrollView(float x, float y, int w, int h, float minY, float maxY) {
    super(x, y);
    _objects = new ArrayList<GameObject>();
    _minY = minY;
    _maxY = maxY;
    _currScrollY = _minY;
    _w = w;
    _h = h;
    
    _viewMask = createGraphics(_w, _h);
    _scrollHeight = (_viewMask.height / (_maxY - _minY)) * _viewMask.height;
  }
  
  public void addObject(GameObject obj) {
    _objects.add(obj);
  }
  
  public void setMinY(float minY) {
   _minY = minY;
   if (_minY > _maxY) {
      _minY = _maxY; 
   }
   
   if (_currScrollY < _minY) {
      _currScrollY = _minY;
   }
   
   _scrollHeight = (_viewMask.height / (_maxY - _minY)) * _viewMask.height;
  }
  
  public void setMaxY(float maxY) {
   _maxY = maxY;
   if (_maxY < _minY) {
      _maxY = _minY; 
   }
   
   if (_currScrollY > _maxY) {
     _currScrollY = _maxY; 
   }
   
   _scrollHeight = (_viewMask.height / (_maxY - _minY)) * _viewMask.height;
  }
  
  public void setViewWidth(int w) {
   _w = w;
   _viewMask = createGraphics(_w, _h);
  }
  
  public void setViewHeight(int h) {
    _h = h;
    _viewMask = createGraphics(_w, _h);
    _scrollHeight = (_viewMask.height / (_maxY - _minY)) * _viewMask.height;
  }
  
  public void setBgColor(color bg) {
   _bgColor = bg; 
  }
  
  public void enableScroll(boolean enable) {
    _scrollEnable = enable;
  }
  
  public void setScrollWidth(float w) {
    _scrollWidth = w;
  }
  
  public void setScrollColor(color scrollColor) {
    _scrollColor = scrollColor;
  }
  
  public void setScrollBgColor(color scrollBgColor) {
    _scrollBgColor = scrollBgColor;
  }
  
  public float getScrollHeight() {
     return _scrollHeight; 
  }
  
  public float getScrollWidth() {
     return _scrollWidth; 
  }
  
  public int getViewHeight() {
    return _h;
  }
  
  public int getViewWidth() {
     return _w; 
  }
  
  public boolean isScrollEnable() {
     return _scrollEnable; 
  }
  
  public void display(PGraphics drawLayer) {
   drawLayer.pushMatrix();
   drawLayer.pushStyle();
   
   drawLayer.imageMode(CENTER);
   drawLayer.noStroke();
   
   PVector viewPos = getPosition();
   
   _viewMask.beginDraw();
   
   // Draw BG
   _viewMask.background(_bgColor);
   
   // Draw Objects
   _viewMask.pushMatrix();
   _viewMask.translate(-(viewPos.x - _viewMask.width / 2f), -(viewPos.y - _viewMask.height / 2f));
   for (int i = 0; i < _objects.size(); i++) {
      _objects.get(i).display(_viewMask);
   }
   _viewMask.popMatrix();
   
   // Draw Scroll
   if (_scrollEnable) {
     _viewMask.rectMode(CENTER);
     _viewMask.noStroke();
     _viewMask.fill(_scrollBgColor);
      _viewMask.rect(_viewMask.width - _scrollWidth / 2f, _viewMask.height / 2f, _scrollWidth, _viewMask.height);
      
      float scrollPosY = map(_currScrollY, _minY, _maxY, _scrollHeight / 2f, _viewMask.height - _scrollHeight / 2f);
      _viewMask.fill(_scrollColor);
      _viewMask.rect(_viewMask.width - _scrollWidth / 2f, scrollPosY, _scrollWidth, _scrollHeight);
   }
   
   _viewMask.endDraw();
   
   drawLayer.image(_viewMask, viewPos.x, viewPos.y);
   
   drawLayer.popStyle();
   drawLayer.popMatrix();
  }
  
  boolean isInViewMask(float x, float y) {
    PVector pos = getPosition();
    return x >= pos.x - _viewMask.width / 2f && x <= pos.x + _viewMask.width / 2f && y >= pos.y - _viewMask.height / 2f && y <= pos.y + _viewMask.height / 2f;
  }
  
  boolean isInScroll(float x, float y) {
    PVector pos = getPosition();
    float scrollPosY = map(_currScrollY, _minY, _maxY, _scrollHeight / 2f, _viewMask.height - _scrollHeight / 2f);
    return x >= pos.x + _viewMask.width / 2f - _scrollWidth && x <= pos.x + _viewMask.width / 2f && y >= pos.y - _viewMask.height / 2f + scrollPosY - _scrollHeight / 2f && y <= pos.y - _viewMask.height / 2f + scrollPosY + _scrollHeight / 2f;
  }
  
  public void mousePressed() {
    if (mouseButton == LEFT && isInViewMask(mouseX, mouseY)) {
     _canDrag = true;
     if (_scrollEnable && isInScroll(mouseX, mouseY)) {
       _scrollDrag = true; 
     }
    }
  }
  
  public void mouseReleased() {
    if (!_isDragging) {
      if (isInViewMask(mouseX, mouseY)) {
        for (int i = 0; i < _objects.size(); i++) {
          _objects.get(i).mousePressed();
        }
      }
    }
    
    _canDrag = false;
    _scrollDrag = false;
    _isDragging = false;
  }
  
  public void mouseDragged() {
     if (_canDrag) {
       _isDragging = true;
       float deltaScroll = 0f;
       if (_scrollDrag) {
         float realScrollPosY = getPosition().y - _viewMask.height / 2f + map(_currScrollY, _minY, _maxY, _scrollHeight / 2f, _viewMask.height - _scrollHeight / 2f);
         deltaScroll = mouseY - realScrollPosY;
       }
       else {         
         deltaScroll = pmouseY - mouseY;
       }
       
       float desiredScrollY = _currScrollY + deltaScroll;
       print("oldDelta: " + deltaScroll + " scrollY: " + desiredScrollY);
         
       if (desiredScrollY > _maxY) { 
         desiredScrollY = _maxY;
         deltaScroll = desiredScrollY - _currScrollY;
         
         // coś nie działa ze scrollem TODO
       }
       if (desiredScrollY < _minY) {
         desiredScrollY = _minY;
         deltaScroll = desiredScrollY - _currScrollY;
       }
       print(" -> " + desiredScrollY + " currScroll: " + _currScrollY);
       
       _currScrollY = desiredScrollY;
       
       println(" new delta: " + deltaScroll);
       
       for (int i = 0; i < _objects.size(); i++) {
          PVector oldPos = _objects.get(i).getPosition();
          _objects.get(i).setPosition(oldPos.x, oldPos.y - deltaScroll);
       }
     }
  }
}
