// Variables used throughout the visualization keeping track of all the balls, colors, and timing
ArrayList<Ball> balls = new ArrayList<Ball>();
int begin = millis();
int backgroundRed = 255;
int backgroundGreen = 255;
int backgroundBlue = 255;

// Setup functions that makes the visual full screen and initializes with two empty new balls
void setup() {
  fullScreen();
  balls.add(new Ball(100, 400, 20));
  balls.add(new Ball(700, 400, 80));
}

// Function that does the animating
void draw() {
  
  // Update background colors
  background(backgroundRed, backgroundGreen, backgroundBlue);
  
  // Go through each ball and update its movement and color changes
  for (Ball b : balls) {
    b.update();
    b.display();
    b.checkBoundaryCollision();
  }
  
  // Every 5 seconds this code will generate a new ball to be added
  if (millis() > begin + 5000) {
    begin = millis();
    int radius = int(random(20, 80));
    balls.add(new Ball(700, 400, radius));
    
    // If there are already twenty balls on screen set back to two balls
    if (balls.size() > 20) {
      balls = new ArrayList<Ball>();
      balls.add(new Ball(100, 400, 20));
      balls.add(new Ball(700, 400, 80));
    }
    
    // Update the background color depending on the current amount of balls on the screen
    backgroundRed = int(map(balls.size(), 2, 20, 255, 0));
    backgroundGreen = int(map(balls.size(), 2, 20, 255, 154)); 
  }
  
}



// Class representing each ball
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
  

  // Used to get the new RGB color of the balls if applicable
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
