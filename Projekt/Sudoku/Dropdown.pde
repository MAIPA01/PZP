public class Dropdown extends GameObject {
 private TextButton _btn;
 private ScrollView _sv;
 
 private boolean _svIsVisible = false;
 
 private int _currentOpt = -1;
 private HashMap<String, TextButton> _options;
 
 public Dropdown(float x, float y, int w, float btnH, int svH) {
    super(x, y);
    _btn = new TextButton("Choose Option", x, y, w, btnH);
    _btn.addAction(() -> { _svIsVisible = !_svIsVisible; });
    
    _sv = new ScrollView(x, y + svH / 2f + btnH / 2f, w, svH, 0, svH);
    _sv.setBgColor(color(164));
    _sv.setScrollColor(color(255));
    _sv.setScrollBgColor(color(200));
    _sv.setScrollWidth(20);
    
    _options = new HashMap<String, TextButton>();
 }
 
 public void display(PGraphics drawLayer) {
    drawLayer.pushMatrix();
    drawLayer.pushStyle();
   
    _btn.display(drawLayer);
    if (_svIsVisible) _sv.display(drawLayer);
    // polepszyć rysowanie opcji
    
    drawLayer.popStyle();
    drawLayer.popMatrix();
 }
 
 public void mousePressed() {
   _btn.mousePressed();
   _sv.mousePressed();
 }
 
 public void mouseReleased() {
   _sv.mouseReleased();
 }
 
 public void mouseDragged() {
   _sv.mouseDragged();
 }
 
 public void addOption(String name) {
   if (!_options.containsKey(name)) {
     PVector pos = getPosition();
     TextButton opt = new TextButton(name, pos.x, pos.y + (_btn.getHeight() + 5) * (_options.size() + 1), _btn.getWidth(), _btn.getHeight());
     opt.addAction(() -> { _currentOpt = _options.size(); _btn.setText(name); });
     _sv.addObject(opt);
     _options.put(name, opt);
     
     if ((_btn.getHeight() + 5) * (_options.size() + 2) > _sv.getScrollHeight()) {
       _sv.setMaxY((_btn.getHeight() + 5) * (_options.size()) + 5); 
     }
     
     if (_sv.getScrollHeight() < _sv.getViewHeight()) {
      _sv.enableScroll(true); 
     }
   }
 }
 
 public int getCurrentOption() {
  return _currentOpt;
 }
 
 public boolean areOptionsVisible() {
    return _svIsVisible; 
 }
}
