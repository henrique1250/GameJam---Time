@tool
extends Node2D
class_name CarroselContainer

@export var spacing: float = 20.0

@export var wraparound_enabled:bool = false
@export var wraparound_radius: float = 300.00
@export var wraparound_weight: float = 50.00

@export_range (0.0,1.0) var opacity_strength: float = 0.35
@export_range  (0.0,1.0) var scale_strengh: float = 0.25
@export_range  (0.01,0.99,0.01) var scale_min: float = 0.1

@export var smoothing_speed: float = 6.5
@export var select_index: int = 0
@export var follow_button_focus: bool = false

@export var position_offset_node: Control = null

func _enter_tree() -> void:
	add_to_group("jukebox_carrossel") #criando um grupo para utilizar no script da jukebox
	
func _ready() -> void:
	visible = false  # começa escondido

func _process(delta: float) -> void:
	if !position_offset_node or position_offset_node.get_child_count() == 0:
		return
	
	#clamp para restringir o valor no seu nimimo e máximo. parametro -> (valor,min,max)
	select_index = clamp(select_index, 0, position_offset_node.get_child_count()-1)
		
	for i in position_offset_node.get_children():
		if wraparound_enabled:
			var max_index_range = max(1, (position_offset_node.get_child_count() -1)/ 2.0)
			var angle = clamp((i.get_index() - select_index) / max_index_range, -1.0,1.0) * PI
			var x = sin(angle) * wraparound_radius		
			var y = cos(angle) * wraparound_weight
			var target_pos = Vector2(x, y-wraparound_weight ) - i.size/2.0
			i.position = lerp(i.position, target_pos, smoothing_speed * delta)
		else:
			var position_x = 0
			if i.get_index() > 0:
				position_x = position_offset_node.get_child(i.get_index() - 1).position.x + position_offset_node.get_child(i.get_index()-1).size.x + spacing
				i.position = Vector2(position_x, -i.size.y / 2.0)
		
		#Parte da escala		
		i.pivot_offset = i.size/2.0 #origem da escala centralizado
		var target_scale = 1.0 - (scale_strengh * abs(i.get_index() - select_index))
		target_scale = clamp(target_scale, scale_min, 1.0)
		i.scale = lerp(i.scale, Vector2.ONE * target_scale, smoothing_speed * delta)	
		
		#Parte da opacidade
		var target_opacity = 1.0 - (scale_strengh * abs(i.get_index() - select_index))
		target_opacity = clamp(target_opacity, 0.0, 1.0)
		i.modulate.a = lerp(modulate.a, target_opacity, smoothing_speed * delta)
		
		if i.get_index() == select_index:
			i.z_index = 1
		else:
			i.z_index = -abs(i.get_index() - select_index)
		
		if follow_button_focus and i.has_focus():
			select_index = i.get_index()	
							
	if wraparound_enabled:
		position_offset_node.position.x = lerp(position_offset_node.position.x, 0.0, smoothing_speed * delta)
	else:
		position_offset_node.position.x = lerp(position_offset_node.position.x, - (position_offset_node.get_child(select_index).position.x + position_offset_node.get_child(select_index).size.x/ 2.0), smoothing_speed * delta)

func _left():
	select_index -= 1
	if select_index < 0:
		select_index = 0  # trava no primeiro item

func _right():
	select_index += 1
	if select_index > position_offset_node.get_child_count() - 1:
		select_index = position_offset_node.get_child_count() - 1
		
				
func _on_left_pressed() -> void:
	_left()


func _on_right_pressed() -> void:
	_right()


#func _on_button_pressed() -> void:
		#song_selected.emit(select_index)


func _on_button_pressed() -> void:
	pass # Replace with function body.
