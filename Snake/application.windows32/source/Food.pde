class Food
{
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
