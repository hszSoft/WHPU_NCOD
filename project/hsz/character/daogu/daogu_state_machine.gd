extends StateMachine

var is_moving: bool = false

func _on_Idle_transition(state):
	if is_moving:
		transition_to("Move")
	
func _on_Move_transition(state):
	if not is_moving:
		transition_to("Idle")
