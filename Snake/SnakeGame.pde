
  //Width and Height (each square has 8x8 pixels)
  public static final int WIDTH = 32;
  public static final int HEIGHT = 20;
  public static final int PIXELS = 10;

  //The snake.
  private Snakey snake;

  //The food.
  private Food food;

  //The score.
  private int score;

  //The speed of the snake
  private int speed;

  //Boolean variable to check if its Alive.
  private boolean inGame;

  //The direction of the movement.
  private short dir;

  //The game's main method.
  public void game()
  {
    snake = new Snakey();
    food = new Food();
    score = 0;
    speed = 65;
    inGame = true;
    dir = 2;
  }

  public void checkCollision()
  {
     if(snake.x(0) < 0 || snake.x(0) >= WIDTH)
    {
      inGame = false;
    }
    else if(snake.y(0) < 0 || snake.y(0) >= HEIGHT)
    {
      inGame = false;
    }
    else if(snake.getSize() > 4)
    {
        for(int i = snake.getSize() - 1  ; i >= 4; i--)
        {
          if(snake.x(0) == snake.x(i) && snake.y(0) == snake.y(i))
          {
            inGame = false;
          }
        }
    }
  }

  public void hasEaten() //<>//
  {
    if(snake.x(0) == food.x() && snake.y(0) == food.y())
    {
      snake.eat();
      score += 5;

      int i = 0;
      while(i < snake.getSize())
      {
        if(food.x() == snake.x(i) && food.y() == snake.y(i))
        {
         food.generateFood(); 
        }
        i++;
      }
    }
  }
  
  //Check the keys that are pressed
  public void keysPressed()
  {
    if (keyCode == UP && dir != 3)
    {
      dir = 1;
    }
    else if (keyCode == DOWN && dir != 1)
    {
      dir = 3;
    }
    else if (keyCode == RIGHT && dir != 4)
    {
      dir = 2;
    }
    else if (keyCode == LEFT && dir != 2)
    {
      dir = 4;
    }
    else if (keyCode == ENTER && !inGame)
    {
      game();
    }
  }
    
  //The settings.
  void settings()
  {
    size(WIDTH*PIXELS, (HEIGHT*PIXELS)+30, P2D);
    game();
  }

  //The main method of the game.
  void draw()
  {
    fill(0, 0, 210);
    stroke(0);
    rect(0, 0, WIDTH*PIXELS, HEIGHT*PIXELS);
    noStroke();
    fill(0);
    rect(0, HEIGHT*PIXELS, WIDTH*PIXELS, (HEIGHT*PIXELS)+30);
    textAlign(LEFT, BOTTOM);
    fill(255);
    text("SCORE: " + score + "  -  LENGTH: " + snake.getSize(), 20, (HEIGHT*PIXELS)+22);
    keysPressed();
    if(inGame)
    {
      snake.move(dir);
      checkCollision();
      hasEaten();
      paint();
    }
    else
    {
      textAlign(CENTER, CENTER);
      fill(255);
      text("GAME OVER :(\nENTER TO RESTART", (WIDTH*PIXELS)/2, (HEIGHT*PIXELS)/2);
    }
    delay(speed);
  }

  //Paints everything.
  void paint()
  {
    //clear();
    //background(204, 204, 255);
    for(int i = 0; i < snake.getSize(); i++)
    {
      fill(0, 255, 0);
      stroke(0);
      rect((snake.x(i))*PIXELS, (snake.y(i))*PIXELS, PIXELS, PIXELS, 2);
    }
    fill(255, 0, 0);
    stroke(0);
    rect((food.x())*PIXELS, (food.y())*PIXELS, PIXELS, PIXELS, 2);
  }
