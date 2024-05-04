extends Area2D
class_name DetectionMulti

var target_list: Dictionary = {}

signal find_target(id)
signal miss_target(id)
	
func _ready():
	connect("area_entered", self, "_on_Detection_area_entered")
	connect("area_exited", self, "_on_Detection_area_exited")

func _on_Detection_area_entered(area):
	var entity := area.owner as Node
	var entity_id = entity.get_instance_id()
	target_list[entity_id] = entity
	emit_signal("find_target", entity_id)

func _on_Detection_area_exited(area):
	var entity := area.owner as Node
	var entity_id = entity.get_instance_id()
	target_list.erase(entity_id)
	emit_signal("miss_target", entity_id)

func get_nearest_target(position):
	if target_list.empty():
		return
	var min_distance = INF
	var current_distance = INF
	var nearest_target: Node2D = null
	for target in target_list.values():
		current_distance = position.distance_to(target.position)
		if current_distance < min_distance:
			current_distance = min_distance
			nearest_target = target
	return nearest_target
