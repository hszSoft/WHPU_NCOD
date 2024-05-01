extends Character

onready var softCollision = $SoftCollision
func _process(delta):
	if direction.x < 0:
		$Sprite.scale.x = 1
	else:
		$Sprite.scale.x = -1
	
	if softCollision.is_colliding():
		velocity += softCollision.get_push_vector() * delta * 400
	
	if velocity.length() != 0.0:
		$AnimationPlayer.play("Move")
	else:
		$AnimationPlayer.play("Idle")
	velocity = move_and_slide(velocity)

