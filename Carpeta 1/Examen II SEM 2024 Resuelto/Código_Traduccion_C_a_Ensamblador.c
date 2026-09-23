// Operación Compare
// Retorna el elemento más grande entre los dos parámetros
// En caso de igualdad retorna el primer parámetro
// param a: Primero elemento de la comparación
// param b: Segundo elemento de la comparación
int compare(int a, int b) {
  if (a >= b)
    return a;
  else
    return b;
}

// Operación Sumatoria
// param a: Elemento del cual calcular la sumatoria
int sumatoria(int a) {
  int resultado = 0;
  for (int cnt=0; cnt<=a; cnt++){
    resultado = resultado+cnt;
  }

  return resultado;
}

// ##############
//     MAIN
// ##############
int solucion = 0;
solucion = compare(7, 9);
// Breakpoint para revisión
solucion = compare(11, solucion);
// Breakpoint para revision
solución = sumatoria(5);
