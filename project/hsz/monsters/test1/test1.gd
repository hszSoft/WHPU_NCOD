extends Character

export var flicker_interval: float = 0.1
export var trapped_interval: float = 3.0

onready var speed_before_trapped: float = max_speed

func _process(delta):
	if velocity.x < 0:
		$Sprite.scale.x = -1
	else:
		$Sprite.scale.x = 1

func _on_Hurtbox_hurt(hitbox):
	if hitbox.name != "Hitbox":
		return
	max_speed = 0
	$FlickerTimer.start(flicker_interval)
	$TrappedTimer.start(trapped_interval)
	$Hurtbox.enable = false
	$Stats.health -= 1

func _on_TrappedTimer_timeout():
	max_speed = speed_before_trapped
	$FlickerTimer.stop()
	$Sprite.modulate.a = 1.0
	$Hurtbox.enable = true

func _on_FlickerTimer_timeout():
	$Sprite.modulate.a = 1.0 if $Sprite.modulate.a == 0.0 else 0.0

func _on_Stats_no_health():
	queue_free()
