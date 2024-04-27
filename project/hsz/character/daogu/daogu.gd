extends Character

export var invincible_interval: float = 3.0
export var flicker_interval: float = 0.1

onready var state_machine := $StateMachine
onready var arrow := $Arrow
onready var stats := $Stats

var aim_direction := Vector2(1.0, 0.0)
var right_direction := Vector2(1.0, 0.0)
var animation_direction := Vector2(0.0, 1.0)

func get_input_move_direction():
	var input_direction := Vector2.ZERO
	input_direction.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	input_direction.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	return input_direction.normalized()

func get_input_aim_direction():
	return Input.get_vector("aim_left", "aim_right", "aim_up", "aim_down").normalized()

func _ready():
	stats.set_max_health(5)

func _process(delta):
	var temp_direction = get_input_aim_direction()
	#var temp_direction = get_global_mouse_position() - global_position
	if temp_direction.length() != 0.0:
		aim_direction = temp_direction
		arrow.rotation = right_direction.angle_to(aim_direction)
	
func _physics_process(delta):
	var input_direction = get_input_move_direction()
	if input_direction.length() != 0.0:
		direction = input_direction.normalized()
		animation_direction = direction
	else:
		direction = Vector2.ZERO
		
	if velocity.length() == 0.0:
		state_machine.is_moving = false
	else:
		state_machine.is_moving = true

func _on_Hurtbox_hurt(hitbox):
	if stats.health > 0:
		stats.health -= 1
	$InvincibleTimer.start(invincible_interval)
	$FlickerTimer.start(flicker_interval)
	$Hurtbox.enable = false
	$Hurt.play()

func _on_InvincibleTimer_timeout():
	$Hurtbox.enable = true
	$FlickerTimer.stop()
	$Sprite.modulate.a = 1.0

func _on_FlickerTimer_timeout():
	$Sprite.modulate.a = 1.0 if $Sprite.modulate.a == 0.0 else 0.0
