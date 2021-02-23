class FlowerSystem {

  ArrayList<Flower> flowers;    // An arraylist for all the Flowers
  PVector origin;        // An origin point for where Flowers are birthed
  int count=0;          // control flower adding speed

  FlowerSystem(int num) {
    flowers = new ArrayList<Flower>();   // Initialize the arraylist
    // Store the origin point
    for (int i = 0; i < num; i++) {
      flowers.add(new Flower());    // Add "num" amount of Flowers to the arraylist
    }
  }

  void run() {
    for (int i = flowers.size()-1; i >= 0; i--) {
      Flower f = flowers.get(i);
      f.display();
      f.anime();
      if (f.isDead()) {
        f.stop();
      }
      if (f.curve_r > 40 || f.lifespan < -50.0) { // flower falling sound effect 
        flowers.remove(i);
      }
    }
  }


  void addFlower() {
    if (!isFinished) {
      count +=1;

      if (count==30) {   // before calling name, only small amount of flower appear
        flowers.add(new Flower());
        count=0;
      }
    } else {  // after calling name, many flowers appear
      flowers.add(new Flower());
    }
  }

  // A method to test if the Flower system still has Flowers
  boolean dead() {
    if (flowers.isEmpty()) {
      return true;
    } else {
      return false;
    }
  }
}
