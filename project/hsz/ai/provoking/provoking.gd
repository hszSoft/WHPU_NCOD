extends StateMachine

export var idle_interval_min: float = 1.0
export var idle_interval_max: float = 3.0
export(float, 0.0, 100.0) var idle_transition_probability = 20.0
onready var idle_timer = $Idle/Timer
var idle_can_transition: bool = false

export var chase_detection_path: NodePath
export var fear_detection_path: NodePath

onready var chase_detection = get_node(chase_detection_path) as EnemyDetection
onready var fear_detection = get_node(fear_detection_path) as EnemyDetection

func start_idle():
	var interval = rand_range(idle_interval_min, idle_interval_max)
	idle_timer.start(interval)

func _ready():
	start_idle()
	$Chase.detection = chase_detection
	$Chase.character = owner
	$Fear.detection = chase_detection
	$Fear.character = owner
	$Wander.character = owner

func _on_Idle_transition(state: StateNode):
	if idle_can_transition:
		transition_to("Wander")
		idle_can_transition = false
	if fear_detection.can_seek_player():
		transition_to("Fear")
		return
	if chase_detection.can_seek_player():
		transition_to("Chase")
	
func _on_Wander_transition(state: StateNode):
	if state.has_stopped:
		transition_to("Idle")
	if fear_detection.can_seek_player():
		transition_to("Fear")
		return
	if chase_detection.can_seek_player():
		transition_to("Chase")
	
func _on_Fear_transition(state):
	if not chase_detection.can_seek_player():
		transition_to("Wander")
	
func _on_Chase_transition(state):
	if fear_detection.can_seek_player():
		transition_to("Fear")
	if not chase_detection.can_seek_player():
		transition_to("Idle")

func _on_Timer_timeout():
	var random_number = rand_range(0.0, 100.0)
	if random_number < idle_transition_probability:
		idle_can_transition = true
	else:
		start_idle()
