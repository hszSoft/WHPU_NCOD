extends StateNode

var fear_detection: Detection = null
var chase_detection: Detection = null

func after_ready():
	fear_detection = character.get_node("FearDetection")
	chase_detection = character.get_node("ChaseDetection")

func physics_update(delta):
	if not chase_detection.can_seek_target():
		character.direction = Vector2.ZERO
	else:
		character.direction = (character.global_position - chase_detection.target.global_position).normalized()
