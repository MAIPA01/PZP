XML xml, frekwencje[], wojewodztwa[];
PShape mapa;
PrintWriter pw;

 void setup() {
   size(750, 500);
   noLoop();
   xml = loadXML("plik1.xml");
   frekwencje = xml.getChild("glosowanie").getChildren("frekwencja");
   wojewodztwa = xml.getChild("wojewodztwa").getChildren("wojewodztwo");
   
   mapa = loadShape("plik1.svg");
   
   pw = createWriter("test2.txt");
}

void draw() {
  textMode(CENTER);
  fill(0);
  textSize(100);
  textAlign(CENTER);
  text("WCZYTANO", width/2, height/2);
  String[] strings = new String[wojewodztwa.length];
  for(int i=0; i<wojewodztwa.length; i++) {
     String text = "";
     text += wojewodztwa[i].getInt("id");
     text += ". ";
     text += wojewodztwa[i].getContent();
     text += " - ";
     color fill = color(0);
     String frek = "";
     for(int j=0; j<frekwencje.length; j++) {
       if(frekwencje[j].getInt("wojewodztwo") == wojewodztwa[i].getInt("id")) {
          text += frekwencje[j].getContent();
          text += frekwencje[j].getString("jednostka");
          
          fill = color(int(frekwencje[j].getContent()) * 2.55);
          frek = frekwencje[j].getContent() + frekwencje[j].getString("jednostka");
       }
      }
     println(text);
     strings[i] = text;
     pw.println(text);
     
     PShape woj = mapa.getChild(wojewodztwa[i].getContent());
     woj.setFill(fill);
     shape(woj, 0, 0);
     if (red(fill) > 128) {
      fill(0); 
     }
     else {
      fill(255); 
     }
     textSize(10);
     float middleX = 0f, middleY = 0f;
     for (int j = 0; j < woj.getVertexCount(); j++) {
      middleX += woj.getVertex(j).x;
      middleY += woj.getVertex(j).y;
     }
     middleX /= woj.getVertexCount();
     middleY /= woj.getVertexCount();
     text(frek, middleX, middleY);
     
     fill(fill);
     rect(width - 30, 30 + 20 * i, 10, 10);
     textAlign(RIGHT);
     fill(0);
     text(text, width - 40, 40 + 20 * i);
  }
  saveStrings("test.txt", strings);
  pw.flush();
  pw.close();
}
