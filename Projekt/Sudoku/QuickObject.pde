public interface DisplayFunction {
   public void Invoke(QuickObject ref, PGraphics drawLayer);
}

public class QuickObject extends GameObject {
   public DisplayFunction _displayFunc;
   
   public QuickObject(float x, float y, DisplayFunction func) {
    super(x, y);
    _displayFunc = func;
   }
   
   public void display(PGraphics drawLayer) {
     drawLayer.pushMatrix();
     drawLayer.pushStyle();
     
     _displayFunc.Invoke(this, drawLayer);
     
     drawLayer.popStyle();
     drawLayer.popMatrix();
   }
}
