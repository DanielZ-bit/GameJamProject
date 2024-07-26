extends Area2D

func _on_body_entered(body):
	if body.has_key:
		
		var current_scene = get_tree().current_scene.name

		var scene_number = int(current_scene.split("_")[1]) + 1

		var new_scene_path = "res://scenes/level_" + str(scene_number) + ".tscn"
# Change the scene
		call_deferred("change_scene", new_scene_path)
	else:
		body.position.y += 3
	 # Replace with function body.
func change_scene(scene_path):
	get_tree().change_scene_to_file(scene_path)
