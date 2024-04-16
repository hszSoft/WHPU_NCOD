class_name StateMachine
extends Node

export(NodePath) var default_state
export(Dictionary) var params

var current_state : StateNode = DefaultStateNode

signal transitioned(state_name)

func _ready():
	yield(owner, "ready")
	if not default_state.is_empty():
		current_state = get_node(default_state)
	current_state.enter()

func _unhandled_input(event: InputEvent):
	current_state.handle_input(event)

func _process(delta: float):
	current_state.update(delta)
	var method_name = "_on_" + current_state.name + "_transition"
	if has_method(method_name):
		call(method_name)

func _physics_process(delta):
	current_state.physics_update(delta)
	
func set_param(name: String, value):
	params[name] = value
	
func get_param(name: String):
	return params[name]

func transition_to(state_node_name: String):
	if not has_node(state_node_name):
		return
	var state = get_node(state_node_name)
	current_state.leave()
	state.enter()
	current_state = state
	emit_signal("transitioned", state.name)
