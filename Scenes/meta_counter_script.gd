extends Label

var contador: int = 50

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	atualizar_contador()
	
	position = Vector2(100, 50)
	add_theme_font_size_override("font_size", 48)
	
func decrementar(valor: int):
	contador -= valor
	atualizar_contador()

func atualizar_contador():
	text = "Meta:" + str(contador)
	print(contador)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
