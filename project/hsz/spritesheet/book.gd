extends Node2D

signal epilogue
func _process(delta):
	if not $Detection.can_seek_target():
		return
	if Input.is_action_just_pressed("interact"):
		if GameScene.player_items.current_task == "none":
			GameScene.player_items.add_item(ItemsDatabase.BOOK, -1)
			GameScene.player_items.current_task = "getout"
			var dialog = GameScene.start_dialog("pick_book")
			yield(dialog, "timeline_end")
			queue_free()
		elif GameScene.player_items.current_task == "finish":
			GameScene.player_items.add_item(ItemsDatabase.BOOK, -1)
			var dialog = GameScene.start_dialog("pickup")
			yield(dialog, "timeline_end")
			emit_signal("epilogue")
			queue_free()
