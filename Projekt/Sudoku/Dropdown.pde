public class Dropdown extends GameObject {
 private TextButton _btn;
 private ScrollView _sv;
 
 private boolean _svIsVisible = false;
 
 private int _currentOpt = -1;
 private GameObject _currentDot = null;
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
     
     // Dot
     float dotRadius = 10f;
     QuickObject dot = new QuickObject(pos.x - (_btn.getWidth() / 2f) + dotRadius, pos.y + (_btn.getHeight() + 5) * (_options.size() + 1), (QuickObject ref, PGraphics drawLayer) -> {
       drawLayer.rectMode(CENTER);
       drawLayer.fill(0);
       drawLayer.noStroke();
       drawLayer.circle(ref.getPosition().x, ref.getPosition().y, dotRadius);
     });
     dot.enable(false);
     _sv.addObject(dot);
     
     // Option Button
     TextButton opt = new TextButton(name, pos.x + dotRadius - 2.5f, pos.y + (_btn.getHeight() + 5) * (_options.size() + 1), _btn.getWidth() - 5f - 2f * dotRadius, _btn.getHeight());
     opt.addAction(() -> {
       // Option
       _currentOpt = _options.size();
       
       // Dropdown Button
       _btn.setText(name);
       
       // Dot
       if (_currentDot != null) _currentDot.enable(false); 
       dot.enable(true); 
       _currentDot = dot; 
     });
     _sv.addObject(opt);
     _options.put(name, opt);
     
     if ((_btn.getHeight() + 5) * (_options.size() + 2) > _sv.getScrollHeight()) {
       _sv.setMaxY((_btn.getHeight() + 5) * (_options.size()) + 5); 
     }
     
     if (_sv.getScrollHeight() < _sv.getViewHeight() && !_sv.isScrollEnable()) {
      _sv.enableScroll(true);
      
      for (var _opt : _options.values()) {
         _opt.setWidth(_opt.getWidth() - _sv.getScrollWidth());
         PVector _optPos = _opt.getPosition();
         _opt.setPosition(_optPos.x - _sv.getScrollWidth() / 2f, _optPos.y);
      }
     }
     else if (_sv.getScrollHeight() < _sv.getViewHeight() && _sv.isScrollEnable()) {
        opt.setWidth(opt.getWidth() - _sv.getScrollWidth());
        PVector optPos = opt.getPosition();
        opt.setPosition(optPos.x - _sv.getScrollWidth() / 2f, optPos.y);
     }
   }
 }
 
 public void setCurrentOption(String optName) {
   if (_options.containsKey(optName)) {
      _options.get(optName).Invoke();
   }
 }
 
 public void setCurrentOption(int optIndex) {
   if (optIndex < 0 || optIndex > _options.size()) return;
   ((TextButton)_options.values().toArray()[_currentOpt]).Invoke();
 }
 
 public int getCurrentOption() {
  return _currentOpt;
 }
 
 public boolean areOptionsVisible() {
    return _svIsVisible; 
 }
}
