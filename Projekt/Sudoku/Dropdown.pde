import java.util.*;

public class Dropdown extends GameObject {
 private TextButton _btn;
 private ScrollView _sv;
 
 private boolean _svIsVisible = false;
 
 private int _currentOpt = -1;
 private GameObject _currentDot = null;
 private LinkedHashMap<String, TextButton> _options;
 
 private QuickObject _triangle;
 
 public Dropdown(float x, float y, int w, float btnH, int svH) {
    super(x, y);
    _btn = new TextButton("Choose Option", x, y, w, btnH);
    _btn.addAction(new ButtonAction() {
       @Override
       public void Invoke() {
          _svIsVisible = !_svIsVisible;
        }
    });
    
    _sv = new ScrollView(x, y + svH / 2f + btnH / 2f, w, svH, 0, svH);
    _sv.setBgColor(color(164));
    _sv.setScrollColor(color(255));
    _sv.setScrollBgColor(color(200));
    _sv.setScrollWidth(20);
    
    _options = new LinkedHashMap<String, TextButton>();
    
    _triangle = new QuickObject(0, 0, new DrawFunction() {
         @Override
         public void Invoke(QuickObject ref, PGraphics drawLayer) {
         drawLayer.fill(0);
         drawLayer.noStroke();
         
         // triangle
         drawLayer.triangle(0.f, 0.5f, 0.5f, -0.5f, -0.5f, -0.5f);
         
         drawLayer.endShape(CLOSE);
         }
     });
 }
 
 @Override
  public void setPosition(float x, float y) {
    this.setPosition(new PVector(x, y));
  }
  
  @Override
  public void setPosition(PVector pos) {
    super.setPosition(pos);
    _btn.setPosition(pos);
    _sv.setPosition(pos.x, pos.y + _sv.getViewHeight() / 2f + _btn.getHeight() / 2f);
  }
 
 @Override
 public void draw(PGraphics drawTarget) {
    drawTarget.pushMatrix();
    drawTarget.pushStyle();
   
    _btn.draw(drawTarget);
    if (_svIsVisible) { 
      _sv.draw(drawTarget);
      
      // draw triangle up
      drawTarget.pushMatrix();
      drawTarget.translate(getPosition().x + _btn.getWidth() / 2f - 10f, getPosition().y);
      drawTarget.scale(10 * displayDensity);
      drawTarget.rotate(radians(180));
      _triangle.draw(drawTarget);
      drawTarget.popMatrix();
    }
    else {
      // draw triangle down
      drawTarget.pushMatrix();
      drawTarget.translate(getPosition().x + _btn.getWidth() / 2f - 10f, getPosition().y);
      drawTarget.scale(10 * displayDensity);
      _triangle.draw(drawTarget);
      drawTarget.popMatrix();
    }
    
    drawTarget.popStyle();
    drawTarget.popMatrix();
 }
 
 @Override
 public void touchStarted() {
   _btn.touchStarted();
   if (_svIsVisible) _sv.touchStarted();
 }
 
 @Override
 public void touchEnded() {
   _btn.touchEnded();
   if (_svIsVisible) _sv.touchEnded();
 }
 
 @Override
 public void touchMoved() {
   if (_svIsVisible) _sv.touchMoved();
 }
 
 public void setScrollWidth(float sw) {
   _sv.setScrollWidth(sw);
 }
 
 public void setTextSize(float size) {
    _btn.setTextSize(size);
    for (int i = 0; i < _options.size(); i++) {
      ((TextButton)_options.values().toArray()[i]).setTextSize(size);
    }
 }
 
 public void addOption(String name) {
   if (!_options.containsKey(name)) {
     PVector pos = getPosition();
     
     float spacing = 5 * displayDensity;
     
     // Dot
     float dotRadius = 10f * displayDensity;
     QuickObject dot = new QuickObject(pos.x - (_btn.getWidth() / 2f) + dotRadius, pos.y + (_btn.getHeight() + spacing) * (_options.size() + 1) + spacing, new DrawFunction() {
       @Override
       public void Invoke(QuickObject ref, PGraphics drawLayer) {
         drawLayer.rectMode(CENTER);
         drawLayer.fill(0);
         drawLayer.noStroke();
         drawLayer.circle(ref.getPosition().x, ref.getPosition().y, dotRadius);
       }
     });
     dot.enable(false);
     _sv.addObject(dot);
     
     // Option Button
     TextButton opt = new TextButton(name, pos.x + dotRadius - spacing / 2f, pos.y + (_btn.getHeight() + spacing) * (_options.size() + 1) + spacing, _btn.getWidth() - spacing - 2f * dotRadius, _btn.getHeight());
     final int optNum = _options.size();
     opt.addAction(new ButtonAction() {
       @Override
       public void Invoke() {
         // Option
         _currentOpt = optNum;
         
         // Dropdown Button
         _btn.setText(name);
         
         // Dot
         if (_currentDot != null) _currentDot.enable(false); 
         dot.enable(true); 
         _currentDot = dot;
       }
     });
     _sv.addObject(opt);
     _options.put(name, opt);
     
     if ((_btn.getHeight() + spacing) * _options.size() + spacing > _sv.getScrollHeight()) {
       _sv.setMaxY((_btn.getHeight() + spacing) * _options.size() + spacing); 
     }
     
     if (_sv.getScrollHeight() < _sv.getViewHeight() && !_sv.isScrollEnable()) {
      _sv.enableScroll(true);
      
      for (TextButton _opt : _options.values()) {
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
   if (optIndex < 0 || optIndex >= _options.size()) return;
   ((TextButton)_options.values().toArray()[optIndex]).Invoke();
 }
 
 public int getCurrentOption() {
  return _currentOpt;
 }
 
 public boolean areOptionsVisible() {
    return _svIsVisible; 
 }
}
