class SaperCell extends GameObject {
  private int _w, _h;
  private boolean _isBomb;
  private boolean _flaged;
  private int _num;
  private Text _text;
  private Button _button;
  
  private QuickObject _flag;
  private QuickObject _bomb;
  
  public SaperCell(float x, float y, int w, int h) {
    this(x, y, w, h, true, 0);
  }
  
  public SaperCell(float x, float y, int w, int h, int num) {
    this(x, y, w, h, false, num);
  }
  
  private SaperCell(float x, float y, int w, int h, boolean isBomb, int num) {
    super(x, y);
    enable(false);
    
    _isBomb = isBomb;
    _num = num;
    
    _w = w;
    _h = h;
    
    _button = new Button(x, y, w, h);
    _button.setColor(color(225));
    _button.setHasStroke(true);
    _button.setStrokeColor(color(0));
    _button.addAction(() -> {
      if (mouseButton == LEFT) {
        enable(true);
      }
      else if (mouseButton == RIGHT) {
        _flaged = !_flaged;
      }
    });
    
    _flag = new QuickObject(x, y, (ref, drawTarget) -> {
      drawTarget.pushMatrix();
      drawTarget.pushStyle();
      
      PVector pos = ref.getPosition();
      float scale = 15f;
      drawTarget.fill(255, 0, 0);
      drawTarget.noStroke();
      
      drawTarget.translate(pos.x, pos.y - 5);
      drawTarget.pushMatrix();
      drawTarget.rotate(radians(90));
      drawTarget.triangle(-scale / 2f, scale / 2f, 0, -scale / 2f, scale / 2f, scale / 2f);
      drawTarget.popMatrix();
      
      drawTarget.fill(0);
      drawTarget.stroke(0);
      drawTarget.strokeWeight(2);
      drawTarget.line(-7.5f, -7.5f, -7.5f, 20);
      
      drawTarget.popStyle();
      drawTarget.popMatrix();
    });
    
    if (_isBomb) {
      _bomb = new QuickObject(x, y, (ref, drawTarget) -> {
        drawTarget.pushMatrix();
        drawTarget.pushStyle();
        
        PVector pos = ref.getPosition();
        drawTarget.translate(pos.x, pos.y);
        
        drawTarget.stroke(230, 153, 0);
        drawTarget.strokeWeight(4);
        drawTarget.line(0, 0, 0, -12);
        
        drawTarget.fill(0);
        drawTarget.noStroke();
        drawTarget.rectMode(CENTER);
        drawTarget.rect(0, -1.25f, 10, 10);
        drawTarget.circle(0, 5, 20);
        
        drawTarget.popStyle();
        drawTarget.popMatrix();
      });
    }
    else if (_num != 0) {
      _text = new Text(x, y, "" + _num);
    }
  }
  
  public void draw(PGraphics drawTarget) {
    drawTarget.pushMatrix();
    drawTarget.pushStyle();
    
    if (isEnabled()) {
      drawTarget.fill(160);
      drawTarget.rectMode(CENTER);
      PVector pos = getPosition();
      drawTarget.rect(pos.x, pos.y, _w, _h);
      
      if (_isBomb) {
        _bomb.draw(drawTarget); 
      }
      else if (_num != 0) {
        _text.draw(drawTarget);
      }
    }
    else {
      _button.draw(drawTarget);
      
      if (_flaged) {
        _flag.draw(drawTarget); 
      }
    }
    
    drawTarget.popStyle();
    drawTarget.popMatrix();
  }
  
  public void mousePressed() {
    if (!isEnabled()) {
      if (!_flaged || mouseButton == RIGHT) {
        _button.mousePressed(); 
      }
    }
  }
  
  public void addAction(ButtonAction action) {
    _button.addAction(action); 
  }
  
  public void Invoke() {
    _button.Invoke();
  }
  
  public boolean isBomb() {
    return _isBomb;
  }
  
  public boolean isEmpty() {
    return _num == 0;
  }
  
  public boolean isFlaged() {
    return _flaged && !isEnabled(); 
  }
  
  public void setPosition(float x, float y) {
    this.setPosition(new PVector(x, y));
  }
  
  public void setPosition(PVector pos) {
    super.setPosition(pos);
    _flag.setPosition(pos);
    if (_isBomb) {
      _bomb.setPosition(pos); 
    }
    else if (_num != 0) {
      _text.setPosition(pos); 
    }
  }
}
