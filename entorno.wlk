import wollok.game.*
import morcilla.*
import general.*
import jefe.*
import ataques.*
import interfaz.*

object entorno {
    var jefesDerrotados = 0

    method jefeDerrotado() { 
        jefesDerrotados += 1
    }

    method limpiarEntorno() {
        fondo.fondoOriginal()
        
        game.allVisuals().forEach({visible => game.removeVisual(visible)})
        fondo.mostrar()
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
            cinematicaFinal.empezar()
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


// =============================================== BOSSFIGHTS ===============================================
class BossFight {
    const property jefe
    var duracionTurnoJefe = 6000 // default puesto por las dudas
    var jefeEnBatalla = false
    var turnoMorcilla = true
    
    method iniciarPelea() {
        if (!jefe.derrotado()) {
            entorno.limpiarEntorno()
            fondo.fondoBatalla()
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
        entorno.jefeDerrotado()
        entorno.volverAlHub()

        morcilla.enBatalla(false)
        morcilla.activarMovimiento()
    }
}

