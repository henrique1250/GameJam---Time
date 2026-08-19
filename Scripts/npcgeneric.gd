extends CharacterBody3D
class_name  NpcGeneric

@export var destination_npc: Array[Marker3D]

enum NPC_States {
	Idle,
	Walking
}

var current_state: NPC_States = NPC_States.Idle
