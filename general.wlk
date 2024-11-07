import wollok.game.*

class PositionMejorada inherits MutablePosition {
    method goLeftMejorado(pasos, limite) {
        x = (x-pasos).max(limite) 
    }

    method goRightMejorado(pasos, limite) {
        x = (x+pasos).min(limite) 
    }

    method goUpMejorado(pasos, limite) {
        y = (y+pasos).min(limite) 
    }

    method goDownMejorado(pasos, limite) {
        y = (y-pasos).max(limite) 
    }
}