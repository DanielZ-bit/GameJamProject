extends CharacterBody2D
@onready var player = $"../Player"
@onready var detection_range = $DetectionRange
@onready var zombie_move = $AnimatedSprite2D
@onready var zombiebreath = $zombiebreath
@onready var zombieattack = $zombieattack
@onready var attack_timer = $attackTimer

var SPEED = 8
var inRange = false
var is_attacking = false
var direction_x = 0
var direction_y = 0
var distance_x = 0
var distance_y = 0
var time = 0
var timeout = 1.8
func _process(delta):
	if zombie_move.animation == "walkdown":
		time += delta
		if time > timeout:
			zombiebreath.play()
			time = 0
		
	if inRange and not is_attacking:
		zombie_move.play("walkdown")
		distance_x = position.x - player.position.x
		distance_y =  position.y - player.position.y
		if distance_x > 0:
			direction_x = -1
			position.x += direction_x * SPEED * delta
		elif distance_x < 0:
			direction_x = 1
			position.x += direction_x * SPEED * delta
		if distance_y > 0:
			direction_y = -1
			position.y += direction_y * SPEED * delta
		elif distance_y < 0:
			direction_y = 1
			position.y += direction_y * SPEED * delta
	move_and_slide()
	if is_attacking:
		zombie_move.play("attack")
		
	
func _on_detection_range_body_entered(body):
	if body.is_in_group("Player"):
		inRange = true
		
func _on_hit_range_body_entered(body):
	if body.is_in_group("Player"):
		is_attacking = true

func _on_hit_range_body_exited(body):
	if body.is_in_group("Player"):
		is_attacking = false 

func _on_animated_sprite_2d_frame_changed():
	var current_anim =zombie_move.animation
	if current_anim == "attack":
		var current_frame = zombie_move.frame
		var total_frames = 2
		if current_frame == total_frames - 1:
			zombieattack.play()
			attack_timer.wait_time = 0.9
			attack_timer.start()
			


func _on_attack_timer_timeout():
	
	player.health = player.health -1
