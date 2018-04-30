//Width and Height (each square has 8x8 pixels)
public static final int WIDTH = 36;
public static final int HEIGHT = 24;
public static final int PIXELS = 10;

//The snake.
private Snakey snake;

//The food.
private Food food;

//The score.
private int score;

//The reference score to see if levels up.
private int levelUpScore;

//The speed of the snake
private int speed;

//The current level of the game.
private int level;

//Boolean variable to check if its Alive.
private boolean inGame;

//Boolean variable to check if its paused.
private boolean isPaused;

//The direction of the movement.
private short dir;

//The game's main method.
public void game()
{
  snake = new Snakey();
  food = new Food();
  score = 0;
  levelUpScore = 0;
  speed = 75;
  level = 1;
  inGame = true;
  isPaused = false;
  dir = 2;
}

//Method for checking if the snake's crashed with sth.
public void checkCollision()
{
  //if(snake.x(0) < 0 || snake.x(0) >= WIDTH)
  //{
  //  inGame = false;
  //}
  //else if(snake.y(0) < 0 || snake.y(0) >= HEIGHT)
  //{
  //  inGame = false;
  //}
  if(snake.getSize() > 4)
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

//Method to check if the snake has eaten.
public void hasEaten()
{
  if(snake.x(0) == food.x() && snake.y(0) == food.y())
  {
    snake.eat();
    score += 5;
    levelUpScore += 5;
    food.generateFood();
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
  else if (key == 'p')
  {
    isPaused = !isPaused;
  }
}

//Increases partially the speed of the snake.
public void levelUp()
{
  if(levelUpScore != 0 && levelUpScore % 25 == 0)
  {
    speed -= speed*0.085;
    level++;
    levelUpScore = 0;
  }
}

//Advices leveling in the game.
public void adviceLeveling()
{
  int m = millis();
  if(score != 0 && levelUpScore == 0)
  {
    textAlign(CENTER,CENTER);
    textSize(17);
    if (m % 501 < 250)
    {
      fill(255, 0, 0);
    }
    else
    {
      fill(0, 0, 0);
    }
    text("LEVEL UP !", (WIDTH*PIXELS)/2, (HEIGHT*PIXELS)/2);
    textSize(12);
  }
}

//The setup and settings.
void setup()
{
  surface.setResizable(false);
  game();
}

void settings()
{
  size(WIDTH*PIXELS, (HEIGHT*PIXELS)+30, P2D);
}

//The main method of the game that draws everything.
void draw()
{
  fill(102, 153, 255);
  rect(0, 0, WIDTH*PIXELS, (HEIGHT*PIXELS)+(2*PIXELS));
  fill(0);
  rect(0, (HEIGHT*PIXELS)+PIXELS, WIDTH*PIXELS, (HEIGHT*PIXELS)+30);
  textAlign(LEFT, BOTTOM);
  fill(255);
  text("SCORE: " + score + " - LENGTH: " + snake.getSize(), 15, (HEIGHT*PIXELS)+27);
  textAlign(RIGHT, BOTTOM);
  fill(245, 0, 0);
  text("LEVEL: " + level, (WIDTH*PIXELS)-15, (HEIGHT*PIXELS)+27);
  keysPressed();
  if(isPaused)
  {
    textAlign(CENTER, CENTER);
    fill(255, 128, 0);
    textSize(17);
    text("PAUSED!", (WIDTH*PIXELS)/2, (HEIGHT*PIXELS)/2);
    textSize(12);
  }
  else if(inGame)
  {
    paint();
    snake.move(dir);
    checkCollision();
    hasEaten();
    levelUp();
    adviceLeveling();
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
