extends KinematicBody2D

var is_player_in: bool = false

signal open
export(Dictionary) var rewards = {}

func _process(delta):
	if not GameScene.player_items.is_skill_4:
		return
	if not is_player_in:
		return
	if Input.is_action_just_pressed("interact"):
		for id in rewards.keys():
			var amount = rewards[id]
			GameScene.player_items.add_item(id, amount)
		emit_signal("open")
		$AnimationPlayer.play("Disappear")
		yield($AnimationPlayer, "animation_finished")
		queue_free()

func _on_Detection_find_target():
	if not GameScene.player_items.is_skill_4:
		return
	is_player_in = true

func _on_Detection_miss_target():
	if not GameScene.player_items.is_skill_4:
		return
	is_player_in = false
