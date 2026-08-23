extends Area3D

@export var marker_foco: Marker3D 

@onready var camera: Camera3D =  get_tree().get_first_node_in_group("main_camera")
@onready var sinuca: AudioStreamPlayer2D = $MoveSinuca

func _ready() -> void:
	input_event.connect(_on_input_event)

func _on_input_event(_camera, event: InputEvent, _pos, _normal, _idx) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		camera.mover_para(marker_foco)
		tocar_sinuca()

func tocar_sinuca() -> void:
	sinuca.play()
