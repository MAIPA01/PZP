class RectangleData {
    public float posX;
  public float posY;
  public float _width;
  public float _height;
  
  public RectangleData(float posX, float posY, float _width, float _height) {
   this.posX = posX;
   this.posY = posY;
   this._width = _width;
   this._height = _height;
  }
  
  public RectangleData(JSONObject json) {
    this.posX = json.getFloat("posX");
    this.posY = json.getFloat("posY");
    this._width = json.getFloat("width");
    this._height = json.getFloat("height");
  }
  
  public void draw() {
    pushMatrix();
    pushStyle();
    
    rectMode(CENTER);
    rect(posX, posY, _width, _height);
    
    popStyle();
    popMatrix();
  }
  
  public JSONObject toJSONObject() {
    JSONObject json = new JSONObject();
    json.setFloat("posX", this.posX);
    json.setFloat("posY", this.posY);
    json.setFloat("width", this._width);
    json.setFloat("height", this._height);
    return json;
  }
}
