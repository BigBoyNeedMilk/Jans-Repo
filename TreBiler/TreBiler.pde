Car rect1;
Car rect2;
Car rect3;

void setup() {
  size(640, 360);
  rect1 = new Car(color(51), 0, 100, 2); 
  rect2 = new Car(color(151), 0, 300, 1);
  rect3 = new Car(color(151), 0, 200, 69);
}

void draw() {
  background(255);
  rect1.move();
  rect1.display();
  rect2.move();
  rect2.display();
  rect3.move();
  rect3.display();
}

class Car {
  color c;
  float xpos;
  float ypos;
  float xspeed;

  Car(color tempC, float tempXpos, float tempYpos, float tempXspeed) { // The Constructor is defined with arguments.
    c = tempC;
    xpos = tempXpos;
    ypos = tempYpos;
    xspeed = tempXspeed;
  }

  void display() {
    stroke(0);
    fill(c);
    ellipseMode(CENTER);
    ellipse(xpos, ypos, 69, 10);
  }

  void move() {
    xpos = xpos + xspeed;
    if (xpos > width || xpos == 0) {
      xspeed = xspeed * -1;
    }
  }
}
