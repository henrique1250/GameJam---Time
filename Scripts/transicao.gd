extends Control

@onready var botao_passar = $Panel/CenterContainer/VBoxContainer/Button
@onready var transition_control = $TransicaoControlFade/TransitionControl

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	botao_passar.pressed.connect(_on_button_passar_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_passar_pressed() -> void:
	transition_control.fade_to_scene("res://Scenes/mainscene.tscn")
	#get_tree().change_scene_to_file("res://Scenes/mainscene.tscn")
