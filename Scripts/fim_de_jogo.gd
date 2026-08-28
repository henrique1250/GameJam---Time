extends Control

@onready var botao_denovo = $Panel/CenterContainer/VBoxContainer/Denovo
@onready var botao_voltar = $Panel/CenterContainer/VBoxContainer/Voltar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	botao_denovo.pressed.connect(_on_botao_denovo_pressed)
	botao_voltar.pressed.connect(_on_botao_voltar_pressed)

func _on_botao_denovo_pressed():
	get_tree().change_scene_to_file("res://Scenes/mainscene.tscn")

func _on_botao_voltar_pressed():
	get_tree().change_scene_to_file("res://Scenes/menu_main.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
