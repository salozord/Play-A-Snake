class Culebra
{
  //La posicion de la culebra en x.
  int[] posx;

  //La posicion de la culebra en y.
  int[] posy;

  //El cuerpo
  int longitud;

  //Constructor de cada snake.
  public Culebra()
  {
    posx = new int[5000];
    posy = new int [5000];
    posx[0] = 4;
    posy[0] = 1;
    posx[1] = 3;
    posy[1] = 1;
    posx[2] = 2;
    posy[2] = 1;
    longitud = 3;
  }

  public void mover(int direccion)
  {  
    for(int i = longitud - 1; i > 0; i--)
    {
         posx[i] = posx[i-1];
         posy[i] = posy[i-1];
    }
    
    switch (direccion)
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

  public void comer()
  {
    longitud++;
  }

}
