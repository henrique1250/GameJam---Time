extends Marker3D

@export var npc_scene: PackedScene
@export var spawn_on_start: bool = true
@export var spawn_interval:float = 5.0
@export var max_npc = 10
@export var spawned_count:int = 1
@onready var timer: Timer = $Timer


func _ready() -> void:
	
	timer.wait_time = spawn_interval
	timer.timeout.connect(_on_spawn_timer_timeout)
	timer.start()
	
	if spawn_on_start:
		spawn_npc()
		
func _on_spawn_timer_timeout() -> void:
	if spawned_count >= max_npc:
		timer.stop()
		return
	
	spawn_npc()
	spawned_count += 1
			

func spawn_npc() -> void:
	if not npc_scene:
		push_warning("Nenhuma cena de NPC atribuída no Spawner!")
		return
	
	var npc_instance = npc_scene.instantiate() as CharacterBody3D
	

	npc_instance.global_transform = global_transform

	get_parent().add_child(npc_instance)
