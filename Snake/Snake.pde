class Snakey
{
  //The positions of the snake and its parts in x.
  private int[] posx;

  //The positions of the snake and its parts in y.
  private int[] posy;

  //The snake's length.
  private int size;

  //Constructor of the snake.
  public Snakey()
  {
    posx = new int [Food.WIDTH*Food.HEIGHT];
    posy = new int [Food.WIDTH*Food.HEIGHT];
    posx[0] = 4;
    posy[0] = 1;
    posx[1] = 3;
    posy[1] = 1;
    posx[2] = 2;
    posy[2] = 1;
    size = 3;
  }

  //Method for the movement of the snake.
  public void move(short direction)
  {
    for(int i = size - 1; i > 0; i--)
    {
         posx[i] = posx[i-1];
         posy[i] = posy[i-1];
    }

    switch (direction)
    {
       case 1:
         posy[0]--;
         break;
       case 3:
         posy[0]++;
         break;
       case 2:
         posx[0]++;
         break;
       case 4:
         posx[0]--;
         break;
    }
  }

  //Method called when the snake eats.
  public void eat()
  {
    size++;
  }

  //Gives the x position of the part i.
  public int x(int i)
  {
    return posx[i];
  }

  //Gives the y position of the part i.
  public int y(int i)
  {
    return posy[i];
  }

  //The length.
  public int getSize()
  {
    return size;
  }
}
