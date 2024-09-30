object morcilla {
  var property position = new MutablePosition(x=0, y=2)

  method image() = "morcilla.png"

  method caminarDerecha(pasos) {
    position.goRight(pasos)
  }

}