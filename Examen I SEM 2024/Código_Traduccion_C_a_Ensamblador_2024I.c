// ##############
//     UTILS
// ##############
// Operación Gran Suma
// param a: Parametro a ser usado en la suma
int gransuma(int a) {
  int resultado = 0;
  resultado = a+a+a;
  return resultado;
}

// ##############
//     MAIN
// ##############
uint32_t arreglo_principal[20] = {};
for (int i=0; i<20; i++) {
  arreglo_principal[i] = gransuma(i);
}
