extends StateMachine

onready var idle_timer := $Idle/IdleTimer
export var idle_transition_probability: float = 30.0
var idle_to_wander: bool = false

onready var chase_timer := $Chase/ChaseTimer
export var chase_transition_probability: float = 60.0
var chase_to_dodge: bool = false

func should_chase():
	return $Chase.detection.can_seek_target()

func _ready():
	idle_timer.random_start()

func _on_IdleTimer_timeout():
	if rand_range(0, 100) < idle_transition_probability:
		idle_to_wander = true

func _on_Idle_transition(state: StateNode):
	if idle_to_wander:
		idle_to_wander = false
		idle_timer.stop()
		transition_to("Wander")
	if should_chase():
		chase_timer.random_start()
		transition_to("Chase")

func _on_Wander_transition(state: StateNode):
	if $Wander.finished:
		idle_timer.random_start()
		transition_to("Idle")
	if should_chase():
		chase_timer.random_start()
		transition_to("Chase")

func _on_ChaseTimer_timeout():
	if rand_range(0, 100) < chase_transition_probability:
		chase_to_dodge = true

func _on_Chase_transition(state: StateNode):
	if chase_to_dodge:
		chase_to_dodge = false
		chase_timer.stop()
		transition_to("Dodge")
	if not should_chase():
		transition_to("Wander")

func _on_Dodge_transition(state: StateNode):
	if $Dodge.finished:
		chase_timer.random_start()
		transition_to("Chase")
