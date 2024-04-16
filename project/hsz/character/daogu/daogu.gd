extends Character

onready var state_machine := $StateMachine

func get_input_direction():
	var input_direction := Vector2.ZERO
	input_direction.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	input_direction.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	return input_direction.normalized()

func _ready():
	pass

func _physics_process(delta):
	move(get_input_direction(), delta)
	if velocity.length() == 0.0:
		state_machine.set_param("is_moving", false)
	else:
		state_machine.set_param("is_moving", true)
