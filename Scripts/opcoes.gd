extends Control

@onready var panel: Panel = $Panel2

func _ready() -> void:
	panel.visible = false

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("opcoes"):
		if panel.visible:
			fechar_opcoes()
		else:
			abrir_opcoes()
			
			
func abrir_opcoes():
	panel.visible = true
	print("apertou o esc")
	
func fechar_opcoes():
	panel.visible = false
		
	
func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu_main.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
