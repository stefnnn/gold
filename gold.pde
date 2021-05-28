Gold gold;
Fog fog;

int span = 150;
int maxSize = 6;
boolean hasFog = false;
boolean movieStart = true;

color[] goldColors = {
    color(184,134,11),
    color(218,165,32),
    color(238,232,170),
    color(255,219,88),
    color(153,101,21),
    color(133,117,78),
    color(183,135,39),
    color(255,204,0),
    color(139,69,19),
    color(255,215,0)
};


/*void settings() {
  fullScreen();
}*/

void setup() {
  //size(1440, 900);
  size(300, 800);  //, FX2D);
  gold = new Gold(new PVector(width/2, 10));
  gold.addParticles(1);
  if (hasFog) fog = createFog();
  setupMovie();
}

void draw() {
  background(0);
  gold.addParticles(5);
  if (hasFog) fog.draw();
  gold.run();
  recordMovie();
}


// A class to describe a group of Particles
// An ArrayList is used to manage the list of Particles 

class Gold {
  ArrayList<GoldParticle> particles;
  PVector origin;

  Gold(PVector position) {
    origin = position.copy();
    particles = new ArrayList<GoldParticle>();
  }

  void addParticles(int n) {
    for (int i=0; i<n; i++) {
      particles.add(new GoldParticle(origin));
    }
  }

  void addParticle() {
    particles.add(new GoldParticle(origin));
  }

  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      GoldParticle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
}



// A simple Particle class
class GoldParticle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  color col;
  int size;
  float glow;
  
  GoldParticle(PVector l) {
    acceleration = new PVector(0, 0.05);
    velocity = new PVector(random(-0.5, 0.5), random(0, 4));
    position = l.copy();
    lifespan = span;
    col = goldColors[int(random(0, goldColors.length))];
    size = int(random(1, maxSize));
    glow = float(int(random(0, span)));
  }

  void run() {
    update();
    display();
  }

  // Method to update position
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= 1.0;
  }

  // Method to display
  void display() {
    noStroke();
    color c = col;
    float dist = abs(lifespan - glow);
    float sz = 1;
    if (dist < 10) {
      float d = (10 - dist);
      sz = 1 + d/20;
      c = lighten(c, d/10);
    }
    fill(c);  
    ellipse(position.x, position.y, size*sz, size*sz);
  }

  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
  
  color lighten(color c, float d) {
    float r = red(c) + (255-red(c))*d;
    float g = green(c) + (255-green(c))*d;
    float b = blue(c) + (255-blue(c))*d;
    return color(r, g, b);
  }
}
