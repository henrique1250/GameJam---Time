extends Control

@onready var botao_denovo = $Panel/CenterContainer/VBoxContainer/Denovo
@onready var botao_voltar = $Panel/CenterContainer/VBoxContainer/Voltar


func _ready() -> void:
	botao_denovo.pressed.connect(_on_botao_denovo_pressed)
	botao_voltar.pressed.connect(_on_botao_voltar_pressed)

func _on_botao_denovo_pressed():
	get_tree().change_scene_to_file("res://Scenes/mainscene.tscn")

func _on_botao_voltar_pressed():
	get_tree().change_scene_to_file("res://Scenes/menu_main.tscn")

func _process(_delta: float) -> void:
	pass
