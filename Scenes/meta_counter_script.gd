extends Label

var contador: int = 0

func _ready() -> void:
	position = Vector2(100, 50)
	add_theme_font_size_override("font_size", 48)
	
	ContadorGlobal.contador_atualizado.connect(_on_contador_atualizado)
	_on_contador_atualizado(ContadorGlobal.contador, ContadorGlobal.meta)

func _on_contador_atualizado(contador: int, meta: int) -> void:
	if contador < meta:
		text = "Meta:" + str(contador) + "/" + str(meta)
	else:
		text = "Meta batida!"
