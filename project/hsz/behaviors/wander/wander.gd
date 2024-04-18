extends StateNode

var character: Character = null
onready var timer := $Timer

var direction : Vector2
var has_stopped : bool

func enter():
	has_stopped = false
	timer.start(rand_range(1.0, 2.0))
	direction.x = rand_range(-10, 10)
	direction.y = rand_range(-10, 10)
	direction = direction.normalized()
	
func physics_update(delta: float):
	if not has_stopped:
		character.move(direction, delta)

func _on_Timer_timeout():
	has_stopped = true
