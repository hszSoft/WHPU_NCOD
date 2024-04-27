extends StateNode

var animation_player: AnimationPlayer = null

func after_ready():
	animation_player = character.get_node("AnimationPlayer")

func select_animation(direction: Vector2) -> String:
	if abs(direction.x) >= abs(direction.y):
		if direction.x > 0:
			return "MoveRight"
		else:
			return "MoveLeft"
	else:
		if direction.y > 0:
			return "MoveDown"
		else:
			return "MoveUp"

func update(_delta: float):
	var animation_name = select_animation(character.animation_direction)
	if animation_name != animation_player.current_animation:
		animation_player.play(animation_name)
