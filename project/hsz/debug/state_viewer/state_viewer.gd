extends Node2D

export var state_machine_path: NodePath
onready var state_machine := get_node(state_machine_path) as StateMachine

onready var label := $Label

func _ready():
	state_machine.connect("transitioned", self, "_on_StateMachine_transitioned")
	
func _on_StateMachine_transitioned(name):
	label.text = name
