extends StateNode

onready var daogu = owner as Character
onready var animation_player = owner.get_node("AnimationPlayer") as AnimationPlayer

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

func enter():
	animation_player.play(select_animation(daogu.direction))

func update(_delta: float):
	var animation_name = select_animation(daogu.direction)
	if animation_name != animation_player.current_animation:
		animation_player.play(animation_name)
