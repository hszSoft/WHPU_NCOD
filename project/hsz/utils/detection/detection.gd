extends Area2D
class_name EnemyDetection

var player: Character = null

func can_seek_player():
	return player != null

func _on_Detection_body_entered(body):
	player = body

func _on_Detection_body_exited(body):
	player = null
