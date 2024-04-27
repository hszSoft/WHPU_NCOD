extends Node
class_name StateMachine

export var default_state_path: NodePath
onready var current_state: StateNode = DefaultStateNode setget set_current_state

signal transitioned(state_name)

func _ready():
	yield(owner, "ready")
	for child in get_children():
		child.character = owner
		child.after_ready()
	if not default_state_path.is_empty():
		set_current_state(get_node(default_state_path))

func _unhandled_input(event: InputEvent):
	current_state.handle_input(event)

func _process(delta: float):
	current_state.update(delta)
	if not current_state.enable_transition:
		return
	var method_name = "_on_" + current_state.name + "_transition"
	if has_method(method_name):
		call(method_name, current_state)

func _physics_process(delta):
	current_state.physics_update(delta)
	
func set_current_state(state: StateNode):
	current_state.leave()
	current_state = state
	current_state.enter()
	emit_signal("transitioned", current_state.name)

func transition_to(state_name: String):
	if not has_node(state_name):
		return
	set_current_state(get_node(state_name))
