extends Area2D
@onready var game_manager = %Game_Manager




func _on_body_entered(body):
	body.has_key = true
	game_manager.has_key()
	queue_free()
