import morcilla.*

class Proyectiles {
    var property position
    const id

    method direccionIzquierda(velocidad) {
        self.basicoDireccion()
        game.onTick(velocidad, "proyectilIzquierda" + id, {self.movimientoIzquierda(velocidad)})
    }

    method movimientoIzquierda(velocidad) {
        position.goLeftMejorado(1, 0)    
        if(position.x() == 0)
        {
            game.removeVisual(self)
            game.removeTickEvent("proyectilIzquieda" + id)
        }
    }
    
    method direccionDerecha(velocidad) {
        self.basicoDireccion()
        game.onTick(velocidad, "proyectilDerecha" + id, {self.movimientoDerecha(velocidad)})
    }

    method movimientoDerecha(velocidad) {
        position.goRightMejorado(1, 30)    
        if(position.x() == 30)
        {
            game.removeVisual(self)
            game.removeTickEvent("proyectilDerecha" + id)
        }
    }

    method direccionDiagonalAbajoDerecha(velocidad) {
        self.basicoDireccion()
        game.onTick(velocidad, "proyectilDiagonalAbajoDerecha" + id, {self.movimientoDiagonalAbajoDerecha(velocidad)})
    }

    method movimientoDiagonalAbajoDerecha(velocidad) {
        position.goRightMejorado(1, 30)
        position.goDownMejorado(1, 0)    
        if(position.x() == 30)
        {
            game.removeVisual(self)
            game.removeTickEvent("proyectilDiagonalAbajoDerecha" + id)
        }
    }

    method direccionDiagonalAbajoIzquierda(velocidad) {
        self.basicoDireccion()
        game.onTick(velocidad, "proyectilDiagonalAbajoDerecha" + id, {self.movimientoDiagonalAbajoIzquierda(velocidad)})
    }

    method movimientoDiagonalAbajoIzquierda(velocidad) {
        position.goLeftMejorado(1, 0)
        position.goDownMejorado(1, 0)    
        if(position.x() == 0)
        {
            game.removeVisual(self)
            game.removeTickEvent("proyectilDiagonalAbajoIzquierda" + id)
        }
    }

    method basicoDireccion () {
        game.addVisual(self)
    }

    method tocaMorcilla() {
        morcilla.perderVida()
    }
}  // revisar proyectiles en diagonal