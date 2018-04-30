import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Snake extends PApplet {

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
    x = PApplet.parseInt(random(WIDTH));
    y = PApplet.parseInt(random(HEIGHT));
  }

  //Generates randomly the food.
  public void generateFood()
  {
    this.x = PApplet.parseInt(random(WIDTH));
    this.y = PApplet.parseInt(random(HEIGHT));
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

//The reference score to see if levels up.
private int levelUpScore;

//The speed of the snake
private int speed;

//The current level of the game.
private int level;

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
  levelUpScore = 0;
  speed = 75;
  level = 1;
  inGame = true;
  dir = 2;
}

//Method for checking if the snake's crashed with sth.
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
}

//Increases partially the speed of the snake.
public void levelUp()
{
  if(levelUpScore != 0 && levelUpScore % 25 == 0)
  {
    speed -= speed*0.033f;
    level++;
    levelUpScore = 0;
  }
}

//Advices leveling in the game.
public void adviceLeveling()
{
  if(score != 0 && levelUpScore == 0)
  {
    textAlign(CENTER,CENTER);
    fill(PApplet.parseInt(random(256)), PApplet.parseInt(random(256)), PApplet.parseInt(random(256)));
    text("LEVEL UP !", (WIDTH*PIXELS)/2, (HEIGHT*PIXELS)/2);
  }
}

//The setup and settings.
public void setup()
{
  surface.setResizable(false);
  game();
}

public void settings()
{
  size(WIDTH*PIXELS, (HEIGHT*PIXELS)+30, P2D);
}

//The main method of the game that draws everything.
public void draw()
{
  fill(102, 153, 255);
  stroke(0);
  rect(0, 0, WIDTH*PIXELS, HEIGHT*PIXELS);
  noStroke();
  fill(0);
  rect(0, HEIGHT*PIXELS, WIDTH*PIXELS, (HEIGHT*PIXELS)+30);
  textAlign(LEFT, BOTTOM);
  fill(255);
  text("SCORE: " + score + " - LENGTH: " + snake.getSize(), 15, (HEIGHT*PIXELS)+22);
  textAlign(RIGHT, BOTTOM);
  fill(245, 0, 0);
  text("LEVEL: " + level, (WIDTH*PIXELS)-15, (HEIGHT*PIXELS)+22);
  keysPressed();
  if(inGame)
  {
    snake.move(dir);
    checkCollision();
    hasEaten();
    paint();
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
public void paint()
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
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Snake" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
