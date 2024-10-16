import wollok.game.*

object morcilla {
  var property position = new MutablePosition(x=0, y=2)
  var property vidas = 5
  var property puedeAtacar = false

  var saltando = false
  var suspendido = false
  var caerActivo = false
  var movimientoActivo = true

  method image() = "morcilla256.png"
  method saltando() = saltando

  method caminarDerecha(pasos) {
    if(movimientoActivo)
      position.goRight(pasos)

    // FALTA EVALUAR SI QUEDA SUSPENDIDO
    self.caer()
  }

  method caminarIzquierda(pasos) {
    if(movimientoActivo)
      position.goLeft(pasos)
    
    // FALTA EVALUAR SI QUEDA SUSPENDIDO
    self.caer()
  }

  method saltar(duracion) {
    if (!suspendido && movimientoActivo) {
      saltando = true
      suspendido = true
      const tiempo = duracion / 5

      game.schedule(tiempo * 0, { position.goUp(1) })
      game.schedule(tiempo * 1, { position.goUp(1) })
      game.schedule(tiempo * 2, { position.goUp(1) })
      game.schedule(tiempo * 3, { position.goUp(1) })
      game.schedule(tiempo * 4, { position.goUp(1) })

      game.schedule(tiempo * 5, { saltando = false })
      game.schedule(tiempo * 5, { self.caer() })
    }
  }
  
  method gravedad() {
    if (position.y() > 2 && !saltando) { 
      // Está cayendo o saltando
      position.goDown(1)
      suspendido = true
    }
    else if (!saltando) { 
      // Ya cayó
      game.removeTickEvent("gravedad")
      suspendido = false
      caerActivo = false
    }
  }

  method caer() {
    if(!caerActivo && suspendido){
      game.onTick(100, "gravedad", {self.gravedad()})
      caerActivo = true
    }
  }

  method atacar() {
    
  }

  method posicionDeAtaque() {
    movimientoActivo = false
    position = new MutablePosition (x=16, y=2)
  }

  method activarMovimiento() {movimientoActivo = true}
}