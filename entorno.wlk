import wollok.game.*
import morcilla.*
import general.*

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

class Proyectiles inherits Colisiones {
    method direccionIzquierda(velocidad) {
        game.onTick(velocidad, "proyectilIzquierda", {position.x((position.x()-1))})
    }
    
    method direccionDerecha(velocidad) {
        game.onTick(velocidad, "proyectilDerecha", {position.goRight(1)})
    }
}

const colision0 = new Colisiones(position = new Position(x=0, y=1))


// =============================================== VISUALES ===============================================
class Visual {
    const property position
    const property image
}

const cartelAtaque = new Visual (position = new Position(x=17, y=20), image = "proto_cartel_ataque.png")


// =============================================== BOSSFIGHTS ===============================================
class BossFight {
    const property jefe
    
    method iniciarPelea() {
        game.boardGround("arena_de_jefe.png")
        entorno.limpiarEntorno()
        game.addVisual(morcilla)

        jefe.posicionBatalla()
        game.addVisual(jefe)

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
    var property position
    const property image
    var property vida = 3

    method posicionBatalla() {
        position = game.center()
    }

    method disminuirVida(){
        vida = (vida - 1).max(0)
    }
    
}

class JefeDePrueba inherits JefeInteractuable { 
    method ataque() {
        const opcion = (0.randomUpTo(2)).roundUp()
        
        if(opcion == 1)
            self.ataque1()
        else if(opcion == 2)
            self.ataque2()

    }

    method ataque1() {
        new 
    }

    method ataque2() {
        
    }
}

const jefeDePrueba = new JefeDePrueba (position = new Position(x=30, y=2), image = "celda_roja.png")