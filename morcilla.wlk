import wollok.game.*
import general.*
import entorno.*
import jefe.*

object morcilla {
    var property position = new PositionMejorada(x=0, y=2)
    method image() = "morcilla256.png"

    // ================================== MOVIMIENTO ================================== 
    var saltando = false
    var suspendido = false
    var caerActivo = false
    var movimientoActivo = true

    method saltando() = saltando
    method suspendido() = suspendido

    method caminarDerecha(pasos) {
        if(movimientoActivo)
        position.goRightMejorado(pasos, 30)

        // FALTA EVALUAR SI QUEDA SUSPENDIDO
        self.caer()
    }

    method caminarIzquierda(pasos) {
        if(movimientoActivo)
        position.goLeftMejorado(pasos, 0)
        
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

    // ================================== BATALLA ================================== 

    var property vidas = 5
    var inmunidadActiva = false
    var property puedeAtacar = false
    var derrotado = false
    var enBatalla = false 

    method enBatalla(estado){
        enBatalla = estado
    }

    method iniciarPeleaMorcilla(jefe){
        if(!enBatalla){         // Un pequeño problema es que una vez que se activa el method podés activar la pelea en cualquier momento
            game.say(jefe, "Pulsa J para iniciar battalla")

            keyboard.j().onPressDo({ (new BossFight(jefe = jefe)).iniciarPelea() })
        }
    }

    method perderVida() {
        if (!inmunidadActiva){
            vidas = (vidas-1).max(0)
            game.say(self, "Ay!")

            self.obtenerInmunidad(300)

            if(vidas < 1)
                self.derrota()
        }
    }

    method obtenerInmunidad(duracion) {
        inmunidadActiva = true
        game.schedule(duracion, {inmunidadActiva = false})
    }

    method derrota() {
        derrotado = true
        game.addVisual(derrota)
    }

    method derrotado() = derrotado

    method atacar() {
        // Acá habría una animación, por ejemplo
    }

    method posicionDeAtaque() {
        movimientoActivo = false
        position = new PositionMejorada (x=15, y=2)
    }

    method activarMovimiento() {
        movimientoActivo = true
    }
}