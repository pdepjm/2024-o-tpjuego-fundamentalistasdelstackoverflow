import entorno.*
import wollok.game.*
import morcilla.*
import general.*
import proyectiles.*
import ataques.*

class Jefe {
   var property position
   const property image
   var property vida
   const property ataques
   var bossfight = null

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

   method ataque() {
        // Resto 1 para que sea un valor de la lista
        const ataque = (0.randomUpTo(ataques.size())).roundUp() - 1
        
        return ataques.get(ataque).atacar()
   }

   method nuevaPelea() {
        bossfight = new BossFight (jefe = self)
        bossfight.iniciarPelea()
   }
}

const jefePerro = new Jefe (position = new PositionMejorada(x=3, y=2), vida = 3, image = "celda_roja.png", ataques = [ataquePerro1, ataquePerro2])

const jefeGato = new Jefe (position = new PositionMejorada(x=27, y=2), vida = 3, image = "celda_gris.png", ataques = [ataqueGato1, ataqueGato2])

const jefeFinal = new Jefe (position = new PositionMejorada (x = 15, y = 15), vida = 5, image = "morcilla256.png", ataques = [ataqueFinal1, ataqueFinal2])