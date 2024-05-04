extends StateNode

var animation_player: AnimationPlayer = null

func after_ready():
	animation_player = character.get_node("AnimationPlayer")

func enter():
	animation_player.play("Death")
