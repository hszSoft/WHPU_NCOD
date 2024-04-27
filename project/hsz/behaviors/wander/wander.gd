extends StateNode

onready var timer := $RandomTimer
var direction: Vector2
var finished: bool = false

func enter():
	finished = false
	timer.random_start()
	character.direction = Vector2(rand_range(-1, 1), rand_range(-1, 1)).normalized()

func _on_RandomTimer_timeout():
	finished = true
