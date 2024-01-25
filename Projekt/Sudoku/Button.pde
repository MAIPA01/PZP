public interface ButtonAction {
 void Invoke(); 
}

public float clamp(float x, float min, float max) {
  return x > max ? max : (x < min ? min : x); 
}

public class Button extends GameObject {
 private float _w, _h;
 private color _color;
 private boolean _hasStroke;
 private float _strokeWeight;
 private color _strokeColor;
 private ArrayList<ButtonAction> _actions = new ArrayList<ButtonAction>();
 
 private float _touchMaxHoldTime = 1;
 private float _touchHoldTimer = 0;
 private boolean _touchStarted = false;
 private boolean _touchStartedInside = false;
 
 Button(PVector pos, float w, float h) {
   this(pos.x, pos.y, w, h);
 }
 
 Button(float x, float y, float w, float h) {
  this(x, y, w, h, color(255)); 
 }
 
 Button(float x, float y, float w, float h, color col) {
   this(x, y, w, h, col, false, 0, color(0));
 }
 
 Button(float x, float y, float w, float h, color col, boolean hasStroke, float strokeWeight, color strokeColor) {
  super(x, y);
  _w = w;
  _h = h;
  _color = col;
  _hasStroke = hasStroke;
  _strokeWeight = strokeWeight;
  _strokeColor = strokeColor;
 }
 
 public void addAction(ButtonAction a) {
  _actions.add(a); 
 }
 
 public void Invoke() {
   for (ButtonAction a : _actions) {
     a.Invoke();
   }
 }
 
 @Override
 public void draw(PGraphics drawTarget) {
    drawTarget.pushMatrix();
    drawTarget.pushStyle();
    
    if (_touchStarted) {
       _touchHoldTimer -= 1f / frameRate;
    }
    
    drawTarget.rectMode(CENTER);
    if (_hasStroke) {
     drawTarget.strokeWeight(_strokeWeight);
     drawTarget.stroke(_strokeColor);
    }
    else {
     drawTarget.noStroke(); 
    }
    drawTarget.fill(_color);
    PVector pos = getPosition();
    drawTarget.translate(pos.x, pos.y);
    drawTarget.rect(0, 0, _w, _h);

    drawTarget.popStyle();
    drawTarget.popMatrix();
 }
 
 public boolean isInside(float x, float y, float area) {
   PVector pos = getPosition();
   float nearestX = clamp(x, pos.x - _w / 2f, pos.x + _w / 2f);
   float nearestY = clamp(y, pos.y - _h / 2f, pos.y + _h / 2f);
   return pow(nearestX - x, 2) + pow(nearestY - y, 2) < area;
 }
 
 @Override
 public void touchStarted() {
   if (!_touchStarted) {
    for (int i = 0; i < touches.length; i++) {
      if (touches[i].id == 0) {
        _touchStartedInside = isInside(touches[i].x, touches[i].y, touches[i].area);
        if (_touchStartedInside) {
          _touchStarted = true;
          _touchHoldTimer = _touchMaxHoldTime;
        }
      }
    }
  }
 }
 
 @Override
 public void touchEnded() {
   if (_touchStarted && _touchStartedInside) {
      boolean found = false;
      for (int i = 0; i < touches.length; i++) {
        if (touches[i].id == 0) {
          found = true;
        }
      }
      
      if (!found) {
        if (_touchHoldTimer >= 0) {
          Invoke();
        }
        _touchStarted = false;
        _touchStartedInside = false;
      }
   }
 }
 
 public void setStrokeWeight(float strokeWeight) {
   _strokeWeight = strokeWeight;
 }
 
 public void setStrokeColor(color strokeColor) {
   _strokeColor = strokeColor;
 }
 
 public void setHasStroke(boolean hasStroke) {
   _hasStroke = hasStroke;
 }
 
 public void setColor(color Color) {
   _color = Color;
 }
 
 public float getHeight() {
   return _h; 
 }
 
 public float getWidth() {
  return _w;
 }
 
 public void setWidth(float w) {
   _w = w;
 }
 
 public void setHeight(float h) {
   _h = h;
 }
}
