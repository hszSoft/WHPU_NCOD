class_name StateMachine
extends Node

export var initial_state := NodePath()
onready var current_state := get_node(initial_state)

signal transitioned(state_name)

func _ready():
	assert(not initial_state.is_empty())
	yield(owner, "ready")
	for child in get_children():
		child.state_machine = self
	current_state.enter()

func _unhandled_input(event: InputEvent):
	current_state.handle_input(event)

func _process(delta: float):
	current_state.update(delta)

func _physics_process(delta):
	current_state.physics_update(delta)

func transition_to(state_node_name: String):
	if not has_node(state_node_name):
		return

	var state = get_node(state_node_name)
	
	current_state.leave()
	state.enter()
	current_state = state
	
	emit_signal("transitioned", state.name)
