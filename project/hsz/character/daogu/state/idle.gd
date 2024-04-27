extends StateNode

var animation_player: AnimationPlayer = null

func after_ready():
	animation_player = character.get_node("AnimationPlayer")

func select_animation(direction: Vector2) -> String:
	if abs(direction.x) >= abs(direction.y):
		if direction.x > 0:
			return "IdleRight"
		else:
			return "IdleLeft"
	else:
		if direction.y > 0:
			return "IdleDown"
		else:
			return "IdleUp"

func enter():
	animation_player.play(select_animation(character.animation_direction))
