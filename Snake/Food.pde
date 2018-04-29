class Food
{
  //Width and Height (each square has 8x8 pixels)
  public static final int WIDTH = 32;
  public static final int HEIGHT = 20;
  
  //la posicion de la comida.
  private int x;
  private int y;

  //Constructor of the food.
  public Food()
  {
    x = int(random(WIDTH));
    y = int(random(HEIGHT));
  }

  //Generates randomly the food.
  public void generateFood()
  {
    this.x = int(random(WIDTH));
    this.y = int(random(HEIGHT));
  }
  
  //Gives the x position.
  public int x()
  {
    return x;
  }
  
  //Gives the y position.
  public int y()
  {
    return y;
  }
}
