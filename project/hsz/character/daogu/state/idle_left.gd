extends StateNode

onready var daogu = owner as Character
onready var animation_player = owner.get_node("AnimationPlayer") as AnimationPlayer

func enter():
	animation_player.play("IdleLeft")
	
func leave():
	pass

func handle_input(_event: InputEvent):
	pass

func update(_delta: float):
	if daogu.velocity.length() == 0.0:
		return
	if daogu.velocity.x > 0.0:
		state_machine.transition_to("RunRight")
	else:
		state_machine.transition_to("RunLeft")
	

func physics_update(_delta: float):
	pass
