extends Label

var contador: int = 0
var meta: int = 50

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	atualizar_contador()
	
	position = Vector2(100, 50)
	add_theme_font_size_override("font_size", 48)
	
func decrementar(valor: int):
	if contador < meta:
		contador += valor
	else:
		contador = 0
	atualizar_contador()

func atualizar_contador():
	if contador < meta:
		text = "Meta:" + str(contador) + "/" + str(meta)
	else:
		text = "Meta batida!"
	
	print(contador)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
