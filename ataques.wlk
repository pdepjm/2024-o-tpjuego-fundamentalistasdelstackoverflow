import proyectiles.*
import general.*

const proyectilR1 = new Proyectil(position = new PositionMejorada(x = 0, y = 2), id = "R1", velocidad = 100, delay = 300, sentido = dirDerecha)
const proyectilR2 = new Proyectil(position = new PositionMejorada(x = 0, y = 7), id = "R2", velocidad = 100, delay = 300, sentido = dirDerecha)
const proyectilL1 = new Proyectil(position = new PositionMejorada(x = 32, y = 2), id = "L1", velocidad = 100, delay = 1000, sentido = dirIzquierda)
const proyectilL2 = new Proyectil(position = new PositionMejorada(x = 32, y = 7), id = "L2", velocidad = 100, delay = 1000, sentido = dirIzquierda)

const proyectilR3 = new Proyectil(position = new PositionMejorada(x = 0, y = 2), id = "R3", velocidad = 25, delay = 600, sentido = dirDerecha)
const proyectilR4 = new Proyectil(position = new PositionMejorada(x = 0, y = 3), id = "R4", velocidad = 200, delay = 10, sentido = dirDerecha)
const proyectilL3 = new Proyectil(position = new PositionMejorada(x = 32, y = 2), id = "L3", velocidad = 25, delay = 1200, sentido = dirIzquierda)  // Estos proyectiles (pertenecientes al ataquePerro2) rompen el siguiente ataque

const proyectilR6 = new Proyectil(position = new PositionMejorada(x = 0, y = 2), id = "R6", velocidad = 100, delay = 300, sentido = dirDerecha)
const proyectilL4 = new Proyectil(position = new PositionMejorada(x = 32, y = 7), id = "L4", velocidad = 150, delay = 300, sentido = dirIzquierda)
const proyectilL5 = new Proyectil(position = new PositionMejorada(x = 32, y = 3), id = "L5", velocidad = 25, delay = 1000, sentido = dirIzquierda)

const proyectilR7 = new Proyectil(position = new PositionMejorada(x = 0, y = 3), id = "R7", velocidad = 150, delay = 10, sentido = dirDerecha)
const proyectilR5 = new Proyectil(position = new PositionMejorada(x = 0, y = 5), id = "R5", velocidad = 150, delay = 100, sentido = dirDerecha)
const proyectilL6 = new Proyectil(position = new PositionMejorada(x = 32, y = 4), id = "L6", velocidad = 100, delay = 10, sentido = dirIzquierda)



class Ataque {
    const proyectiles
    
    method atacar() {
        proyectiles.forEach({proyectil => game.schedule(proyectil.delay(), {proyectil.direccion()})})

        return proyectiles.map({proyectil => proyectil.duracion()}).max()
    }
}

const ataquePerro1 = new Ataque(proyectiles = [proyectilR1, proyectilR2, proyectilL1, proyectilL2])
const ataquePerro2 = new Ataque(proyectiles = [proyectilR3, proyectilR4, proyectilL3])
const ataquePerro3 = new Ataque(proyectiles = [proyectilR6, proyectilL4, proyectilL5])
const ataquePerro4 = new Ataque(proyectiles = [proyectilR7, proyectilR5, proyectilL6])

const ataqueGato1 = new Ataque(proyectiles = [])
const ataqueGato2 = new Ataque(proyectiles = [])
const ataqueGato3 = new Ataque(proyectiles = [])
const ataqueGato4 = new Ataque(proyectiles = [])

const ataqueFinal1 = new Ataque(proyectiles = [])
const ataqueFinal2 = new Ataque(proyectiles = [])
const ataqueFinal3 = new Ataque(proyectiles = [])
const ataqueFinal4 = new Ataque(proyectiles = [])