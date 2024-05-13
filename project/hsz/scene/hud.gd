extends CanvasLayer

func set_target_num(num1, num2):
	$Scoreboard.change_chicken_target_num(num1)
	$Scoreboard.change_rabbit_target_num(num2)

func _on_PlayerItems_money_change(num):
	$Scoreboard.change_money(num)

func _on_PlayerItems_chicken_num_change(num):
	$Scoreboard.change_chicken_num(num)
	
func _on_PlayerItems_rabbit_num_change(num):
	$Scoreboard.change_rabbit_num(num)

func _on_PlayerItems_skill_process_change(val):
	$Book.set_current_process(val + 1)

func _on_PlayerItems_skill_8_active():
	$Scoreboard.show_target_num()

func reset():
	$Scoreboard.hide_target_num()
	$Store.reset()
	GameScene.close_store()
	$Book.reset()
	GameScene.close_book()
