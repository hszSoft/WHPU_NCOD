extends StateMachine

onready var idle_timer = $Idle/Timer
export var idle_interval: float = 2.0
export(float, 0.0, 100.0) var idle_transition_probability = 10.0
var idle_can_transition: bool = false

onready var chase_detection = $Chase.detection as EnemyDetection

func _ready():
	idle_timer.start(idle_interval)

func _on_Idle_transition(state: StateNode):
	if idle_can_transition:
		transition_to("Wander")
		idle_can_transition = false
	if chase_detection.can_seek_player():
		transition_to("Chase")
	
func _on_Wander_transition(state: StateNode):
	if state.has_stopped:
		transition_to("Idle")
	if chase_detection.can_seek_player():
		transition_to("Chase")

func _on_Chase_transition(state: StateNode):
	if not chase_detection.can_seek_player():
		transition_to("Idle")

func _on_Timer_timeout():
	var random_number = rand_range(0.0, 100.0)
	if random_number < idle_transition_probability:
		idle_can_transition = true
	else:
		idle_timer.start(idle_interval)
