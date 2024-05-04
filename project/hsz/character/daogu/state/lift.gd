extends StateNode

var animation_player: AnimationPlayer = null
var is_over: bool = true

func after_ready():
	animation_player = character.get_node("AnimationPlayer")

func select_animation(direction: Vector2) -> String:
	if abs(direction.x) >= abs(direction.y):
		if direction.x > 0:
			return "LiftRight"
		else:
			return "LiftLeft"
	else:
		if direction.y > 0:
			return "LiftDown"
		else:
			return "LiftUp"

func enter():
	is_over = false
	animation_player.play(select_animation(character.animation_direction))
	yield(animation_player, "animation_finished")
	is_over = true
