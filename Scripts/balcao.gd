extends Area3D

@export var marker_foco: Marker3D 

@onready var camera: Camera3D = get_node("/root/Main/Camera3D") 

func _ready() -> void:
	input_event.connect(_on_input_event)

func _on_input_event(_camera, event: InputEvent, _pos, _normal, _idx) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		camera.mover_para(marker_foco)
