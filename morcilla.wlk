import wollok.game.*

object morcilla {
  var property position = new MutablePosition(x=0, y=2)
  var saltando = false

  method image() = "morcilla256.png"

  method caminarDerecha(pasos) {
    position.goRight(pasos)
  }

  method caminarIzquierda(pasos) {
    position.goLeft(pasos)
  }

  method saltar(duracion) {
    if (!saltando) {
      saltando = true
      const tiempo = duracion / 10

      game.schedule(tiempo * 0, { position.goUp(1) })
      game.schedule(tiempo * 1, { position.goUp(1) })
      game.schedule(tiempo * 2, { position.goUp(1) })
      game.schedule(tiempo * 3, { position.goUp(1) })
      game.schedule(tiempo * 4, { position.goUp(1) })

      game.schedule(tiempo * 5, { position.goDown(1) })
      game.schedule(tiempo * 6, { position.goDown(1) })
      game.schedule(tiempo * 7, { position.goDown(1) })
      game.schedule(tiempo * 8, { position.goDown(1) })
      game.schedule(tiempo * 9, { position.goDown(1) })

      game.schedule(tiempo * 9.5, { saltando = false })
    }
  }

}