# Teoría detrás del juego y desarrollo
## Morcilla - Movimiento
Nuestro juega cuenta con un protagonista característico: el perro Morcilla.

Por sobre la interacción de Morcilla con el entorno, existe también complejidad en el funcionamiento interno de Morcilla y su movimiento controlado por el usuario.

El movimiento de Morcilla controlado por el usuario se limita a 3 acciones: caminar a la izquierda, caminar a la derecha y saltar
Es mejor empezar por el salto, que es el más complejo y añade complejidad a los otros dos.
Para controlar el salto como un movimiento en dos direcciones (primero sube y luego baja), pudimos haberlo resuelto con un movimiento progresivo hacia arriba y una caída retrasada un tiempo proporcional a la distancia subida. 
Esto habría funcionado perfecto para dar la impresión de salto, siempre y cuando morcilla siempre se mantenga en una misma distancia respecto al suelo.
El problema es que preferimos contemplar la posibilidad de implementar plataformas en el juego, por lo que este mecanismo de salto traería problemas si Morcilla necesitara caer más distancia que la altura que se elevó.
Por ello terminamos definiendo métodos que den un sentido de "gravedad" a Morcilla.


Para ello definimos varios atributos booleanos que nos sirven de *flags* para facilitar el control sobre las posibilidades del usuario

```
  var saltando = false
  var suspendido = false
  var caerActivo = false
```

- *saltando* marca cuándo Morcilla está ascendiendo durante un salto, para que la gravedad no se aplique y Morcilla pueda subir sin inconvenientes
- *suspendido* indica que Morcilla no está en contacto con el suelo, para deshabilitar al jugador la posibilidad de saltar (evitar doble saltos)
- *caerActivo* hace referencia al método **caer( )** de Morcilla:
```
  method caer() {
          if(!caerActivo && suspendido){
          game.onTick(100, "gravedad", {self.gravedad()})
          caerActivo = true
          }
      }
```
El llamado *caer* se realiza internamente en Morcilla con cada movimiento que pueda resultar en una caída (izquierda, derecha o salto). 
Ésto permite que la gravedad no involucre una evaluación eterna de la posición y el estado de caída, sino sólo cuando sea necesaria.
Pero la activación múltiple de este método resulta en una aplicación de la gravedad potenciada, por lo resolvimos utilizar *caerActivo* para que la gravedad solo se active de a una vez.
La acción onTick "gravedad" se desactiva una vez Morcilla ya cayó (momentáneamente es cuando alcanza el suelo, pero luego podrá ampliarse a cuando alcance cualquier plataforma)

Los movimientos a izquierda y derecha son sencillos, excepto por la necesidad de fijar fronteras a izquierda y derecha donde detener el movimiento. 
Debido a la necesidad reiterada de realizar esto, decidimos ampliar la clase ***PositionMutable*** de wollok game para crear una clase ***PositionMejorada*** que hereda la clase anterior pero añada métodos de movimiento limitado.
Por ejemplo:
```
  method goLeftMejorado(pasos, limite) {
          x = (x-pasos).max(limite) 
      }
```

## Morcilla - Entorno de batalla
El juego consiste en diversas pelesa contra jefes (bossfights) configuradas por turnos: un turno de ataque y un turno de defensa o evación de proyectiles.

### Etapa de ATAQUE
Durante el turno de ataque creimos conveniente que Morcilla se coloque en el medio de la pantalla y el jugador no pueda controlar su movimiento, para conseguir una suerte de animación (aun no implementada) de ataque.
Para esto Morcilla cuenta con la *flag* ***movimientoActivo***, que es desactivada cuando Morcilla se sitúa en posición de ataque y es reactivada cuando comienza el turno de defensa. 
Estos llamados son realizados por el objeto correspondiente de la clase ***BossFight*** mediante la interfaz *habilitarAtaque( )*

![morcilla clases drawio (2)](https://github.com/user-attachments/assets/d1ee17e3-9fd2-498e-9f3c-d3ef7bc9f080)

La etapa de ataque finaliza cuando el usuario presiona la tecla indicada en pantalla para atacar.

### Etapa de DEFENSA
Como ya fue mencionado, esta etapa es el turno de ataque del jefe enemigo, donde el jugador deberá esquivar proyectiles dirigidos hacia Morcilla. Morcilla cuenta con un número finito de vidas que determinarán cuando el jugador es derrotado.
Ahora el usuario vuelve a tomar control del movimiento de Morcilla y el jefe en cuestión ejecuta una de sus secuencias de ataque. La clase más interesante de esta etapa son los ***Proyectiles***.

![morcilla clases drawio (4)](https://github.com/user-attachments/assets/c2c3110d-60d2-46af-a727-dd88b26b7e44)

Los proyectiles (específicos para cada jefe para distinguir el *sprite* que llevan) son instanciados por los jefes desde distintas posiciones y envíados a moverse en distintas direcciones.
```
  method direccionIzquierda(velocidad) {
      game.whenCollideDo(self, {=> morcilla.perderVida()})
      game.addVisual(self)
      game.onTick(velocidad, "proyectilIzquierda" + id, {self.movimientoIzquierda(velocidad)})
  }
```
Cuentan con un id identificatorio ya que su movimiento es definido con una acción *onTick* que deberá llevar un nombre identificatorio que permita cancelarla al llegar al final de la pantalla. 
La existencia de varios proyectiles de la misma clase simultánteamente resulta en la creación de múltiples acciones de movimiento para cada proyectil, que de no ser distinguidas por un nombre distinto, generaría que se cancelen la una a la otra de manera indeterminada. 
Junto con su movimiento, los proyectiles evaluarán que, de colisionar con Morcilla, deben hacerle **perderVida( )**.
