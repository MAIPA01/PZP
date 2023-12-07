class EllipseData {
  public float posX;
  public float posY;
  public float rX;
  public float rY;
  
  public EllipseData(float posX, float posY, float rX, float rY) {
   this.posX = posX;
   this.posY = posY;
   this.rX = rX;
   this.rY = rY;
  }
  
  public EllipseData(JSONObject json) {
    this.posX = json.getFloat("posX");
    this.posY = json.getFloat("posY");
    this.rX = json.getFloat("rX");
    this.rY = json.getFloat("rY");
  }
  
  public void draw() {
    pushMatrix();
    pushStyle();
    
    rectMode(CENTER);
    ellipse(posX, posY, rX, rY);
    
    popStyle();
    popMatrix();
  }
  
  public JSONObject toJSONObject() {
    JSONObject json = new JSONObject();
    json.setFloat("posX", this.posX);
    json.setFloat("posY", this.posY);
    json.setFloat("rX", this.rX);
    json.setFloat("rY", this.rY);
    return json;
  }
}
