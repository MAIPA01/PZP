ArrayList<MyCircle> circleList;

void setup() {
  size(500, 500);
  circleList = new ArrayList<MyCircle>();
  circleList.add(new MyCircle(250, 250, 200, color(255, 255, 0)));
  circleList.add(new MyCircle(250, 250, 100, color(255, 0, 0)));
}

void draw() {
  for(int i=0; i<circleList.size(); i++) {
    circleList.get(i).display();
    if (circleList.get(i).IsIn(mouseX, mouseY)) {
      background(circleList.get(i).getColor());
    }
  }
}
