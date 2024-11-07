import proyectiles.*
import general.*

class ProyectilJefe1 inherits Proyectiles {
    method image() = "ataque_prueba.png"
}

object ataquePerro1 {
    method atacar() {
        const proyectilPerroR1 = new ProyectilJefe1(position = new PositionMejorada(x = 0, y = 2), id = "R1")
        const proyectilPerroL1 = new ProyectilJefe1(position = new PositionMejorada(x = 32, y = 3), id = "L1")

        game.schedule(100, {proyectilPerroR1.direccionDerecha(100)})
        game.schedule(300, {proyectilPerroL1.direccionIzquierda(100)})

        return 6000
    }
}

object ataquePerro2 {
    method atacar() {
        const proyectilPerroR1 = new ProyectilJefe1(position = new PositionMejorada(x = 0, y = 2), id = "R1")
        const proyectilPerroL1 = new ProyectilJefe1(position = new PositionMejorada(x = 32, y = 8), id = "L1")

        game.schedule(300, {proyectilPerroR1.direccionDerecha(100)})
        game.schedule(100, {proyectilPerroL1.direccionIzquierda(50)})

        return 6000
    }
}

object ataqueGato1 {
    method atacar() {
        const proyectilGatoDR1 = new ProyectilJefe1(position = new PositionMejorada(x = 0, y = 30), id = "DR1")
        const proyectilGatoDL1 = new ProyectilJefe1(position = new PositionMejorada(x = 32, y = 27), id = "DL1")

        game.schedule(100, {proyectilGatoDR1.direccionDiagonalAbajoDerecha(100)})
        game.schedule(300, {proyectilGatoDL1.direccionDiagonalAbajoIzquierda(100)})

        return 6000
    }
}

object ataqueGato2 {
    method atacar() {
        const proyectilGatoDR1 = new ProyectilJefe1(position = new PositionMejorada(x = 0, y = 27), id = "DR1")
        const proyectilGatoDL1 = new ProyectilJefe1(position = new PositionMejorada(x = 32, y = 32), id = "DL1")

        game.schedule(300, {proyectilGatoDR1.direccionDiagonalAbajoDerecha(100)})
        game.schedule(100, {proyectilGatoDL1.direccionDiagonalAbajoIzquierda(50)})

        return 6000
    }
}

object ataqueFinal1 {
    method atacar() {
        const proyectilFinalDR1 = new ProyectilJefe1(position = new PositionMejorada(x = 0, y = 30), id = "DR1")
        const proyectilFinalDL1 = new ProyectilJefe1(position = new PositionMejorada(x = 32, y = 27), id = "DL1")
        const proyectilFinalR1 = new ProyectilJefe1(position = new PositionMejorada(x = 0, y = 2), id = "R1")
        const proyectilFinalL1 = new ProyectilJefe1(position = new PositionMejorada(x = 32, y = 3), id = "L1")

        game.schedule(100, {proyectilFinalDR1.direccionDiagonalAbajoDerecha(100)})
        game.schedule(300, {proyectilFinalDL1.direccionDiagonalAbajoIzquierda(100)})
        game.schedule(100, {proyectilFinalR1.direccionDerecha(100)})
        game.schedule(300, {proyectilFinalL1.direccionIzquierda(100)})

        return 6000
    }
}

object ataqueFinal2 {
    method atacar() {
        const proyectilFinalDR1 = new ProyectilJefe1(position = new PositionMejorada(x = 0, y = 27), id = "DR1")
        const proyectilFinalDL1 = new ProyectilJefe1(position = new PositionMejorada(x = 32, y = 32), id = "DL1")
        const proyectilFinalR1 = new ProyectilJefe1(position = new PositionMejorada(x = 0, y = 2), id = "R1")
        const proyectilFinalL1 = new ProyectilJefe1(position = new PositionMejorada(x = 32, y = 8), id = "L1")

        game.schedule(300, {proyectilFinalDR1.direccionDiagonalAbajoDerecha(100)})
        game.schedule(100, {proyectilFinalDL1.direccionDiagonalAbajoIzquierda(50)})
        game.schedule(300, {proyectilFinalR1.direccionDerecha(100)})
        game.schedule(100, {proyectilFinalL1.direccionIzquierda(50)})

        return 6000
    }
}