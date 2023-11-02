class MyEllipse { 
  private int x, y;
  private int radiusX, radiusY;
  private color fillColor;

  MyEllipse(int _x, int _y, int _radiusX, int _radiusY, color _fillColor) {
    x = _x;
    y = _y;
    radiusX = _radiusX;
    radiusY = _radiusY;
    fillColor = _fillColor;
  }
  
  MyEllipse(int _x, int _y, int _radius, color _fillColor) {
   x = _x;
   y = _y;
   radiusX = _radius;
   radiusY = _radius;
   fillColor = _fillColor;
  }

  void display() {
    noStroke();
    fill(fillColor);
    ellipse(x, y, 2*radiusX, 2*radiusY);
  }
}  
