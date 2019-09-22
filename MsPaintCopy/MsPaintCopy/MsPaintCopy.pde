int Yellow;
int Red;
int Green;
int Blue;
int White;
int LightGrey;
color currentColor;
boolean typeIsRect;


void setup()
{
 size(640,480);
 background(250);
 frameRate(60);

 Yellow = color(255,255,0);
 Red = color(255,0,0);
 Green = color(0,255,0);
 Blue = color(0,0,255);
 White = color(250);
 LightGrey = color(200);
 currentColor = color(102);
 typeIsRect = true;
 

}

//interface
void draw()
{
 stroke(5);
 smooth();

 fill(LightGrey);
 rect(10,10,190,70);
 
 fill(White);
 rect(140,20,50,50);   
 
 fill(Yellow);
 ellipse(30,60,20,20);
 fill(Red);
 ellipse(60,60,20,20);
 fill(Green);
 ellipse(90,60,20,20);
 fill(Blue);
 ellipse(120,60,20,20);

 
 if (mousePressed)
 {
   noStroke();
   fill(currentColor);
   if (typeIsRect)
   {
     if ((mouseX>140) && (mouseY>20) && (mouseX<190) && (mouseY<70))
     {
       rect(mouseX-25,mouseY-25,50,50);
     }
     else
     {
       rect(mouseX-10,mouseY-10,20,20);
     }
   }
   else
   {
     ellipse(mouseX,mouseY,20,20);
   }
 }
}

void mousePressed()
{
 if ((mouseX>20) && (mouseY>50) && (mouseX<40) && (mouseY<70))
 {
   typeIsRect = false;
   currentColor = color(Yellow);
 }
 if ((mouseX>50) && (mouseY>50) && (mouseX<70) && (mouseY<70))
 {
   typeIsRect = false;
   currentColor = color(Red);
 }
 if ((mouseX>80) && (mouseY>50) && (mouseX<100) && (mouseY<70))
 {
   typeIsRect = false;
   currentColor = color(Green);
 }
 if ((mouseX>110) && (mouseY>50) && (mouseX<130) && (mouseY<70))
 {
   typeIsRect = false;
   currentColor = color(Blue);
 }
}
