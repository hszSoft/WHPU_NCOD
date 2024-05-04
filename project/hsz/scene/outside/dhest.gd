extends YSort

func _on_SpecialChest_open():
	GameScene.player_items.is_over = true
	Global.change_scene("res://hsz/scene/indoor/indoor.tscn")
