extends Control

func _on_Button1_pressed():
	if GameScene.player_items.money < 15:
		return
	GameScene.player_items.money -= 15
	GameScene.player_items.add_item(ItemsDatabase.MILLET, 1)

func _on_Button2_pressed():
	if GameScene.player_items.money < 50:
		return
	GameScene.player_items.money -= 50
	GameScene.player_items.add_item(ItemsDatabase.MILLET, 3)

func _on_Button3_pressed():
	if GameScene.player_items.money < 100:
		return
	GameScene.player_items.money -= 100
	GameScene.player_stats.max_health = 6
	GameScene.player_stats.health = 6
	
	$TextureRect/Goods/Commodity3.visible = false

func _on_Button4_pressed():
	if GameScene.player_items.money < 80:
		return
	GameScene.player_items.money -= 80
	GameScene.player_items.has_compass = true
	$TextureRect/Goods/Commodity4.visible = false

func _on_Quit_pressed():
	GameScene.close_store()
