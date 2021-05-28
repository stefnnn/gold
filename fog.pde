
int numFogs = 60;

Fog createFog() {
  PImage img = loadImage("fog_s.png");
  return new Fog(10, new PVector(width/2, -100), img);
}

class Fog {

  ArrayList<FogParticle> particles;    
  PVector origin;                
  PImage img;

  Fog(int num, PVector v, PImage img_) {
    particles = new ArrayList<FogParticle>();        
    origin = v.copy();                          
    img = img_;
    for (int i = 0; i < num; i++) {
      PVector o =new PVector(origin.x, origin.y - random(400, 1600));
      particles.add(new FogParticle(o, img));
    }
  }

  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      FogParticle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
        particles.add(new FogParticle(origin, img));
      }
    }
  }
  
  void draw() {
    // Calculate a "wind" force based on mouse horizontal position
    float dx = map(mouseX, 0, width, -0.2, 0.2);
    PVector wind = new PVector(dx, 0);
    applyForce(wind);
    run();
  }

  // Method to add a force vector to all particles currently in the system
  void applyForce(PVector dir) {
    // Enhanced loop!!!
    for (FogParticle p : particles) {
      p.applyForce(dir);
    }
  }  

  void addParticle() {
    particles.add(new FogParticle(origin, img));
  }
}

class FogParticle {
  PVector loc;
  PVector vel;
  PVector acc;
  float lifespan;
  PImage img;

  FogParticle(PVector l, PImage img_) {
    acc = new PVector(0, 0);
    float vx = randomGaussian()*2;
    float vy = random(3, 6);
    vel = new PVector(vx, vy);
    loc = l.copy();
    lifespan = random(255, 500);
    img = img_;
  }

  void run() {
    update();
    render();
  }

  // Method to apply a force vector to the Particle object
  // Note we are ignoring "mass" here
  void applyForce(PVector f) {
    // acc.add(f);
  }  

  // Method to update position
  void update() {
    vel.add(acc);
    loc.add(vel);
    lifespan -= 5;
    acc.mult(0); // clear Acceleration
  }

  // Method to display
  void render() {
    imageMode(CENTER);
    // tint(255, 255-lifespan/2);
    image(img, loc.x, loc.y, width/1, height/1);
  }

  // Is the particle still useful?
  boolean isDead() {
    if (loc.y > height) {
      return true;
    } else {
      return false;
    }
  }
}
