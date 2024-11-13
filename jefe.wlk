import entorno.*
import wollok.game.*
import morcilla.*
import general.*
import ataques.*

class Jefe inherits Personaje{
     var property position
     const idleFrames
     var property image = idleFrames.head()
     var property vida
     const property ataques
     var bossfight = null

     const posInicial = new PositionMejorada (x = position.x(), y = position.y())
     const vidaInicial = self.vida()

     method activarIdle() {
          game.onTick(700,"idle"+idleFrames.head(), {self.idleAnimation()})
     }

     method idleAnimation() {
          idleFrames.reverse()
          image = idleFrames.head()
     }

     method estadoInicial() {
        vida = vidaInicial
        bossfight = null
        self.posicionPrevia()
     }

     method posicionPrevia() {
          position = posInicial
          self.mostrar()
     }

     method posicionBatalla() {
          position = new PositionMejorada(x= 15, y=16)
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

const jefePerro = new Jefe (position = new PositionMejorada(x=3, y=2), vida = 4, idleFrames = ["perro0.png", "perro1.png"], ataques = [ataquePerro1, ataquePerro2, ataquePerro3, ataquePerro4])

const jefeGato = new Jefe (position = new PositionMejorada(x=27, y=2), vida = 4, idleFrames = ["gato0.png", "gato1.png"], ataques = [ataqueGato1, ataqueGato2, ataqueGato3])

const jefeFinal = new Jefe (position = new PositionMejorada (x = 15, y = 15), vida = 5, idleFrames = ["morcilla0.png", "morcilla1.png"], ataques = [ataqueFinal1, ataqueFinal2, ataqueFinal3, ataqueFinal4])