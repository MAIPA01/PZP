class SaperCell extends GameObject {
  private int _w, _h;
  private boolean _isBomb;
  private int _num;
  private Text _text;
  private Button _button;
  
  public SaperCell(float x, float y, int w, int h) {
    this(x, y, w, h, "B");
   _isBomb = true;
   _num = 0;
  }
  
  public SaperCell(float x, float y, int w, int h, int num) {
    this(x, y, w, h, "" + num);
    _isBomb = false;
    _num = num;
  }
  
  private SaperCell(float x, float y, int w, int h, String text) {
    super(x, y);
    enable(false);
    
    _w = w;
    _h = h;
    _text = new Text(x, y, text);
    _button = new Button(x, y, w, h);
    _button.setColor(color(225));
    _button.setHasStroke(true);
    _button.setStrokeColor(color(0));
    _button.addAction(() -> {
      enable(true);
    });
  }
  
  public void draw(PGraphics drawTarget) {
    drawTarget.pushMatrix();
    drawTarget.pushStyle();
    
    if (isEnabled()) {
      drawTarget.fill(160);
      drawTarget.rectMode(CENTER);
      PVector pos = getPosition();
      drawTarget.rect(pos.x, pos.y, _w, _h);
      
      if (_isBomb || _num != 0) {
        _text.draw(drawTarget);
      }
    }
    else {
      _button.draw(drawTarget);
    }
    
    drawTarget.popStyle();
    drawTarget.popMatrix();
  }
  
  public void mousePressed() {
    if (!isEnabled()) {
      _button.mousePressed(); 
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
}
