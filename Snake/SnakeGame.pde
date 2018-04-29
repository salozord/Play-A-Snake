
  //Alto y Ancho (Cada casilla tiene 8x8 pixeles)
  public final int ANCHO = 100;
  public final int ALTO = 50;

  //la cabeza de la culebra.
  private Culebra cabeza;

  //La comida.
  private Comida comida;

  //El puntaje en el juego
  private int puntaje;

  //El retraso de la culebra.
  private int retraso;

  //booleano a ver si esta en juego.
  private boolean enJuego;

  //La dirección del movimiento.
  private int dir;

  //constructor de la clase principal.
  public void game()
  {
    cabeza = new Culebra();
    comida = new Comida();
    puntaje = 0;
    retraso = 70;
    enJuego = true;
    dir = 2;
  }

  public void chequearColision()
  {
     if(cabeza.posx[0] < 0 || cabeza.posx[0] >= ANCHO)
    {
      enJuego = false;
    }
    else if(cabeza.posy[0] < 0 || cabeza.posy[0] >= ALTO)
    {
      enJuego = false;
    }
    else if(cabeza.longitud > 4)
    {
        for(int i = cabeza.longitud - 1  ; i >= 4; i--)
        {
          if(cabeza.posx[0] == cabeza.posx[i] && cabeza.posy[0] == cabeza.posy[i])
          {
            enJuego = false;
          }
        }
    }
  }

  public void comio() //<>//
  {
    if(cabeza.posx[0] == comida.x && cabeza.posy[0] == comida.y)
    {
      cabeza.comer();
      puntaje += 5;;
      //comida.generarComida();
      int i = 0;
      while(comida.x == cabeza.posx[i] && comida.y == cabeza.posy[i] && i < cabeza.longitud-1)
      {
        comida.generarComida();
        i++;
      }
    }
  }
  void settings()
  {
    size(800, 430, P2D);
    game();
  }

  void draw()
  {
    fill(0, 0, 210);
    stroke(0);
    rect(0, 0, ANCHO*8, ALTO*8);
    noStroke();
    fill(0);
    rect(0, 400, ANCHO*8, (ANCHO*8)+30);
    textAlign(LEFT, BOTTOM);
    fill(255);
    text("PUNTAJE: " + puntaje + "  -  LONGITUD: " + cabeza.longitud, 0, height-8);
    if(enJuego)
    {
      if(keyCode == UP && dir != 3)
      {
        dir = 1;
      }
      else if (keyCode == DOWN && dir != 1)
      {
        dir = 3;
      }
      else if ((keyCode == RIGHT && dir != 4))
      {
        dir = 2;
      }
      else if (keyCode == LEFT && dir != 2)
      {
        dir = 4;
      }
      cabeza.mover(dir);
      chequearColision();
      comio();
      dibujar();
    }
    else
    {
      textAlign(CENTER, CENTER);
      fill(255);
      text("GAME OVER :(\nPULSA ENTER PARA REINICIAR", 400, 185);
    }
    if(keyCode == ENTER && !enJuego)
    {
      game();
    }
    delay(retraso);
  }

  void dibujar()
  {
    //clear();
    //background(204, 204, 255);
    for(int i = 0; i < cabeza.longitud; i++)
    {
      fill(0, 255, 0);
      stroke(0);
      rect((cabeza.posx[i])*8, (cabeza.posy[i])*8, 8, 8, 2);
    }
    fill(255, 0, 0);
    stroke(0);
    rect((comida.x)*8, (comida.y)*8, 8, 8, 2);
  }
