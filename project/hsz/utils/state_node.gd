extends Node
class_name StateNode

var enable_transition: bool = true
var character: Node = null

func after_ready():
	pass

func enter():
	pass
	
func leave():
	pass

func handle_input(_event: InputEvent):
	pass

func update(_delta: float):
	pass

func physics_update(_delta: float):
	pass
