extends TextureButton

@onready var camera: Camera3D = get_tree().get_first_node_in_group("main_camera")

#func _ready() -> void:
	

func _on_pressed() -> void:
	camera.voltar_para_geral()
