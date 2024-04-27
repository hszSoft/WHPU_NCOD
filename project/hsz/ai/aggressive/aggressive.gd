extends StateMachine

onready var idle_timer := $Idle/RandomTimer
export var idle_transition_probability: float = 30.0
var idle_to_wander: bool = false

func should_chase():
	return $Chase.detection.can_seek_target()

func should_charm():
	return $Charm.detection.can_seek_target()
	
func transition_to_cc():
	if should_charm():
		transition_to("Charm")
	elif should_chase():
		transition_to("Chase")

func _ready():
	idle_timer.random_start()

func _on_RandomTimer_timeout():
	if rand_range(0, 100) < idle_transition_probability:
		idle_to_wander = true

func _on_Idle_transition(state: StateNode):
	if idle_to_wander:
		idle_to_wander = false
		idle_timer.stop()
		transition_to("Wander")
	transition_to_cc()

func _on_Wander_transition(state: StateNode):
	if $Wander.finished:
		idle_timer.random_start()
		transition_to("Idle")
	transition_to_cc()

func _on_Chase_transition(state: StateNode):
	if should_charm():
		transition_to("Charm")
	if not should_chase():
		transition_to("Wander")

func _on_Charm_transition(state: StateNode):
	if not should_charm():
		transition_to("Wander")
