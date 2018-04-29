class Comida
{

  //Alto y Ancho (Cada casilla tiene 8x8 pixeles)
  public final int ANCHO = 100;
  public final int ALTO = 50;
  
  //la posicion de la comida.
  int x;
  int y;

  //Constructor de la comida.
  public Comida()
  {
    x = int(random(ANCHO));
    y = int(random(ALTO));
  }

  //Genera la comida de manera aleatoria.
  public void generarComida()
  {
    this.x = int(random(ANCHO));
    this.y = int(random(ALTO));
  }
}
