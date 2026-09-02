extends CanvasLayer
var scene: String

func _ready() -> void:
	pass # Replace with function body.



func _process(delta: float) -> void:
	pass

func fade_to_scene(new_scene: String) -> void:
	scene = new_scene
	$AnimationPlayer.play("Fade")

func change_scene() -> void:
	get_tree().change_scene_to_file(scene)
