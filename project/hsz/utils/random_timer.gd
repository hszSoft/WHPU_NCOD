extends Timer
class_name RandomTimer

export var interval_base = 1.0
export var interval_offset = 0.2

func _ready():
	connect("timeout", self, "_on_Timer_timeout")
	if autostart:
		random_start()
	
func _on_Timer_timeout():
	if not one_shot:
		random_start()

func random_start():
	var interval = interval_base + rand_range(-interval_offset, interval_offset)
	start(interval)
