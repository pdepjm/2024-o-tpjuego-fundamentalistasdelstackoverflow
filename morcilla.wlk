import wollok.game.*
import general.*
import entorno.*
import jefe.*

object morcilla {
    var property position = new PositionMejorada(x=15, y=2)

    // ================================== MOVIMIENTO ================================== 
    var saltando = false
    var suspendido = false
    var caerActivo = false
    var movimientoActivo = true
    
    const framesSalto = ["morcilla1.png", "morcilla2.png", "morcilla3.png", "morcilla4.png", "morcilla5.png", "morcilla6.png"]
    var frameSaltoActual = 0

    method saltando() = saltando
    method suspendido() = suspendido

    method image() {
        if(derrotado)
            return "261.jpg"
        else if(suspendido)
            return framesSalto.get(frameSaltoActual)
        else
        {
            if(position.x()%2 == 0)
                return "morcilla0.png"
            else
                return "morcilla1.png"
        }
    }

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

        game.schedule(tiempo * 1.5, { frameSaltoActual = 1 })
        game.schedule(tiempo * 3, { frameSaltoActual = 2 })
        game.schedule(tiempo * 4.5, { frameSaltoActual = 3 })
        game.schedule(tiempo * 6, { frameSaltoActual = 4 })
        game.schedule(tiempo * 7.5, { frameSaltoActual = 5 })

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
        frameSaltoActual = 0
        }
    }

    method caer() {
        if(!caerActivo && suspendido){
        game.onTick(100, "gravedad", {self.gravedad()})
        caerActivo = true
        }
    }

    // ================================== BATALLA ================================== 

    var property vidas = 3
    var inmunidadActiva = false
    var property puedeAtacar = false
    var derrotado = false
    var enBatalla = false 

    method enBatalla(estado){
        enBatalla = estado
    }

    method iniciarPeleaMorcilla(jefe, espera){
        if(!enBatalla) {
            self.desactivarMovimiento()
            game.say(jefe, "Has llegado morcilla. Ahora nos vamos a agarrar")
            
            game.schedule(espera, jefe.nuevaPelea())
        }
    }

    method perderVida() {
        if (!inmunidadActiva){
            vidas = (vidas-1).max(0)
            game.say(self, "Ay!")

            administradorVidas.actualizarVida(vidas)

            self.obtenerInmunidad(300)

            if(vidas < 1)
                self.derrota()
        }
    }

    method obtenerInmunidad(duracion) {
        inmunidadActiva = true
        game.schedule(duracion, {inmunidadActiva = false})
    }

    method derrota() {  // Terminar de hacer
        derrotado = true
        self.desactivarMovimiento()
    }

    method derrotado() = derrotado

    method atacar() {
        // Acá habría una animación, por ejemplo
    }

    method posicionDeAtaque() {
        self.desactivarMovimiento()
        //position = new PositionMejorada (x=15, y=2)
    }

    method desactivarMovimiento() {
        movimientoActivo = false
    }

    method activarMovimiento() {
        movimientoActivo = true
    }
}

class VidaMorcilla {
    var property image = "vidaDoradaLlena.png" 
    var property position
    const id

    method id() = id

    method perderVida() {
        image = "vidaDoradaVacia.png"
    }

    method tenerVida() {
        image = "vidaDoradaLlena.png"
    }
}

object administradorVidas {
    const vidaMaximaMorcilla = morcilla.vidas()

    const vida1 = new VidaMorcilla(position = new PositionMejorada(x = 1, y = 29), id = 1)
    const vida2 = new VidaMorcilla(position = new PositionMejorada(x = 4, y = 29), id = 2)
    const vida3 = new VidaMorcilla(position = new PositionMejorada(x = 7, y = 29), id = 3)
    const vida4 = new VidaMorcilla(position = new PositionMejorada(x = 10, y = 29), id = 4)
    const vida5 = new VidaMorcilla(position = new PositionMejorada(x = 12, y = 29), id = 5)

    const vidas = [vida1, vida2, vida3, vida4, vida5]

    method mostrarVidas() {
        vidas.forEach({sprite => if(sprite.id() <= vidaMaximaMorcilla){game.addVisual(sprite)}})
    }

    method actualizarVida(vidaActual) {
        vidas.forEach({sprite => if(sprite.id() > vidaActual){sprite.perderVida()}else{sprite.tenerVida()}})
    }
}