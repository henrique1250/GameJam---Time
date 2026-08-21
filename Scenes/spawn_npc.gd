extends Marker3D

@export var npc_scene: PackedScene
@export var spawn_on_start: bool = true
@onready var timer: Timer = $Timer


func _ready() -> void:
	if spawn_on_start:
		spawn_npc()

func spawn_npc() -> void:
	if not npc_scene:
		push_warning("Nenhuma cena de NPC atribuída no Spawner!")
		return
	
	var npc_instance = npc_scene.instantiate() as CharacterBody3D
	

	npc_instance.global_transform = global_transform

	get_parent().add_child(npc_instance)
