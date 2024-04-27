extends Enemy

func _process(delta):
	if direction.x > 0 and $Sprite.scale.x > 0:
		$Sprite.scale.x *= -1
	elif direction.x < 0 and $Sprite.scale.x < 0:
		$Sprite.scale.x *= -1
