int radius;
PVector position;
PVector velocity;
PVector gravity;

void setup() { 
  size(640, 360);
  fill(0);
  noStroke();
  ellipseMode(RADIUS);
  radius = 60;
  position = new PVector(width / 2, height / 4);
  velocity = new PVector(3.0, 3.0);
  gravity = new PVector(0, 0.4);
}

void draw() {
  background(250);
  if(position.x + velocity.x > width-radius || position.x + velocity.x < radius)
    velocity.x *= -0.9;
  if(position.y + velocity.y > height-radius || position.y + velocity.y < radius)
    velocity.y *= -0.9;
  position.add(velocity);
  position.add(gravity);
  circle(position.x, position.y, radius);
}
