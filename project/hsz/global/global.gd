extends Node

var use_gamepad: bool = false

func reload_scene():
	$AnimationPlayer.play("FadeOut")
	yield($AnimationPlayer, "animation_finished")
	get_tree().reload_current_scene()
	$AnimationPlayer.play("FadeIn")

func change_scene(path: String):
	$AnimationPlayer.play("FadeOut")
	yield($AnimationPlayer, "animation_finished")
	get_tree().change_scene(path)
	$AnimationPlayer.play("FadeIn")

func start_game():
	$CanvasLayer/ColorRect.color = Color(0, 0, 0, 1)
	$AnimationPlayer.play("ColorFadeOut")
	var timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = 3.0
	add_child(timer)
	timer.start()
	yield(timer, "timeout")
	$AnimationPlayer.play("ColorFadeIn")
	yield($AnimationPlayer, "animation_finished")
	get_tree().change_scene("res://hsz/scene/main_menu/main_menu.tscn")
	$AnimationPlayer.play("ColorFadeOut")

func quit_game():
	$AnimationPlayer.play("ColorFadeIn")
	yield($AnimationPlayer, "animation_finished")
	get_tree().quit()
