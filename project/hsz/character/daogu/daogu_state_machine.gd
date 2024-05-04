extends StateMachine

var is_moving: bool = false
var is_death: bool = false

func _on_Idle_transition(state):
	if is_death:
		transition_to("Death")
	if Input.is_action_just_pressed("interact"):
		transition_to("Lift")
	if is_moving:
		transition_to("Move")
	
func _on_Move_transition(state):
	if is_death:
		transition_to("Death")
	if Input.is_action_just_pressed("interact"):
		transition_to("Lift")
	if not is_moving:
		transition_to("Idle")

func _on_Lift_transition(state):
	if is_death:
		transition_to("Death")
	if $Lift.is_over:
		transition_to("Idle")
