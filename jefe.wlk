import wollok.game.*
import morcilla.*
import general.*
import proyectiles.*

class JefeInteractuable{
   var property position
   const property image
   var property vida = 3

    const posInicial = position

   method posicionPrevia() {
      position = posInicial
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

const jefeDePrueba = new JefeDePrueba (position = new PositionMejorada(x=10, y=2), image = "celda_roja.png")

