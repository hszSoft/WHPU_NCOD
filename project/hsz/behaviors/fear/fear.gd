extends StateNode

var character: Character = null
var detection: EnemyDetection = null

func physics_update(delta):
	if not detection.can_seek_player():
		return
	var direction = (character.global_position - detection.player.global_position).normalized()
	character.move(direction, delta)
