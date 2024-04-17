extends StateMachine

func _on_Idle_transition(state):
	if params["is_moving"] == true:
		transition_to("Move")
	
func _on_Move_transition(state):
	if params["is_moving"] == false:
		transition_to("Idle")
