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
  private color _scrollColor = color(255);
  private color _scrollBgColor = color(128);
  
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
  }
  
  public void setMaxY(float maxY) {
   _maxY = maxY;
   if (_maxY < _minY) {
      _maxY = _minY; 
   }
   
   if (_currScrollY > _maxY) {
     _currScrollY = _maxY; 
   }
  }
  
  public void setViewWidth(int w) {
   _w = w; 
  }
  
  public void setViewHeight(int h) {
    _h = h;
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
  
  public void display() {
   pushMatrix();
   pushStyle();
   
   imageMode(CENTER);
   noStroke();
   
   PVector viewPos = getPosition();
   if (_currScrollY > _maxY) _currScrollY = _maxY;
   if (_currScrollY < _minY) _currScrollY = _minY;
   
   _viewMask.beginDraw();
   
   // Draw BG
   _viewMask.background(_bgColor);
   
   // Draw Objects
   // TODO
   // Test Object
   _viewMask.rectMode(CENTER);
   _viewMask.fill(color(255));
   PVector originalGlobalPos = new PVector(width / 2f, height / 2f);
   PVector transformedToView = new PVector(originalGlobalPos.x - (viewPos.x - _viewMask.width / 2f), originalGlobalPos.y - (viewPos.y - _viewMask.height / 2f));
   _viewMask.rect(transformedToView.x, transformedToView.y - _currScrollY, 100, 100);
   
   originalGlobalPos = new PVector(width / 2f, height / 2f + _maxY);
   transformedToView = new PVector(originalGlobalPos.x - (viewPos.x - _viewMask.width / 2f), originalGlobalPos.y - (viewPos.y - _viewMask.height / 2f));
   _viewMask.rect(transformedToView.x, transformedToView.y - _currScrollY, 100, 100);
   
   // Draw Scroll
   if (_scrollEnable) {
     _viewMask.noStroke();
     _viewMask.fill(_scrollBgColor);
      _viewMask.rect(_viewMask.width - _scrollWidth / 2f, _viewMask.height / 2f, _scrollWidth, _viewMask.height);
      
      float scrollHeight = (_viewMask.height / (_maxY - _minY)) * _viewMask.height;
      float scrollPosY = map(_currScrollY, _minY, _maxY, scrollHeight / 2f, _viewMask.height - scrollHeight / 2f);
      _viewMask.fill(_scrollColor);
      _viewMask.rect(_viewMask.width - _scrollWidth / 2f, scrollPosY, _scrollWidth, scrollHeight);
   }
   
   _viewMask.endDraw();
   
   image(_viewMask, viewPos.x, viewPos.y);
   
   popStyle();
   popMatrix();
  }
  
  public void mousePressed() {
     _currScrollY += 20f;
  }
}
