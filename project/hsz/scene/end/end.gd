extends Node2D

func _ready():
	GameScene.play_music("res://hsz/audio/music/ending.mp3")
	GameScene.hud.visible = false
	
func _on_Timer1_timeout():
	$AnimationPlayer.play("Scolling")
	yield($AnimationPlayer, "animation_finished")
	Global.change_scene_with_black("res://hsz/scene/main_menu/main_menu.tscn", 1.0)
