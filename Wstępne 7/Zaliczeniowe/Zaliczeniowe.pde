ArrayList<CircleData> circles = new ArrayList<CircleData>();
ArrayList<EllipseData> ellipses = new ArrayList<EllipseData>();
ArrayList<HexagonData> hexagons = new ArrayList<HexagonData>();
ArrayList<RectangleData> rectangles = new ArrayList<RectangleData>();
ArrayList<TriangleData> triangles = new ArrayList<TriangleData>();

int colorIndex = 0;

color[] bgColor = {
  color(255),
  color(197, 197, 197),
  color(254, 255, 38)
};

color[] triangleColor = {
  color(77, 80, 87),
  color(254, 93, 38),
  color(39, 39, 39)
};

color[] rectangleColor = {
  color(197, 197, 197),
  color(242, 192, 120),
  color(0, 159, 183)
};

color[] ellipseColor = {
  color(35, 150, 127),
  color(250, 237, 202),
  color(105, 103, 115)
};

color[] circleColor = {
  color(215, 38, 61),
  color(193, 219, 179),
  color(221, 110, 66)
};

color[] hexagonColor = {
  color(244, 228, 9),
  color(126, 188, 137),
  color(216, 164, 143)
};

void makeTriangles(float bL, float bR, float bU, float bD, int num) {
  for (int i = 0; i < num; i++) {
    triangles.add(new TriangleData(random(bL, bR), random(bU, bD), random(bL, bR), random(bU, bD), random(bL, bR), random(bU, bD)));
  }
}

void makeRectangles(float bL, float bR, float bU, float bD, int num) {
  for (int i = 0; i < num; i++) {
    float x = random(bL, bR);
    float y = random(bU, bD);
    float _width = 2 * min(abs(x - random(bL, bR)), abs(x - bL), abs(x - bR));
    float _height = 2 * min(abs(y - random(bU, bD)), abs(y - bU), abs(y - bD));
    rectangles.add(new RectangleData(x, y, _width, _height));
  }
}

void makeEllipses(float bL, float bR, float bU, float bD, int num) {
  for (int i = 0; i < num; i++) {
    float x = random(bL, bR);
    float y = random(bU, bD);
    float sizeX = min(abs(x - random(bL, bR)), abs(x - bL), abs(x - bR));
    float sizeY = min(abs(y - random(bU, bD)), abs(y - bU), abs(y - bD));
    ellipses.add(new EllipseData(x, y, sizeX, sizeY));
  }
}

void makeCircles(float bL, float bR, float bU, float bD, int num) {
  for (int i = 0; i < num; i++) {
    float x = random(bL, bR);
    float y = random(bU, bD);
    float r = min(min(abs(x - random(bL, bR)), abs(x - bL), abs(x - bR)), min(abs(y - random(bU, bD)), abs(y - bU), abs(y - bD)));
    circles.add(new CircleData(x, y, r));
  }
}

void makeHexagons(float bL, float bR, float bU, float bD, int num) {
  fill(hexagonColor[colorIndex]);
  for (int i = 0; i < num; i++) {
    float x = random(bL, bR);
    float y = random(bU, bD);
    float r = min(min(abs(x - random(bL, bR)), abs(x - bL), abs(x - bR)), min(abs(y - random(bU, bD)), abs(y - bU), abs(y - bD)));
    hexagons.add(new HexagonData(x, y, r));
  }
}

void setup() {
  size(800, 600);
  generate();
}

void draw() {
  background(bgColor[colorIndex]);
  
  // triangles
  fill(triangleColor[colorIndex]);
  for (int i = 0; i < triangles.size(); i++) {
     triangles.get(i).draw(); 
  }
  
  // rectangles
  fill(rectangleColor[colorIndex]);
  for (int i = 0; i < rectangles.size(); i++) {
     rectangles.get(i).draw(); 
  }
  
  // ellipses
  fill(ellipseColor[colorIndex]);
  for (int i = 0; i < ellipses.size(); i++) {
     ellipses.get(i).draw(); 
  }
  
  //circles
  fill(circleColor[colorIndex]);
  for (int i = 0; i < circles.size(); i++) {
     circles.get(i).draw(); 
  }
  
  //hexagons
  fill(hexagonColor[colorIndex]);
  for (int i = 0; i < hexagons.size(); i++) {
    hexagons.get(i).draw(); 
  }
}

void keyPressed() {
  if (key != CODED) {
   if (key == 's') {
     saveData("data/data.json");
   }
   if (key == 'l') {
     loadData("data/data.json");
   }
   if (key == 'r') {
     generate();
   }
  }
}

void generate() {
  colorIndex = (int)(random(bgColor.length));
  
  // triangles
  triangles.clear();
  makeTriangles(0f, width / 3f, 0f, height / 2f, (int)random(1, 10));
  
  // rectangles
  rectangles.clear();
  makeRectangles((2f * width) / 3f, width, height / 2f, height, (int)random(1, 10));
  
  // ellipses
  ellipses.clear();
  makeEllipses(0f, width / 3f, height / 2f, height, (int)random(1, 10));
  
  //circles
  circles.clear();
  makeCircles((2f * width) / 3f, width, 0f, height / 2f, (int)random(1, 10));
  
  //hexagons
  hexagons.clear();
  makeHexagons(width / 3f, (2f * width) / 3f, 0f, height, (int)random(1, 10)); 
}

void saveData(String path) {
   JSONObject json = new JSONObject();
   
  json.setInt("palletNr", colorIndex);
  
  // Rectangles
  JSONArray rectangleArray = new JSONArray();
  for (int i = 0; i < rectangles.size(); i++) {
     rectangleArray.setJSONObject(i, rectangles.get(i).toJSONObject());
  }
  json.setJSONArray("rectangles", rectangleArray);
  
  // Triangles
  JSONArray triangleArray = new JSONArray();
  for (int i = 0; i < triangles.size(); i++) {
     triangleArray.setJSONObject(i, triangles.get(i).toJSONObject());
  }
  json.setJSONArray("triangles", triangleArray);
  
  // Ellipses
  JSONArray ellipseArray = new JSONArray();
  for (int i = 0; i < ellipses.size(); i++) {
     ellipseArray.setJSONObject(i, ellipses.get(i).toJSONObject());
  }
  json.setJSONArray("ellipses", ellipseArray);
  
  // Circles
  JSONArray circleArray = new JSONArray();
  for (int i = 0; i < circles.size(); i++) {
     circleArray.setJSONObject(i, circles.get(i).toJSONObject());
  }
  json.setJSONArray("circles", circleArray);
  
   // Hexagons
  JSONArray hexagonArray = new JSONArray();
  for (int i = 0; i < hexagons.size(); i++) {
     hexagonArray.setJSONObject(i, hexagons.get(i).toJSONObject());
  }
  json.setJSONArray("hexagons", hexagonArray);

  saveJSONObject(json, path);
}

void loadData(String path) {
  // Load JSON file
  // Temporary full path until path problem resolved.
  JSONObject json = loadJSONObject(path);
  
  colorIndex = json.getInt("palletNr");
  
  // Rectangles
  JSONArray rectangleArray = json.getJSONArray("rectangles");
  rectangles.clear();
  for (int i = 0; i < rectangleArray.size(); i++) {
      rectangles.add(new RectangleData(rectangleArray.getJSONObject(i)));
  }

  // triangles
  JSONArray triangleArray = json.getJSONArray("triangles");
  triangles.clear();
  for (int i = 0; i < triangleArray.size(); i++) {
      triangles.add(new TriangleData(triangleArray.getJSONObject(i)));
  }
  
  // Ellipses
  JSONArray ellipseArray = json.getJSONArray("ellipses");
  ellipses.clear();
  for (int i = 0; i < ellipseArray.size(); i++) {
      ellipses.add(new EllipseData(ellipseArray.getJSONObject(i)));
  }
  
  // Circles
  JSONArray circleArray = json.getJSONArray("circles");
  circles.clear();
  for (int i = 0; i < circleArray.size(); i++) {
      circles.add(new CircleData(circleArray.getJSONObject(i)));
  }
  
  // Hexagons
  JSONArray hexagonArray = json.getJSONArray("hexagons");
  hexagons.clear();
  for (int i = 0; i < hexagonArray.size(); i++) {
      hexagons.add(new HexagonData(hexagonArray.getJSONObject(i)));
  }
}
