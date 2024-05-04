extends Character

export var invincible_interval: float = 3.0
export var flicker_interval: float = 0.1
export var speed_after_upgrade: float = 160

onready var state_machine := $StateMachine
onready var aim_arrow := $AimArrow
onready var enemy_arrow := $EnemyArrow
onready var enemy_detection := $DetectEnemy

var aim_direction := Vector2(1.0, 0.0)
var right_direction := Vector2(1.0, 0.0)
var animation_direction := Vector2(0.0, 1.0)
var can_operate: bool = true

func get_input_move_direction():
	var input_direction := Vector2.ZERO
	input_direction.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	input_direction.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	return input_direction.normalized()

func get_input_aim_direction():
	return Input.get_vector("aim_left", "aim_right", "aim_up", "aim_down").normalized()

func _ready():
	can_operate = true
	if GameScene.player_items.is_skill_5:
		max_speed = speed_after_upgrade
	GameScene.player_stats.health = GameScene.player_stats.max_health
	GameScene.player_stats.connect("no_health", self, "_on_no_health")
	GameScene.player_items.connect("skill_5_active", self, "_on_skill_5_active")
	if GameScene.player_items.has_compass:
		$EnemyArrow.visible = true
	else:
		$EnemyArrow.visible = false

func _process(delta):
	if not can_operate:
		return

	var temp_direction: Vector2
	if Global.use_gamepad:
		temp_direction = get_input_aim_direction()
	else:
		temp_direction = (get_global_mouse_position() - global_position).normalized()

	if temp_direction.length() != 0.0:
		aim_direction = temp_direction
		aim_arrow.rotation = right_direction.angle_to(aim_direction)

	if GameScene.player_items.has_compass:
		if enemy_detection.target_list.empty():
			if enemy_arrow.visible:
				enemy_arrow.visible = false
		else:
			if not enemy_arrow.visible:
				enemy_arrow.visible = true
			var nearest_target = enemy_detection.get_nearest_target(position)
			var enemy_direction = (nearest_target.position - position).normalized()
			enemy_arrow.rotation = right_direction.angle_to(enemy_direction)
	
func _physics_process(delta):
	if not can_operate:
		return
	
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
	if GameScene.player_stats.health > 0:
		GameScene.player_stats.health -= 1
	$InvincibleTimer.start(invincible_interval)
	$FlickerTimer.start(flicker_interval)
	$Hurtbox.enable = false
	$Hurt.play()

func _on_InvincibleTimer_timeout():
	$Hurtbox.enable = true
	$FlickerTimer.stop()
	$Character/Sprite.modulate.a = 1.0

func _on_FlickerTimer_timeout():
	$Character/Sprite.modulate.a = 1.0 if $Character/Sprite.modulate.a == 0.0 else 0.0

func _on_ReloadWorldTimer_timeout():
	Global.reload_scene()

func _on_no_health():
	can_operate = false
	direction = Vector2(0.0, 0.0)
	GameScene.player_items.item_can_use = false
	state_machine.is_death = true
	$ReloadWorldTimer.start()

func _on_skill_5_active():
	max_speed = speed_after_upgrade
