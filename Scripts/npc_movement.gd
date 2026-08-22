extends CharacterBody3D
class_name NpcGeneric


@export var destination_npc: Array[Marker3D]
@export var destination_npc_interaction: Array[Marker3D]
@export var sentar_offset_time: float = 0.5

@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D
@onready var idle_timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $Rembot_NPC/AnimationPlayer

enum NPC_States {
	Idle,
	Walking,
	Interact
}

var heading_to_interaction: bool = false
var SPEED: float = 2.0
var current_state: NPC_States
var current_destinition: Marker3D

var walk_count: int = 0
const WALKS_BEFORE_INTERACTION := 3


func _ready() -> void:
	_set_state(NPC_States.Idle)


func _set_state(new_state: NPC_States) -> void:
	current_state = new_state

	match current_state:
		NPC_States.Idle:
			animation_player.play(["idle_1", "idle_2", "idle_breathing"].pick_random())
			idle_timer.start(1.0 + randf())
		NPC_States.Walking:
			animation_player.play("forward")
		NPC_States.Interact:
			_sentar_na_cadeira()


func _physics_process(delta: float) -> void:
	match current_state:
		NPC_States.Idle:
			pass
		NPC_States.Walking:
			var next_path_posi: Vector3 = navigation_agent.get_next_path_position()
			velocity = global_position.direction_to(next_path_posi) * SPEED
			var look_at_target: Vector3 = Vector3(next_path_posi.x, global_position.y, next_path_posi.z)
			if not global_position.is_equal_approx(look_at_target):
				look_at(look_at_target)
		NPC_States.Interact:
			velocity = Vector3.ZERO
			animation_player.play("drunk")

	move_and_slide()


func _on_timer_timeout() -> void:
	decide_next_stage()


func decide_next_stage() -> void:
	if current_state == NPC_States.Idle:
		move_to_marker()
		_set_state(NPC_States.Walking)


func move_to_marker() -> void:
	if destination_npc.is_empty():
		push_warning("destination_npc está vazio em %s" % name)
		return
	current_destinition = destination_npc.pick_random()
	navigation_agent.target_position = current_destinition.global_position


func _on_destination_reached() -> void:
	velocity = Vector3.ZERO

	if heading_to_interaction:
		heading_to_interaction = false
		_set_state(NPC_States.Interact)
		return

	walk_count += 1

	if walk_count >= WALKS_BEFORE_INTERACTION and destination_npc_interaction.size() > 0:
		walk_count = 0
		var marker: Marker3D = destination_npc_interaction.pick_random()
		current_destinition = marker
		navigation_agent.target_position = marker.global_position
		heading_to_interaction = true
		current_state = NPC_States.Walking
	elif destination_npc.size() > 0:
		var marker: Marker3D = destination_npc.pick_random()
		current_destinition = marker
		navigation_agent.target_position = marker.global_position
		current_state = NPC_States.Walking


func _sentar_na_cadeira() -> void:
	if current_destinition == null:
		return

	var marker_sentar: Marker3D = current_destinition

	var tween := create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "global_position", marker_sentar.global_position, sentar_offset_time)
	tween.tween_property(self, "global_rotation", marker_sentar.global_rotation, sentar_offset_time)
	tween.chain().tween_callback(func():
		animation_player.play("drunk")
	)


func _cai_fora() -> void:
	print("oi")
	if current_state == NPC_States.Interact:
		
		
		

func _on_navigation_agent_3d_navigation_finished() -> void:
	_on_destination_reached()
