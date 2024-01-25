public interface DrawFunction {
   public void Invoke(QuickObject ref, PGraphics drawTarget);
}

public class QuickObject extends GameObject {
   public DrawFunction _displayFunc;
   
   public QuickObject(float x, float y, DrawFunction func) {
    super(x, y);
    _displayFunc = func;
   }
   
   @Override
   public void draw(PGraphics drawTarget) {
     drawTarget.pushMatrix();
     drawTarget.pushStyle();
     
     _displayFunc.Invoke(this, drawTarget);
     
     drawTarget.popStyle();
     drawTarget.popMatrix();
   }
}
