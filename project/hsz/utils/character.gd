class_name Character
extends KinematicBody2D

var velocity := Vector2(0.0, 0.0)
var direction := Vector2(0.0, 1.0)

export var acceleration: float
export var max_speed: float

func move(_direction: Vector2, _delta: float):
	if _direction.length() != 0.0:
		direction = _direction
	
	if _direction == Vector2.ZERO:
		if velocity.length() > acceleration * _delta:
			velocity -= velocity.normalized() * acceleration * _delta
		else:
			velocity = Vector2.ZERO
	else:
		velocity += _direction * acceleration * _delta
		velocity = velocity.limit_length(max_speed)

	velocity = move_and_slide(velocity)
