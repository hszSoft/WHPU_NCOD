extends Character

onready var softCollision = $SoftCollision

func _process(delta):
	if direction.x < 0:
		$AnimatedSprite.scale.x = 1
	else:
		$AnimatedSprite.scale.x = -1

	if softCollision.is_colliding():
		velocity += softCollision.get_push_vector() * delta * 400
	
	velocity = move_and_slide(velocity)

