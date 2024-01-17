public interface SliderAction {
 void Invoke(); 
}

public class RangeSlider extends GameObject {
  
  private float _min = 0f;
  private float _max = 1f;
  private float _w = 100f;
  private float _h = 10f;
  private ArrayList<RangeSliderHandle> _handles = new ArrayList<RangeSliderHandle>();
  private ArrayList<SliderAction> _actions = new ArrayList<SliderAction>();
  
  private int _handle = -1;
  
  RangeSlider(ArrayList<Float> values, float minValue, float maxValue, ArrayList<Integer> colors) {
    super();
    
    this._min = minValue;
    this._max = maxValue;
    this._w = 100f;
    this._h = 10f;
    this._handles = new ArrayList<RangeSliderHandle>();
    
    for (int i = 0; i < values.size(); ++i) {
      if (i + 1 < values.size()) {
        float start = this._min;
        float end = values.get(i + 1);
        if (i != 0) {
            start = values.get(i - 1);
        }
        
        color c = color(128);
        
        if (i < colors.size()) {
          c = colors.get(i);
        }
        
        RangeSliderHandle h = new RangeSliderHandle(values.get(i), start, end, c);
        h.setDiameter(this._h * 0.9);
        this._handles.add(h);
      }
      else {
        
        color c = color(128);
        
        if (i < colors.size()) {
          c = colors.get(i);
        }
        
        float start = this._min;
        
        if (i != 0) {
          start = values.get(i - 1);
        }
        
        RangeSliderHandle h = new RangeSliderHandle(values.get(i), start, this._max, c);
        h.setDiameter(this._h * 0.9);
        this._handles.add(h);
      }
    }
  }
  
  public void setSize(float w, float h) {
    this._w = w;
    this._h = h;
    
    for (int i = 0; i < this._handles.size(); ++i) {
      this._handles.get(i).setDiameter(this._h * 0.9);
    }
  }
  
   public float getHeight() {
     return this._h; 
   }
   
   public float getWidth() {
    return this._w; 
   }
   
   public void setHeight(float h) {
     this._h = h; 
   }
   
   public void setWidth(float w) {
     this._w = w; 
   }
   
   public void addAction(SliderAction a) {
     this._actions.add(a);
   }
   
   public void Invoke() {
     for (SliderAction a : this._actions) {
       a.Invoke();
     }
   }
  
  private float mapValueToPos(float value, float newMin, float newMax) {
    return map(value, this._min, this._max, newMin, newMax);
  }
  
  public void display(PGraphics drawLayer) {
    drawLayer.pushMatrix();
    drawLayer.pushStyle();
    
    if (this._handle != -1) {
      // Nie wiem czy bedzie dzialac jak sie przesunie PGraphics
      this.onDrag(this._handle, mouseX);
    }
    
    drawLayer.rectMode(CORNER);
    drawLayer.noStroke();
    drawLayer.fill(225);
    drawLayer.rect(super._pos.x, super._pos.y, this._w, this._h * 0.25, 55, 55, 55, 55);
    drawLayer.ellipseMode(CORNER);
    
    for (int h = 0; h < this._handles.size(); ++h) {
      
      float minX = super._pos.x + this.mapValueToPos(this._handles.get(h).getMinValue(), 0.0, this._w - this._h * 0.9);
      float valX = super._pos.x + this.mapValueToPos(this._handles.get(h).getValue(), 0.0, this._w - this._h * 0.9);
      float w = valX - minX;
      
      drawLayer.pushMatrix();
      drawLayer.pushStyle();
      drawLayer.fill(this._handles.get(h).getColor());
      drawLayer.rect(minX, super._pos.y, w, this._h * 0.25, 55, 55, 55, 55);
      drawLayer.popStyle();
      drawLayer.popMatrix();
    }
    
    for (int h = 0; h < this._handles.size(); ++h) {
      this._handles.get(h).setPosition(super._pos.x + this.mapValueToPos(this._handles.get(h).getValue(), 0.0, this._w - this._h * 0.9), super._pos.y - this._h * (0.9 - 0.25) * 0.5);
      this._handles.get(h).display(drawLayer);
    }    
    drawLayer.popStyle();
    drawLayer.popMatrix();
  }
  
  public Tuple2<Boolean, Integer> insideHandle(float tempX, float tempY) {
    for (int i = this._handles.size() - 1; i > -1; --i) {
      if (this._handles.get(i).inside(tempX, tempY)) {
        return new Tuple2<Boolean, Integer>(true, i);
      }
    }
    return new Tuple2<Boolean, Integer>(false, -1);
  }
  
  public void onDrag(int handleIndex, float mouseXPos) {
    float startPos = super._pos.x + this._h * 0.9 * 0.5;
    float endPos = super._pos.x + this._w - this._h * 0.9 * 0.5;
    
    if (handleIndex > 0) {
        startPos = this._handles.get(handleIndex - 1).getPosition().x + this._handles.get(handleIndex - 1).getDiameter() / 2f;
    }
    
    if (handleIndex + 1 < this._handles.size()) {
        endPos = this._handles.get(handleIndex + 1).getPosition().x + this._handles.get(handleIndex + 1).getDiameter() / 2f;
    }
    
    this._handles.get(handleIndex).onDrag(mouseXPos, startPos, endPos);
    
    for (int i = handleIndex; i < this._handles.size(); ++i) {
      if (i + 1 < this._handles.size()) {
        float start = this._min;
        float end = this._handles.get(i + 1).getValue();
        if (i != 0) {
            start = this._handles.get(i - 1).getValue();
        }
        this._handles.get(i).setRange(start, end);
      }
      else {
        
        float start = this._min;
        
        if (i != 0) {
          start = this._handles.get(i - 1).getValue();
        }
        
        this._handles.get(i).setRange(start, this._max);
      }
    }
  }
  
  public void onReleased() {
    for (int i = 0; i < this._handles.size(); ++i) {
      this._handles.get(i).drag(false);
    }
  }
  
  public ArrayList<Float> getValues() {
    ArrayList<Float> values = new ArrayList<Float>();
    
    for (int i = 0; i < this._handles.size(); ++i) {
      values.add(this._handles.get(i).getValue());
    }
    
    return values;
  }
  
  public void mousePressed() {
    Tuple2<Boolean, Integer> res = this.insideHandle(mouseX, mouseY);
  
    if (res.getFirst()) {
      this._handle = res.getSecond();
    }
  }
  
  public void mouseReleased() {
      if (this._handle != -1) {
        this._handle = -1;
        this.onReleased();
        
        this.Invoke();
      }
  }
}

class RangeSliderHandle extends GameObject {
  
  private float _min = 0f;
  private float _max = 1f;
  private float _value = 0.5f;
  private float _diameter = 9f;
  private color _c = color(#FFFFFF);
  private boolean _dragged = false;
  
  RangeSliderHandle(float value, float minValue, float maxValue, color colorValue) {
    super();
    this._value = value;
    this._min = minValue;
    this._max = maxValue;
    this._diameter = 9f;
    this._c = colorValue;
    this._dragged = false;
  }
  
  public void setDiameter(float value) {
    this._diameter = value;
  }
  
  public void setValue(float value) {
    this._value = value;
  }
  
  public void setRange(float minValue, float maxValue) {
    this._min = minValue;
    this._max = maxValue;
  }
  
  public void drag(boolean drag) {
     this._dragged = drag;
  }
  
  public float getDiameter() {
    return this._diameter;
  }
  
  public float getValue() {
    return this._value;
  }
  
  public color getColor() {
    return this._c;
  }
  
  public float getMinValue() {
    return this._min;
  }
  
  public float getMaxValue() {
    return this._max;
  }
  
  public Tuple2<Float, Float> getRange() {
    return new Tuple2<Float, Float>(this._min, this._max);
  }
  
  public void display(PGraphics drawLayer) {
    if (this._dragged) {
      drawLayer.pushMatrix();
      drawLayer.pushStyle();
      drawLayer.noStroke();
      drawLayer.fill(red(this._c), green(this._c), blue(this._c), 128);
      drawLayer.ellipseMode(CENTER);
      drawLayer.circle(super._pos.x + this._diameter / 2f, super._pos.y + this._diameter / 2f, this._diameter * 2f);
      drawLayer.popStyle();
      drawLayer.popMatrix();   
    }

    drawLayer.pushMatrix();
    drawLayer.pushStyle();
    drawLayer.stroke(255);
    drawLayer.strokeWeight(this._diameter * 0.09);
    drawLayer.fill(this._c);
    drawLayer.circle(super._pos.x, super._pos.y, this._diameter);
    drawLayer.popStyle();
    drawLayer.popMatrix();
  }
  
  public boolean inside(float tempX, float tempY) {  
    float r = this._diameter / 2.0;
    
    float x = super._pos.x + r;
    float y = super._pos.y + r;
    
    return (tempX - x) * (tempX - x) + (tempY - y) * (tempY - y) < r * r;
  }
  
  public void onDrag(float mouseXPos, float sliderStart, float sliderEnd) {
    this._dragged = true;
    this._value = map(mouseXPos, sliderStart, sliderEnd, this._min, this._max);
    if (this._value > this._max) {
      this._value = this._max;
    }
    else if (this._value < this._min) {
       this._value = this._min;
    }
  }
}
