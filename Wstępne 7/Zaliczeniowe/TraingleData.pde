class TriangleData {
    public float p1X;
  public float p1Y;
  public float p2X;
  public float p2Y;
  public float p3X;
  public float p3Y;
  
  public TriangleData(float p1X, float p1Y, float p2X, float p2Y, float p3X, float p3Y) {
   this.p1X = p1X;
   this.p1Y = p1Y;
   this.p2X = p2X;
   this.p2Y = p2Y;
   this.p3X = p3X;
   this.p3Y = p3Y;
  }
  
  public TriangleData(JSONObject json) {
    this.p1X = json.getFloat("p1X");
    this.p1Y = json.getFloat("p1Y");
    this.p2X = json.getFloat("p2X");
    this.p2Y = json.getFloat("p2Y");
    this.p3X = json.getFloat("p3X");
    this.p3Y = json.getFloat("p3Y");
  }
  
  public void draw() {
    pushMatrix();
    pushStyle();
    
    rectMode(CENTER);
    triangle(p1X, p1Y, p2X, p2Y, p3X, p3Y);
    
    popStyle();
    popMatrix();
  }
 
  public JSONObject toJSONObject() {
    JSONObject json = new JSONObject();
    json.setFloat("p1X", this.p1X);
    json.setFloat("p1Y", this.p1Y);
    json.setFloat("p2X", this.p2X);
    json.setFloat("p2Y", this.p2Y);
    json.setFloat("p3X", this.p3X);
    json.setFloat("p3Y", this.p3Y);
    return json;
  }
}
