import entorno.*
import wollok.game.*
import morcilla.*
import general.*
import proyectiles.*

class JefeInteractuable{
   var property position
   const property image
   var property vida = 5

   const posInicial = new PositionMejorada (x = position.x(), y = position.y())

   method posicionPrevia() {
        if(!self.derrotado())
        {
            position = posInicial
            game.addVisual(self)
        }
   }

   method posicionBatalla() {
        
        position = game.center()
   }

   method disminuirVida(){
      vida = (vida - 1).max(0)
   }
   
   method derrotado() = vida <= 0 
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

const jefeDePrueba = new JefeDePrueba (position = new PositionMejorada(x=3, y=2), image = "celda_roja.png")

class JefeGato inherits JefeInteractuable {

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
        const proyectilDR1 = new ProyectilJefe1(position = new PositionMejorada(x = 0, y = 30), id = "DR1")
        const proyectilDL1 = new ProyectilJefe1(position = new PositionMejorada(x = 32, y = 27), id = "DL1")

        game.schedule(100, {proyectilDR1.direccionDiagonalAbajoDerecha(100)})
        game.schedule(300, {proyectilDL1.direccionDiagonalAbajoIzquierda(100)})

        return 6000
    }

    method ataque2() {
        const proyectilDR1 = new ProyectilJefe1(position = new PositionMejorada(x = 0, y = 27), id = "DR1")
        const proyectilDL1 = new ProyectilJefe1(position = new PositionMejorada(x = 32, y = 32), id = "DL1")

        game.schedule(300, {proyectilDR1.direccionDiagonalAbajoDerecha(100)})
        game.schedule(100, {proyectilDL1.direccionDiagonalAbajoIzquierda(50)})

        return 6000
    }
}
const jefeGato = new JefeGato (position = new PositionMejorada(x=27, y=2), image = "celda_gris.png")