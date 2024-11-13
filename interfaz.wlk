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
    const duracionFrame

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
        frameActual = 0
    }

    method siguienteFrame() {
        if(frameActual +1 < frames.size()) {
            frameActual += 1
            image = frames.get(frameActual)
        }
    }
    
    method duracion() = frames.size() * duracionFrame
}

const cartelAtaque = new Visual (position = new Position(x=4, y=20), image = "cartelDeAtaque.jpg")

object fondo inherits Visual(position = game.origin(), image = "vacio.png"){
    method fondoBatalla(){
        image = "arena_de_jefe.jpg"
    }

    method fondoOriginal(){
        image = "vacio.png"
    }

    method final(){
        image = "morcillaAsadoFinal.jpg"
    }
}

const cinematicaDerrota = new Cinematica (id = "derrota", duracionFrame = 300, frames = ["frameEjemplo0.jpg", "frameEjemplo1.jpg", "frameEjemplo2.jpg"])
const cinematicaAtaque = new Cinematica (id = "ataque", duracionFrame = 300, frames = ["frameEjemplo0.jpg", "frameEjemplo1.jpg", "frameEjemplo2.jpg"])
const cinematicaJefePerro = new Cinematica (id = "gato", duracionFrame = 300, frames = ["frameEjemplo0.jpg", "frameEjemplo1.jpg", "frameEjemplo2.jpg"])
const cinematicaJefeGato = new Cinematica (id = "perro", duracionFrame = 300, frames = ["frameEjemplo0.jpg", "frameEjemplo1.jpg", "frameEjemplo2.jpg"])
const cinematicaJefeFinal = new Cinematica (id = "final", duracionFrame = 300, frames = ["frameEjemplo0.jpg", "frameEjemplo1.jpg", "frameEjemplo2.jpg"])


// =============================================== SONIDOS ===============================================

class Sonido {
    const sonidos
    const loop
    var sonido = game.sound(sonidos.head())
    var sonando = false
    const volumen

    method play(){
        self.stop()
        sonidos.randomize()
        sonido = game.sound(sonidos.head())
        sonido.volume(volumen)
        sonido.shouldLoop(loop)
        sonido.play()

        if(loop)
            sonando = true
    }

    method stop(){
        if(sonando){
            sonido.stop()
            sonando = false
        }
    }
}

const ladridos = new Sonido(sonidos = ["ladrido0.mp3", "ladrido1.wav", "ladrido3.mp3", "ladrido4.mp3"], volumen = 0.6, loop = false)
const ladridosGolpe = new Sonido(sonidos = ["ladridoGolpe0.wav", "ladridoGolpe1.wav", "ladridoGolpe2.wav", "ladridoGolpe3.wav"], volumen = 1, loop = false)
const musicaBatalla = new Sonido(sonidos = ["morcillaBatalla.mp3"], volumen = 0.3, loop = true)
const musicaNormal = new Sonido(sonidos = ["morcilla.mp3"], volumen = 0.3, loop = true)
const sonidoVacio = new Sonido(sonidos = ["vacio.mp3"], volumen = 0, loop = false)