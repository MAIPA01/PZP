PShape obraz;
float angle = 0.f;

void setup() {
  size(500, 500);
  smooth();
  colorMode(HSB, 360, 100, 100);
  obraz = loadShape("plik2.svg");
  obraz.colorMode(HSB, 360, 100, 100);
}

void draw() {
  background(360, 100, 100);
  
  angle += 1.f;
  angle %= 360.f;
  println(angle);
  
  for(int i=0; i < obraz.getChildCount(); i++) {
    if (obraz.getChild(i) == obraz.getChild("slonce")) {
      obraz.getChild(i).translate(-340.f - sin(radians(angle + 225.f)) * 360.f, 340.f + cos(radians(angle + 225.f)) * 360.f);
      shape(obraz.getChild(i), 0, 0);
      obraz.getChild(i).translate(340.f + sin(radians(angle + 225.f)) * 360.f, -340.f - cos(radians(angle + 225.f)) * 360.f);
    }
    else if (obraz.getChild(i) == obraz.getChild("ksiezyc")) {
      obraz.getChild(i).translate(-340.f - sin(radians(angle + 45.f)) * 360.f, 340.f + cos(radians(angle + 45.f)) * 360.f);
      shape(obraz.getChild(i), 0, 0); 
      obraz.getChild(i).translate(340.f + sin(radians(angle + 45.f)) * 360.f, -340.f - cos(radians(angle + 45.f)) * 360.f);
    }
    else {
      PShape child = obraz.getChild(i);
      if (child.getChildCount() > 0) {
        for (int j = 0; j < child.getChildCount(); j++) {
          PShape grandchild = child.getChild(j);
          color kolor;
          color newKolor;
          if (grandchild.getKind() == RECT) {
            kolor = grandchild.getFill(0);
            newKolor = color(hue(kolor), saturation(kolor), brightness(kolor) / 2.f + (brightness(kolor) / 2.f) * cos(angle / 90));
            grandchild.setFill(newKolor);
            shape(grandchild, 0, 0);
            grandchild.setFill(kolor);
          }
          // PATH
          else if (grandchild.getKind() == 0 && grandchild.getFamily() == 102) {
            println(grandchild.getName());
            
            kolor = grandchild.getTint(0);
            newKolor = color(hue(kolor), saturation(kolor), brightness(kolor) / 2.f + (brightness(kolor) / 2.f) * cos(angle / 90));
            grandchild.setFill(newKolor);
            shape(grandchild, 0, 0);
            grandchild.setFill(kolor);
          }
        }
      }
      else {
        color kolor = child.getFill(0);
        color newKolor = color(hue(kolor), saturation(kolor), brightness(kolor) / 2.f + (brightness(kolor) / 2.f) * cos(angle));
        child.setFill(newKolor);
        shape(child, 0, 0);
        child.setFill(kolor);
      }
    }
  }
}
