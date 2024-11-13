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
     const vidaInicial = vida

     method estadoInicial() {
        vida = vidaInicial
        bossfight = null
        self.posicionPrevia()
     }

     method posicionPrevia() {
     if(!self.derrotado())
     {
          position = posInicial
          game.addVisual(self)
     }
     }

     method posicionBatalla() {
          position = game.center()
          ataques.randomize()
     }

     method disminuirVida(){
          vida = (vida - 1).max(0)
     }

     method derrotado() = vida <= 0 

     method ataque() {
          const ataqueActual =  ataques.head()
          ataques.remove(ataqueActual)
          ataques.add(ataqueActual)

          return ataqueActual.atacar()
     }

     method nuevaPelea() {
          bossfight = new BossFight (jefe = self)
          bossfight.iniciarPelea()
     }

     method tocaMorcilla() {
          if(!self.derrotado()) {
               morcilla.iniciarPeleaMorcilla(self, 2000)
          }
     }
}

const jefePerro = new Jefe (position = new PositionMejorada(x=3, y=2), vida = 4, image = "perro0.png", ataques = [ataquePerro1, ataquePerro2, ataquePerro3, ataquePerro4])

const jefeGato = new Jefe (position = new PositionMejorada(x=27, y=2), vida = 4, image = "gato0.png", ataques = [ataqueGato1, ataqueGato2, ataqueGato3])

const jefeFinal = new Jefe (position = new PositionMejorada (x = 15, y = 15), vida = 5, image = "morcilla256.png", ataques = [ataqueFinal1, ataqueFinal2, ataqueFinal3, ataqueFinal4])