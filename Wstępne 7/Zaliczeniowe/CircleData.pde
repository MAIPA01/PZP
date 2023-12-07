class CircleData {
  public float posX;
  public float posY;
  public float r;
  
  public CircleData(float posX, float posY, float r) {
   this.posX = posX;
   this.posY = posY;
   this.r = r;
  }
  
  public CircleData(JSONObject json) {
    this.posX = json.getFloat("posX");
    this.posY = json.getFloat("posY");
    this.r = json.getFloat("r");
  }
  
  public void draw() {
    pushMatrix();
    pushStyle();
    
    rectMode(CENTER);
    circle(posX, posY, r);
    
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
