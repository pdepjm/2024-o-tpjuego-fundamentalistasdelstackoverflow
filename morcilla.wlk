object morcilla {
  var property position = new MutablePosition(x=0, y=0)

  method image() = "morcilla.png"
  method position() = position

  method caminar(pasos) {
    position.goRight(pasos)
  }

}