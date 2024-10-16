import wollok.game.*
import morcilla.*

// =============================================== COLISIONES ===============================================
class Colisiones {
    const property position

    method image() = "celda_gris.png"
}

const colision0 = new Colisiones(position = new Position(x=0, y=1))


// =============================================== VISUALES ===============================================
class Visual {
    const property position
    const property image
}

const cartelAtaque = new Visual (position = new Position(x=17, y=20), image = "celda_gris.png")


// =============================================== BOSSFIGHTS ===============================================
class BossFight {
    const property jefe
    
    method iniciarPelea() {
        game.boardGround("arena_de_jefe.png")
        self.habilitarAtaque()
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

        if(jefe.vida() > 0)
            game.schedule(duracionCinematica, { self.etapaDefensa() })
        else
            self.finalizarBatalla()
    }

    method etapaDefensa() {
        morcilla.activarMovimiento()

        const duracionTurnoJefe = 15000
        jefe.ataque()
        game.schedule(duracionTurnoJefe, { self.habilitarAtaque() })
    }

    method finalizarBatalla() {

    }
}

const bossFightDePrueba = new BossFight(jefe = jefeDePrueba)



// =============================================== JEFES ===============================================
class JefeInteractuable{
    const property position
    const property image
    var property vida = 3

    method disminuirVida(){
        vida = (vida - 1).max(0)
    }
    method ataque(){
        
    }
}

const jefeDePrueba = new JefeInteractuable(position = new Position(x=30, y=2), image = "celda_roja.png")