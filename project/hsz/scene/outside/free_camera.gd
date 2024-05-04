extends Camera2D

signal move_complete

func move_camera_to(new_position):
	var tween = $Tween
	tween.interpolate_property(self, "global_position", 
							   self.global_position, 
							   new_position, 
							   1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	
func _on_Tween_tween_completed(object, key):
	emit_signal("move_complete")
