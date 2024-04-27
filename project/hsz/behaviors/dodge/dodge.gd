extends StateNode

var detection: Detection = null
var dodge_direction: Vector2
var finished: bool = false

func after_ready():
	detection = character.get_node("ChaseDetection")

func enter():
	if not detection.can_seek_target():
		return
	finished = false
	var direction_to_player = (detection.target.global_position - character.global_position).normalized()
	var angle = 0.0
	var side = rand_range(0, 1)
	if side < 0.5:
		angle = deg2rad(rand_range(-75, -45))
	else:
		angle = deg2rad(rand_range(45, 75))
	
	character.direction = direction_to_player.rotated(angle)
	$RandomTimer.random_start()

func _on_RandomTimer_timeout():
	finished = true
