extends KinematicBody2D

const  speed = 150
var velocity = Vector2.ZERO

func _physics_process(delta):
	var direction_x = Input.get_action_strength("right") - Input.get_action_strength("left")
	velocity.x = direction_x * speed
	move_and_slide(velocity)
	var direction_y = Input.get_action_strength("down") - Input.get_action_strength("up")
	velocity.y = direction_y * speed
	move_and_slide(velocity)
	
	
