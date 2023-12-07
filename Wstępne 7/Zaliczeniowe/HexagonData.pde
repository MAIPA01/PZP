class HexagonData {
    public float posX;
  public float posY;
  public float r;
  
  public HexagonData(float posX, float posY, float r) {
   this.posX = posX;
   this.posY = posY;
   this.r = r;
  }
  
  public HexagonData(JSONObject json) {
    this.posX = json.getFloat("posX");
    this.posY = json.getFloat("posY");
    this.r = json.getFloat("r");
  }
  
  void drawFigure(float x, float y, float radius, int npoints) {
    float angle = TWO_PI / npoints;
    beginShape();
      for (float a = 0; a < TWO_PI; a += angle) {
        float sx = x + cos(a) * radius;
        float sy = y + sin(a) * radius;
        vertex(sx, sy);
      }
    endShape(CLOSE);
  }
  
  public void draw() {
        pushMatrix();
    pushStyle();
    
    rectMode(CENTER);
    drawFigure(posX, posY, r, 6);
    
    popStyle();
    popMatrix();
  }
  
  public JSONObject toJSONObject() {
    JSONObject json = new JSONObject();
    json.setFloat("posX", this.posX);
    json.setFloat("posY", this.posY);
    json.setFloat("r", this.r);
    return json;
  }
}
