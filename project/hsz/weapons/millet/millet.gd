extends Node2D

export var invincible_interval: float = 3.0
export var health: int = 3

func _on_Hurtbox_hurt(hitbox):
	$InvincibleTimer.start(invincible_interval)
	$Hurtbox.enable = false
	health -= 1
	if health <= 0:
		$AnimationPlayer.play("Disappear")
		yield($AnimationPlayer, "animation_finished")
		queue_free()

func _on_InvincibleTimer_timeout():
	$Hurtbox.enable = true
