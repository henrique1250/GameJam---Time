extends Camera3D

@export var mouse_sensitivy:= 0.2
@export var max_pitch:= 89.0

var yaw:= 0.0
var pitch:= 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		yaw -= event.relative.x * mouse_sensitivy
		pitch -= event.relative.y * mouse_sensitivy
		
		pitch = clamp(pitch, -max_pitch, max_pitch)
		
		get_parent().rotation.y = deg_to_rad(yaw)
		
		rotation.x = deg_to_rad(pitch)
	pass
