extends Character
class_name Enemy

signal death(type)

export var flicker_interval: float = 0.1
export var trapped_interval: float = 2.5
export var invincible_interval: float = 3.0

onready var speed_before_trapped: float = max_speed
var is_death: bool = false

var enemy_type: String

func _on_Hurtbox_hurt(hitbox):
	if hitbox.name != "Hitbox":
		return
	max_speed = 0
	$FlickerTimer.start(flicker_interval)
	$TrappedTimer.start(trapped_interval)
	$InvincibleTimer.start(invincible_interval)
	$Hurtbox.enable = false
	$Stats.health -= 1

func _on_TrappedTimer_timeout():
	max_speed = speed_before_trapped

func _on_InvincibleTimer_timeout():
	$Sprite.modulate.a = 1.0
	$Hurtbox.enable = true
	$FlickerTimer.stop()

func _on_FlickerTimer_timeout():
	if not is_death:
		$Sprite.modulate.a = 1.0 if $Sprite.modulate.a == 0.0 else 0.0

func _on_Stats_no_health():
	is_death = true
	$AnimationPlayer.play("Death")
	yield($AnimationPlayer, "animation_finished")
	queue_free()
	emit_signal("death", enemy_type)
