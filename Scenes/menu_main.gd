extends Control

@onready var botao_iniciar = $Panel/CenterContainer/VBoxContainer/Jogar
@onready var botao_sair = $Panel/CenterContainer/VBoxContainer/Sair
@onready var transition_control = $TransicaoControlFade/TransitionControl

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	botao_iniciar.pressed.connect(_on_botao_iniciar_pressed)
	botao_sair.pressed.connect(_on_botao_sair_pressed)
	
func _on_botao_iniciar_pressed():
	transition_control.fade_to_scene("res://Scenes/trancisao_intro.tscn")
	#get_tree().change_scene_to_file("res://Scenes/trancisao_intro.tscn")
	#get_tree().change_scene_to_file("res://Scenes/mainscene.tscn")

func _on_botao_sair_pressed():
	get_tree().quit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	transition_control.fade_to_scene("res://Scenes/controle_game.tscn")
