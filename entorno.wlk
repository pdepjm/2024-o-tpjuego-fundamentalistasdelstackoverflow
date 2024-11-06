import wollok.game.*
import morcilla.*
import general.*
import jefe.*

object entorno {
    method limpiarEntorno() {
        game.allVisuals().forEach({visible => game.removeVisual(visible)})
        administradorVidas.mostrarVidas()
    }

    method volverAlHub() {
        const jefesHub = [jefeDePrueba, jefeGato]

        game.allVisuals().forEach({visible => game.removeVisual(visible)})
        administradorVidas.mostrarVidas()
        
        game.addVisual(morcilla)

        jefesHub.forEach({jefe => jefe.posicionPrevia()})

        // Comprobar si se derrotaron 2, que aparezca el malo malísimo
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
    var duracionTurnoJefe = 6000 // default puesto por las dudas
    var jefeEnBatalla = false
    var turnoMorcilla = true
    
    method iniciarPelea() {
        if (!jefe.derrotado()) {
            game.boardGround("arena_de_jefe.png")
            entorno.limpiarEntorno()
            game.addVisual(morcilla)
            morcilla.enBatalla(true)
            jefeEnBatalla = true

            jefe.posicionBatalla()
            game.addVisual(jefe)

            self.habilitarAtaque()
            keyboard.e().onPressDo({self.gestionarAtaque()})
        }
    }

    method habilitarAtaque() {
        morcilla.posicionDeAtaque()
        game.addVisual(cartelAtaque)
        turnoMorcilla = true
    }

    method gestionarAtaque() {
        if(jefeEnBatalla && turnoMorcilla){
            
            turnoMorcilla = false
            game.removeVisual(cartelAtaque)

            const duracionCinematica = 1500
            morcilla.atacar()
            jefe.disminuirVida()

            if(jefe.derrotado())
            {
                game.say(jefe, "ah la pucha")
                game.schedule(1000, { self.finalizarBatalla() })
            }
            else
                game.schedule(duracionCinematica, { self.etapaDefensa() })
        }
    }

    method etapaDefensa() {
        morcilla.activarMovimiento()

        duracionTurnoJefe = jefe.ataque()
        game.schedule(duracionTurnoJefe+50, { self.habilitarAtaque() })
    }

    method finalizarBatalla() {
        jefeEnBatalla = false
        game.boardGround("stock_fondo2.png")
        entorno.volverAlHub()

        morcilla.enBatalla(false)
        morcilla.activarMovimiento()
    }
}

