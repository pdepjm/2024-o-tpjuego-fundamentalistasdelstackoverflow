import wollok.game.*
import morcilla.*
import general.*
import jefe.*

object entorno {
    method limpiarEntorno() {
        game.allVisuals().forEach({visible => game.removeVisual(visible)})
    }
}

// =============================================== COLISIONES ===============================================
class Colisiones {
    var property position
    method image() = "celda_gris.png"
}

// =============================================== VISUALES ===============================================
class Visual {
    const property position
    const property image
}

const derrota = new Visual (position = game.origin(), image = "celda_gris.png")

const cartelAtaque = new Visual (position = new Position(x=17, y=20), image = "proto_cartel_ataque.png")


// =============================================== BOSSFIGHTS ===============================================
class BossFight {
    const property jefe
    
    method iniciarPelea() {
        if (!jefe.derrotado()) {
            game.boardGround("arena_de_jefe.png")
            entorno.limpiarEntorno()
            game.addVisual(morcilla)
            morcilla.enBatalla(true)

            jefe.posicionBatalla()
            game.addVisual(jefe)

            self.habilitarAtaque()
        }
    }

    method habilitarAtaque() {
        morcilla.posicionDeAtaque()
        game.addVisual(cartelAtaque)
        keyboard.e().onPressDo({self.gestionarAtaque()})
    }

    method gestionarAtaque() {
        game.removeVisual(cartelAtaque)

        const duracionCinematica = 2000
        morcilla.atacar()
        jefe.disminuirVida()

        if(jefe.derrotado())
            self.finalizarBatalla()
        else
            game.schedule(duracionCinematica, { self.etapaDefensa() })
    }

    method etapaDefensa() {
        morcilla.activarMovimiento()

        const duracionTurnoJefe = jefe.ataque()
        game.schedule(duracionTurnoJefe, { self.habilitarAtaque() })
    }

    method finalizarBatalla() {
        game.boardGround("stock_fondo.png")
        entorno.limpiarEntorno()
        game.addVisual(morcilla)
        morcilla.enBatalla(false)
        morcilla.activarMovimiento()

        jefe.posicionPrevia()
        game.addVisual(jefe)
    }
}

