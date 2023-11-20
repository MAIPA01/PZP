float[][] kernel;
float[][] kernel2 = { { 1.0/9.0, 1.0/9.0, 1.0/9.0 },
                     { 1.0/9.0, 1.0/9.0, 1.0/9.0 },
                     { 1.0/9.0, 1.0/9.0, 1.0/9.0 } };
float[][] kernel3 = { { 1.0/16.0, 2.0/16.0, 1.0/16.0 },
                     { 2.0/16.0, 4.0/16.0, 2.0/16.0 },
                     { 1.0/16.0, 2.0/16.0, 1.0/16.0 } };
float[][] kernel4 = { { 0.0, 0.0, 0.0 },
                     { 0.0, 0.5, 0.0 },
                     { 0.0, 0.0, 0.0 } };
float[][] kernel5 = { { 0.0, 0.0, 0.0 },
                     { 0.0, 2.0, 0.0 },
                     { 0.0, 0.0, 0.0 } };
float[][] kernel6 = { { 0.0, -1.0, 0.0 },
                     { -1.0, 5.0, -1.0 },
                     { 0.0, -1.0, 0.0 } };
float[][] kernel7 = { { -1.0, -1.0, -1.0 },
                     { -1.0, 9.0, -1.0 },
                     { -1.0, -1.0, -1.0 } };
float[][] kernel8 = { { 0.0, 1.0, 0.0 },
                     { 1.0, -4.0, 1.0 },
                     { 0.0, 1.0, 0.0 } };
float[][] kernel9 = { { -2.0, -1.0, 0.0 },
                     { -1.0, 1.0, 1.0 },
                     { 0.0, 1.0, 2.0 } };
float[][] kernel10 = { { 1.0 / 256.0, 4.0 / 256.0, 6.0 / 256.0, 4.0 / 256.0, 1.0 / 256.0 },
                       { 4.0 / 256.0, 16.0 / 256.0, 24.0 / 256.0, 16.0 / 256.0, 4.0 / 256.0 },
                       { 6.0 / 256.0, 24.0 / 256.0, 36.0 / 256.0, 24.0 / 256.0, 6.0 / 256.0 },
                       { 4.0 / 256.0, 16.0 / 256.0, 24.0 / 256.0, 16.0 / 256.0, 4.0 / 256.0 },
                       { 1.0 / 256.0, 4.0 / 256.0, 6.0 / 256.0, 4.0 / 256.0, 1.0 / 256.0 } };
PImage img, filterImg;
 
void setup() {
  size(1600, 600);  
  img = loadImage("obraz.jpg"); 
  img.loadPixels();
  filterImg = createImage(img.width, img.height, RGB);
  kernel = kernel10;
  int kymin = -(kernel.length - 1) / 2;
  int kymax = -kymin;
  int kxmin = -(kernel[0].length - 1) / 2;
  int kxmax = -kxmin;
  for (int y = -kymin; y < img.height-kymax; y++) {   
    for (int x = -kxmin; x < img.width-kxmax; x++) {  
      float sumRed = 0;   
      float sumGreen = 0;
      float sumBlue = 0;
      for (int ky = kymin; ky <= kymax; ky++) {
        for (int kx = kxmin; kx <= kxmax; kx++) {
          int pos = (y + ky)*img.width + (x + kx);
          sumRed += kernel[ky-kymin][kx-kxmin] * red(img.pixels[pos]);
          sumGreen += kernel[ky-kymin][kx-kxmin] * green(img.pixels[pos]);
          sumBlue += kernel[ky-kymin][kx-kxmin] * blue(img.pixels[pos]);
        }
      }
      filterImg.pixels[y*filterImg.width + x] = color(sumRed, sumGreen, sumBlue);
    }
  }
  filterImg.updatePixels();
  noLoop();
}
 
void draw() {
  image(filterImg, width/2, 0, width/2, height);
  filter(GRAY);
  image(img, 0, 0, width/2, height);
}
