extends StateMachine

onready var idle_timer := $Idle/RandomTimer
export var idle_transition_probability: float = 30.0
var idle_to_wander: bool = false

export var fear_radius_after_charm: float = 96
export var original_fear_radius: float = 192

func should_fear():
	return $Fear.detection.can_seek_target()

func should_charm():
	return $Charm.detection.can_seek_target()

func transition_to_fc():
	if should_fear():
		transition_to("Fear")
	elif should_charm():
		transition_to("Charm")

func _ready():
	idle_timer.random_start()

func _on_RandomTimer_timeout():
	if rand_range(0, 100) < idle_transition_probability:
		idle_to_wander = true

func _on_Idle_transition(state: StateNode):
	if idle_to_wander:
		idle_timer.stop()
		idle_to_wander = false
		transition_to("Wander")
	transition_to_fc()

func _on_Wander_transition(state: StateNode):
	if $Wander.finished:
		idle_timer.random_start()
		transition_to("Idle")
	transition_to_fc()

func _on_Fear_transition(state: StateNode):
	if not should_fear():
		transition_to("Wander")

func _on_Charm_transition(state: StateNode):
	if should_fear():
		transition_to("Fear")
	if not should_charm():
		transition_to("Wander")
