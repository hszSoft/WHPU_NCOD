extends StateNode

var detection: Detection = null

func after_ready():
	detection = character.get_node("FearDetection")

func physics_update(delta):
	if not detection.can_seek_target():
		character.direction = Vector2.ZERO
	else:
		character.direction = (character.global_position - detection.target.global_position).normalized()
