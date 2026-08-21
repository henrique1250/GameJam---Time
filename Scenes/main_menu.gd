extends Control

class_name MainMenu

@onready var play_button: Button = $CenterContainer/VBoxContainer/Iniciar
@onready var quit_button: Button = $CenterContainer/VBoxContainer/Sair

func _ready() -> void:
	play_button.pressed.connect(_on_play_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/mainscene.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
