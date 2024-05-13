extends Node2D

onready var daogu_ap := $Entity/Daogu.get_node("AnimationPlayer") as AnimationPlayer

func _ready():
	GameScene.hud.visible = true
	GameScene.player_items.item_can_use = false
	if GameScene.player_items.current_task == "none":
		GameScene.player_items.add_item(ItemsDatabase.NET, -1)
		$Entity/Daogu.position = Vector2(490, 60)
		daogu_ap.play("IdleLeft")
		var instanced_book = preload("res://hsz/spritesheet/book.tscn").instance()
		instanced_book.position = Vector2(135, 44)
		$Entity/Statics.add_child(instanced_book)
		$Ambient.color.a = 1.0
		$Entity/Statics/Candle.get_node("Light2D").energy = 2.0

		yield(Global, "change_finished")
		GameScene.play_music("res://hsz/audio/music/indoor.mp3")
		var dialog = GameScene.start_dialog("narrator")
		dialog.connect("timeline_end", self, "_on_timeline_end")
		
	elif GameScene.player_items.is_over:
		$Entity/Daogu.position = Vector2(490, 60)
		daogu_ap.play("IdleLeft")
		var instanced_book = preload("res://hsz/spritesheet/book.tscn").instance()
		instanced_book.position = Vector2(135, 44)
		instanced_book.connect("epilogue", self, "_on_epilogue")
		$Entity/Statics.add_child(instanced_book)
		$Ambient.color.a = 0.12
		$Entity/Statics/Candle.get_node("Light2D").energy = 0.0
		
		yield(Global, "change_finished")
		GameScene.play_music("res://hsz/audio/music/gear_up.mp3")
		GameScene.start_dialog("getup")
	else:
		$Entity/Daogu.position = Vector2(196, 258)
		daogu_ap.play("IdleUp")

func _on_timeline_end(name):
	$Ambient/AnimationPlayer.play("Fade")

func _on_Detection_find_target():
	if GameScene.player_items.current_task == "none":
		return
	if GameScene.player_items.is_over:
		return
	Global.change_scene("res://hsz/scene/outside/outside.tscn")

func _on_epilogue():
	$Ambient.color = Color(0, 0, 0, 0)
	$Ambient/AnimationPlayer.play("Appear")
	yield($Ambient/AnimationPlayer, "animation_finished")
	var dialog = GameScene.start_dialog("epilogue")
	yield(dialog, "timeline_end")
	Global.color_rect.visible = true
	Global.change_scene_with_black("res://hsz/scene/end/end.tscn", 0.2)
