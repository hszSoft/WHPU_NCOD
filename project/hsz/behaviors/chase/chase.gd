extends StateNode

export var detection_path: NodePath

onready var character = owner as Character
onready var detection = get_node(detection_path) as EnemyDetection

func physics_update(delta):
	if not detection.can_seek_player():
		return
	var direction = (detection.player.global_position - character.global_position).normalized()
	character.move(direction, delta)
