extends Area3D

@export var objeto_para_mostrar: MeshInstance3D
var pode_interagir: bool = true

func _ready() -> void:
	input_event.connect(_on_input_event)
	
	if objeto_para_mostrar:
		objeto_para_mostrar.visible = false

func _on_input_event(_camera: Node, event: InputEvent, _position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		interagir()

func interagir() -> void:
	if objeto_para_mostrar:
		objeto_para_mostrar.visible = true
		print("Objeto apareceu!")
	else:
		print("Nenhum objeto configurado!")

func _process(_delta: float) -> void:
	pass
