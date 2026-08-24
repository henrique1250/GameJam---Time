extends Area3D
@export var marker_foco: Marker3D 
@onready var camera: Camera3D = get_tree().get_first_node_in_group("main_camera")
@onready var carrossel: Node2D = get_tree().get_first_node_in_group("jukebox_carrossel")
@onready var mudar_song: AudioStreamPlayer2D = $MudarSong
@onready var selec_song: AudioStreamPlayer2D = $SelecSong
@export var musicas: Array[AudioStream] = []
@export var audio_player: AudioStreamPlayer
@export var jukebox_bus_name: String = "Music"
@export_range(0.0, 1.0) var default_volume: float = 0.4
@export var volume_slider_node: VSlider  # arraste o VSlider aqui no Inspector

func _ready() -> void:
	input_event.connect(_on_input_event)
	_set_bus_volume(default_volume)
	if volume_slider_node:
		volume_slider_node.value = default_volume

func _on_input_event(_camera, event: InputEvent, _pos, _normal, _idx) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		camera.mover_para(marker_foco)
		tocar_som_selec()
		print("opa")
		if carrossel:
			carrossel.visible = true

func _on_carrosel_container_song_selected(index: int) -> void:
	if index >= 0 and index < musicas.size():
		mudar_som()
		audio_player.stream = musicas[index]
		audio_player.play()
		print("era pra trocar")

func tocar_som_selec() -> void:
	mudar_song.play()

func mudar_som() -> void:
	selec_song.play()

func _set_bus_volume(value: float) -> void:
	var bus_index = AudioServer.get_bus_index(jukebox_bus_name)
	if bus_index == -1:
		push_warning("Bus de áudio '%s' não encontrado" % jukebox_bus_name)
		return

	if value <= 0.0:
		AudioServer.set_bus_mute(bus_index, true)
	else:
		AudioServer.set_bus_mute(bus_index, false)
		AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))

func _on_v_slider_value_changed(value: float) -> void:
	_set_bus_volume(value)
