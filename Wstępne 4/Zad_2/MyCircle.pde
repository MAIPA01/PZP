class MyCircle extends MyEllipse {
 
  MyCircle(int _x, int _y, int _radius, color _fillColor) {
   super(_x, _y, _radius, _fillColor); 
  }
  
  color getColor() {
   return super.fillColor; 
  }
  
  boolean IsIn(int _x, int _y) {
   return sqrt(pow(_x - super.x, 2) + pow(_y - super.y, 2)) <= super.radiusX;
  }
}
