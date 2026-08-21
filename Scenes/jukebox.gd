extends Area3D

@export var marker_foco: Marker3D 

@onready var camera: Camera3D =  get_tree().get_first_node_in_group("main_camera")
@onready var carrossel: Node2D = get_tree().get_first_node_in_group("jukebox_carrossel")

@export var musicas: Array[AudioStream] = []
@export var audio_player: AudioStreamPlayer


func _ready() -> void:
	input_event.connect(_on_input_event)

func _on_input_event(_camera, event: InputEvent, _pos, _normal, _idx) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		camera.mover_para(marker_foco)
		print("opa")
		if carrossel:
			carrossel.visible = true
			
func _on_carrosel_container_song_selected(index: int) -> void:
	if index >= 0 and index < musicas.size():
		audio_player.stream = musicas[index]
		audio_player.play()
		print("era pra trocar")

			
