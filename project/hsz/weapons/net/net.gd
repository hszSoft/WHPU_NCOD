extends Character

export var duration: float = 1.5
export var flying_duration: float = 0.4
export var move_direction := Vector2(1.0, 0.0)

var is_moving_over: bool = false
var is_trigger: bool = false

func trigger():
	$AnimationPlayer.play("Open")
	$DurationTimer.start(duration)
	is_moving_over = true
	is_trigger = true

func _ready():
	$FlyingTimer.start(flying_duration)
	
func _physics_process(delta):
	if is_moving_over:
		direction = Vector2.ZERO
		move(delta)
	else:
		direction = move_direction
		move(delta)
	
func _on_FlyingTimer_timeout():
	if not is_trigger:
		trigger()

func _on_DurationTimer_timeout():
	$AnimationPlayer.play("Close")
	yield($AnimationPlayer, "animation_finished")
	queue_free()

func _on_Detection_hit(hurtbox):
	if not is_trigger:
		trigger()

func _on_Hitbox_hit(hurtbox):
	pass
