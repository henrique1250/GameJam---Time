extends Node3D

signal contador_atualizado(contador: int, meta: int)

var contador: int = 0
var meta: int = 50

func incrementar(valor: int) -> void:
	if contador < meta:
		contador += valor
		if contador > meta:
			contador = meta
	contador_atualizado.emit(contador, meta)
