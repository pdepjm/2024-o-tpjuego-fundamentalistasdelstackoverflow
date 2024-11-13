import wollok.game.*
import morcilla.*
import general.*
import jefe.*
import ataques.*

object entorno {
    var jefesDerrotados = 0

    method jefeDerrotado() { 
        jefesDerrotados += 1
    }

    method limpiarEntorno() {
        game.allVisuals().forEach({visible => game.removeVisual(visible)})
        administradorVidas.mostrarVidas()
    }

    method volverAlHub() {
        const jefesHub = [jefePerro, jefeGato]

        self.limpiarEntorno()
        
        morcilla.mostrar()

        jefesHub.forEach({jefe => if(!jefe.derrotado()){jefe.posicionPrevia()}})

        if (jefesDerrotados == jefesHub.size()) {
            //game.schedule(1000, game.addVisual(jefeFinal))
            //game.whenCollideDo(jefeFinal, { personaje => if(personaje === morcilla) {personaje.iniciarPeleaMorcilla(jefeFinal, 500)}})
            game.schedule(1000, { morcilla.iniciarPeleaMorcilla(jefeFinal, 500) })
        }

        if (jefeFinal.derrotado()) {
            new Cinematica (position = game.origin(), image = "celda_gris.png", frames = [], id = "FINAL").empezar()
        }
    }

    method reiniciarJuego() {
        const personajes = [morcilla, jefePerro, jefeGato, jefeFinal]

        jefesDerrotados = 0

        self.limpiarEntorno()

        personajes.forEach({personaje => personaje.estadoInicial()}) // revisar

        morcilla.mostrar()
        game.schedule(200,{jefeFinal.ocultar()})
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
    var property image

    method mostrar() {
        if(!game.hasVisual(self))
            game.addVisual(self)
    }

    method ocultar() {
        if(game.hasVisual(self))
            game.removeVisual(self)
    }
}

class Cinematica {
    const frames
    const id
    var frameActual = 0
    const property position = game.origin()
    var image = "261.jpg"
    const duracionFrame = 200

    method image() = image
    
    method empezar() {
        image = frames.head()
        game.onTick(duracionFrame, id, {self.siguienteFrame()})
        game.addVisual(self)  // arbitrario para saber si funciona

        game.schedule(self.duracion(), { self.terminar() })
    }

    method terminar() {
        game.removeTickEvent(id)
        game.removeVisual(self)
    }

    method siguienteFrame() {
        if(frameActual +1 < frames.size()) {
            frameActual += 1
            image = frames.get(frameActual)
        }
    }
    
    method duracion() = frames.size() * duracionFrame
}

const cartelAtaque = new Visual (position = new Position(x=17, y=20), image = "proto_cartel_ataque.png")
const fondoJefe = new Visual (position = game.origin(), image = "arena_de_jefe.png")

const cinematicaDerrota = new Cinematica (id = "derrota", frames = ["261.jpg"])
const cinematicaAtaque = new Cinematica (id = "ataque", frames = ["261.jpg"])
const cinematicaJefePerro = new Cinematica (id = "gato", frames = ["261.jpg"])
const cinematicaJefeGato = new Cinematica (id = "perro", frames = ["261.jpg"])
const cinematicaJefeFinal = new Cinematica (id = "final", frames = ["261.jpg"])


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
            morcilla.mostrar()
            morcilla.enBatalla(true)
            jefeEnBatalla = true

            jefe.posicionBatalla()
            jefe.mostrar()

            self.habilitarAtaque()
            keyboard.e().onPressDo({self.gestionarAtaque()})
        }
    }

    method habilitarAtaque() {
        if(!morcilla.derrotado())
        {
            morcilla.posicionDeAtaque()
            game.addVisual(cartelAtaque)
            turnoMorcilla = true
        }
    }

    method gestionarAtaque() {
        if(jefeEnBatalla && turnoMorcilla && !morcilla.derrotado()){
            
            turnoMorcilla = false
            game.removeVisual(cartelAtaque)

            const duracionCinematica = 1000 // cinematicaAtaque.duracion()
            morcilla.atacar()
            jefe.disminuirVida()

            if(jefe.derrotado())
                game.schedule(1000, { self.finalizarBatalla() })
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
        entorno.jefeDerrotado()
        entorno.volverAlHub()

        morcilla.enBatalla(false)
        morcilla.activarMovimiento()
    }
}

