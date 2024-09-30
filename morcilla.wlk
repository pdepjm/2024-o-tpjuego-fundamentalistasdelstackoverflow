object morcilla {
  var property position = new MutablePosition(x=0, y=2)

  method image() = "morcilla.png"

  method caminar(pasos) {
    position.goRight(pasos)
  }

}