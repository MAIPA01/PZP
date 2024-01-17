public interface DisplayFunction {
   public void Invoke(QuickObject ref, PGraphics drawTarget);
}

public class QuickObject extends GameObject {
   public DisplayFunction _displayFunc;
   
   public QuickObject(float x, float y, DisplayFunction func) {
    super(x, y);
    _displayFunc = func;
   }
   
   public void draw(PGraphics drawTarget) {
     drawTarget.pushMatrix();
     drawTarget.pushStyle();
     
     _displayFunc.Invoke(this, drawTarget);
     
     drawTarget.popStyle();
     drawTarget.popMatrix();
   }
}
