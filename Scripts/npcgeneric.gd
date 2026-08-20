extends CharacterBody3D
class_name  NpcGeneric


@export var destination_npc: Array[Marker3D]
@onready var navigation_agent: NavigationAgent3D  = $NavigationAgent3D
@onready var idle_timer: Timer = $Idle_timer
@onready var animation_player: AnimationPlayer = $Rembot_NPC/AnimationPlayer

enum NPC_States {
	Idle,
	Walking
}

var SPEED:float = 2.0
var current_state: NPC_States
var current_destinition: Marker3D

func _ready() -> void:
	_set_state(NPC_States.Idle)

	
func _set_state(new_state: NPC_States) -> void:	
	current_state = new_state
	
	match current_state:
		NPC_States.Idle:
			animation_player.play(["idle_1","idle_2","idle_breathing"].pick_random())
			idle_timer.start(1.0 + randf())
		NPC_States.Walking:
			animation_player.play("forward")	
	
func _physics_process(delta: float) -> void:
	match current_state:
		NPC_States.Idle:
			pass
		NPC_States.Walking:
			var next_path_posi:Vector3 = navigation_agent.get_next_path_position()
			var new_velocity:Vector3 = global_position.direction_to(next_path_posi)	* SPEED
			velocity = new_velocity
			var look_at_target:Vector3 = Vector3(next_path_posi.x,global_position.y,next_path_posi.z)
			if not global_position.is_equal_approx(look_at_target):
				look_at(look_at_target)

			
			move_and_slide()

func _on_idle_timer_timeout() -> void:
	decide_next_stage()
	
	
func decide_next_stage() -> void:
	if current_state == NPC_States.Idle:
		move_to_marker()
		_set_state(NPC_States.Walking)

func move_to_marker() -> void:
		current_destinition = destination_npc.pick_random()
		navigation_agent.target_position = current_destinition.global_position
			
		


func _on_navigation_agent_3d_navigation_finished() -> void:
	_set_state(NPC_States.Idle)
