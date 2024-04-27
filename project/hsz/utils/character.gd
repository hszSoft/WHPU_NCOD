extends KinematicBody2D
class_name Character

var velocity := Vector2(0.0, 0.0)
var direction := Vector2(0.0, 0.0)

export var acceleration: float
export var max_speed: float

func move(delta: float):
	if direction == Vector2.ZERO:
		if velocity.length() > acceleration * delta:
			velocity -= velocity.normalized() * acceleration * delta
		else:
			velocity = Vector2.ZERO
	else:
		velocity += direction * acceleration * delta
		velocity = velocity.limit_length(max_speed)

	velocity = move_and_slide(velocity)

func _physics_process(delta):
	move(delta)
