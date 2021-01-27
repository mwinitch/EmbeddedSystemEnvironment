
ArrayList<Ball> balls = new ArrayList<Ball>();
int begin = millis();


void setup() {
  fullScreen();
  balls.add(new Ball(100, 400, 20));
  balls.add(new Ball(700, 400, 80));
}

void draw() {
  background(250, 242, 255);

  for (Ball b : balls) {
    b.update();
    b.display();
    b.checkBoundaryCollision();
  }
  
  
  int current = millis();
  if (millis()> begin + 10000) {
    begin = millis();
    int radius = int(random(20, 80));
    balls.add(new Ball(700, 400, radius));
  }
  
}




class Ball {
  PVector position;
  PVector velocity;

  float radius, m;
  int start;

  Ball(float x, float y, float r_) {
    position = new PVector(x, y);
    velocity = PVector.random2D();
    velocity.mult(30);
    radius = r_;
    m = radius*.1;
    start = millis();
  }

  void update() {
    position.add(velocity);
  }

  void checkBoundaryCollision() {
    if (position.x > width-radius) {
      position.x = width-radius;
      velocity.x *= -1;
    } else if (position.x < radius) {
      position.x = radius;
      velocity.x *= -1;
    } else if (position.y > height-radius) {
      position.y = height-radius;
      velocity.y *= -1;
    } else if (position.y < radius) {
      position.y = radius;
      velocity.y *= -1;
    }
  }
  

  int[] getColor() {
    int current = millis();
    int diff = ((current - start) / 1000) % 60;
    int m1 = int(map(diff, 0, 59, 235, 17));
    int m2 = int(map(diff, 0, 59, 233, 0));
    int[] nums = {m1, m2};
    return nums;
  }
  
  void display() {
    noStroke();
    int[] colors = getColor();
    fill(255, colors[0], colors[1]);
    ellipse(position.x, position.y, radius*2, radius*2);
  }
}
