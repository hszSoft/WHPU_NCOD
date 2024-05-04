extends Node2D

var obstacles = preload("res://hsz/scene/outside/obstacles.tscn")

func _ready():
	GameScene.hud.visible = true
	GameScene.player_items.item_can_use = true
	if not GameScene.outside_data.obstacles_destroy:
		$Entity.add_child(obstacles.instance())
	GameScene.player_items.connect("skill_6_active", self, "_on_skill_6_active")
	GameScene.player_items.connect("obstacles_destroy", self, "_on_obstacles_destruction")
	yield(Global, "change_finished")
	if not GameScene.bgm.playing:
		GameScene.play_music("res://hsz/audio/music/EnvironmentBGM.mp3")
	if GameScene.player_items.current_task == "getout":
		GameScene.start_dialog("task1")
	GameScene.hud.set_target_num(3, 3)

func _on_skill_6_active():
	$EnemyGenerator3.weight_list[1] = 5

func _on_obstacles_destruction():
	$FreeCamera.global_position = $Entity/Daogu.global_position
	$FreeCamera.current = true
	$FreeCamera.move_camera_to($Entity/Chest/SpecialChest.global_position)
	yield($FreeCamera, "move_complete")
	$FreeCamera/Timer.start()
	yield($FreeCamera/Timer, "timeout")
	if $Entity.has_node("Obstacles"):
		$Entity.get_node("Obstacles").queue_free()
	$FreeCamera/Timer.start()
	yield($FreeCamera/Timer, "timeout")
	$FreeCamera.move_camera_to($Entity/Daogu.global_position)
	yield($FreeCamera, "move_complete")
	$Entity/Daogu/Camera2D.current = true
