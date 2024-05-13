extends Control
class_name Book

func set_current_process(val):
	if val > 8:
		return
	$Background/Content.text = BookDatabase.contents[val]
	$Background/Left/Price.text = str(BookDatabase.prices[val]) + "铜"

func _ready():
	yield(BookDatabase, "ready")
	set_current_process(0)

func _on_Learn_pressed():
	if GameScene.player_items.current_skill_process >= 8:
		return
	var cost = BookDatabase.prices[GameScene.player_items.current_skill_process + 1]
	if GameScene.player_items.money < cost:
		return
	GameScene.player_items.money -= cost
	GameScene.player_items.current_skill_process += 1
	
	if GameScene.player_items.current_skill_process >= 8:
		GameScene.close_book()

func _on_Quit_pressed():
	GameScene.close_book()

func reset():
	set_current_process(0)
