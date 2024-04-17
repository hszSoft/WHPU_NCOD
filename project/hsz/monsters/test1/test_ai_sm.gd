extends StateMachine

func _on_Idle_transition(state: StateNode):
	var random_number = rand_range(0.0, 500.0)
	if random_number < 2.0:
		transition_to("Wander")
	
func _on_Wander_transition(state: StateNode):
	if state.has_stopped:
		transition_to("Idle")
