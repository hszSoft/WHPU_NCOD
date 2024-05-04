extends Node

onready var color_rect := $CanvasLayer/ColorRect as ColorRect
var use_gamepad: bool = false

func reload_scene():
	$AnimationPlayer.play("FadeOut")
	yield($AnimationPlayer, "animation_finished")
	get_tree().reload_current_scene()
	$AnimationPlayer.play("FadeIn")
	yield($AnimationPlayer, "animation_finished")

signal change_finished
func change_scene(path: String):
	GameScene.stop_music()
	get_tree().paused = true
	$AnimationPlayer.play("FadeOut")
	yield($AnimationPlayer, "animation_finished")
	get_tree().change_scene(path)
	$AnimationPlayer.play("FadeIn")
	yield($AnimationPlayer, "animation_finished")
	get_tree().paused = false
	emit_signal("change_finished")
	
func change_scene_with_black(path: String, speed: float):
	GameScene.stop_music()
	$AnimationPlayer.play("ColorFadeIn", -1, speed)
	yield($AnimationPlayer, "animation_finished")
	get_tree().change_scene(path)
	$AnimationPlayer.play("ColorFadeOut", -1, speed)
	yield($AnimationPlayer, "animation_finished")
	emit_signal("change_finished")

signal start_finished
func start_game():
	$CanvasLayer/ColorRect.color = Color(0, 0, 0, 1)
	$AnimationPlayer.play("ColorFadeOut")
	var timer = Timer.new()
	timer.one_shot = true
	timer.autostart = true
	timer.wait_time = 3.0
	add_child(timer)
	timer.connect("timeout", self, "_on_Timer_timeout", [timer])
	yield(timer, "timeout")
	$AnimationPlayer.play("ColorFadeIn")
	yield($AnimationPlayer, "animation_finished")
	get_tree().change_scene("res://hsz/scene/main_menu/main_menu.tscn")
	$AnimationPlayer.play("ColorFadeOut")
	yield($AnimationPlayer, "animation_finished")
	emit_signal("start_finished")

func quit_game():
	$AnimationPlayer.play("ColorFadeIn")
	yield($AnimationPlayer, "animation_finished")
	get_tree().quit()
	
func _on_Timer_timeout(timer):
	timer.queue_free()
