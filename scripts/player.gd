extends CharacterBody2D
var health = 2
const SPEED = 3000.0
@onready var animated_sprite_2d = $AnimatedSprite2D
var has_key = false
var push_force = 1500
func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction: Vector2 = Input.get_vector("right","left","up","down")
	if direction.x > 0:
		animated_sprite_2d.play("left")
		animated_sprite_2d.flip_h = false;
	if direction.x < 0:
		animated_sprite_2d.play("left")
		animated_sprite_2d.flip_h = true;
	if direction.y < 0:
		animated_sprite_2d.play("up")
		animated_sprite_2d.flip_h = false;
	if direction.y > 0:
		animated_sprite_2d.play("down")
		animated_sprite_2d.flip_h = false;
	velocity.x = move_toward(velocity.x, SPEED * direction.x * delta, 200 * delta)
	velocity.y = move_toward(velocity.y, SPEED * direction.y * delta, 200 * delta)
		
	move_and_slide()
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() * SPEED/push_force)
	if health <1:
		_dead()

func _dead():
	get_tree().reload_current_scene()
