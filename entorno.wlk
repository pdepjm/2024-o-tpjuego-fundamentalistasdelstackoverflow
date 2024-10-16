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

class Proyectiles {
    var property position
    const id

    method direccionIzquierda(velocidad) {
        game.addVisual(self)
        game.onTick(velocidad, "proyectilIzquierda" + id, {self.movimientoIzquierda(velocidad)})
    }

    method movimientoIzquierda(velocidad) {
        position.goLeftMejorado(1, 0)    
        if(position.x() == 0)
        {
            game.removeVisual(self)
            game.removeTickEvent("proyectilIzquieda" + id)
        }
    }
    
    method direccionDerecha(velocidad) {
        game.addVisual(self)
        game.onTick(velocidad, "proyectilDerecha" + id, {self.movimientoDerecha(velocidad)})
    }

    method movimientoDerecha(velocidad) {
        position.goRightMejorado(1, 30)    
        if(position.x() == 30)
        {
            game.removeVisual(self)
            game.removeTickEvent("proyectilDerecha" + id)
        }
    }
}



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

        const duracionTurnoJefe = jefe.ataque()
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
            return self.ataque1()
        else if(opcion == 2)
            return self.ataque2()
        else
            return 0

    }

    method ataque1() {
        const proyectilR1 = new ProyectilJefe1(position = new PositionMejorada(x = 0, y = 2), id = "R1")
        const proyectilL1 = new ProyectilJefe1(position = new PositionMejorada(x = 32, y = 3), id = "L1")

        game.schedule(100, {proyectilR1.direccionDerecha(100)})
        game.schedule(300, {proyectilL1.direccionIzquierda(100)})

        return 6000
    }

    method ataque2() {
        const proyectilR1 = new ProyectilJefe1(position = new PositionMejorada(x = 0, y = 2), id = "R1")
        const proyectilL1 = new ProyectilJefe1(position = new PositionMejorada(x = 32, y = 8), id = "L1")

        game.schedule(300, {proyectilR1.direccionDerecha(100)})
        game.schedule(100, {proyectilL1.direccionIzquierda(50)})

        return 6000
    }
}

class ProyectilJefe1 inherits Proyectiles {
    method image() = "ataque_prueba.png"
}

const jefeDePrueba = new JefeDePrueba (position = new PositionMejorada(x=30, y=2), image = "celda_roja.png")