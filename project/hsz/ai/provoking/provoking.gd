extends StateMachine

onready var idle_timer := $Idle/RandomTimer
export var idle_transition_probability: float = 80.0
var idle_to_wander: bool = false

func should_fear() -> bool:
	return $FearAfterChase.fear_detection.can_seek_target()

func should_chase() -> bool:
	return $Chase.detection.can_seek_target()

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
	if should_fear():
		transition_to("FearAfterChase")
	elif should_chase():
		transition_to("Chase")

func _on_Wander_transition(state: StateNode):
	if $Wander.finished:
		idle_timer.random_start()
		transition_to("Idle")
	if should_fear():
		transition_to("FearAfterChase")
	elif should_chase():
		transition_to("Chase")

func _on_FearAfterChase_transition(state: StateNode):
	if not should_chase():
		transition_to("Wander")

func _on_Chase_transition(state: StateNode):
	if should_fear():
		transition_to("FearAfterChase")
	if not should_chase():
		transition_to("Wander")
