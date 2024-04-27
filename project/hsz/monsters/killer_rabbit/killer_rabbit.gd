extends Enemy

func _process(delta):
	if is_death:
		return
	
	if direction.x < 0 and $Sprite.scale.x > 0:
		$Sprite.scale.x *= -1
	elif direction.x > 0 and $Sprite.scale.x < 0:
		$Sprite.scale.x *= -1
		
	if velocity.length() == 0.0:
		$AnimationPlayer.play("Idle")
	else:
		$AnimationPlayer.play("Move")

func _on_CrowTimer_timeout():
	$Env.play()
