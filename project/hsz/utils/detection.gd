extends Area2D
class_name Detection

signal find_target
signal miss_target

var target: Node2D = null

func can_seek_target():
	return target != null
	
func _ready():
	connect("area_entered", self, "_on_Detection_area_entered")
	connect("area_exited", self, "_on_Detection_area_exited")

func _on_Detection_area_entered(area):
	target = area.owner
	emit_signal("find_target")

func _on_Detection_area_exited(area):
	target = null
	emit_signal("miss_target")
