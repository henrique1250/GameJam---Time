extends Area3D

@export var minigame_ui: CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	input_event.connect(_on_input_event)

func _on_input_event(_camera: Node, event: InputEvent, _position: Vector3, _normal: Vector3, _shape_idx: int):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		abrir_minigame()

func abrir_minigame():
	if minigame_ui:
		minigame_ui.visible = true
		minigame_ui.ativar_minigame()
		print("Minigame do copo iniciado!")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
