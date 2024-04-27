extends StateNode

var detection: Detection = null

func after_ready():
	detection = character.get_node("ChaseDetection")

func physics_update(delta):
	if not detection.can_seek_target():
		character.direction = Vector2.ZERO
		return
	character.direction = (detection.target.global_position - character.global_position).normalized()
