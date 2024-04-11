class_name Character
extends KinematicBody2D

var velocity: Vector2

export var acceleration: float
export var max_speed: float

func move(direction: Vector2, delta: float):
	if direction == Vector2.ZERO:
		if velocity.length() > acceleration * delta:
			velocity -= velocity.normalized() * acceleration * delta
		else:
			velocity = Vector2.ZERO
	else:
		velocity += direction * acceleration * delta
		velocity = velocity.limit_length(max_speed)
		
	velocity = move_and_slide(velocity)
