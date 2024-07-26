extends Node

@onready var rich_text_label = $"../Player/RichTextLabel"
var player_key = false

func has_key():
	player_key = true
	var t = Texture.new()
	t = load("res://assets/key.png")
	rich_text_label.add_image(t, 10,10)
