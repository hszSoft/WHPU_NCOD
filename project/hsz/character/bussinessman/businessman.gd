extends Character

var can_dialog: bool = false

func _on_Detection_find_target():
	can_dialog = true

func _on_Detection_miss_target():
	can_dialog = false

func _process(delta):
	if can_dialog and Input.is_action_just_pressed("interact"):
		GameScene.start_dialog("normal")
