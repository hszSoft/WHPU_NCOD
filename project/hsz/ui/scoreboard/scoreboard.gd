extends VBoxContainer
class_name Scoreboard

func _ready():
	yield(GameScene, "ready")
	if GameScene.player_items.is_skill_8:
		show_target_num()
	else:
		hide_target_num()

func change_money(num):
	$Coin/Num.text = str(num)
	
func change_chicken_num(num):
	$Chicken/Num.text = str(num)
	
func change_rabbit_num(num):
	$Rabbit/Num.text = str(num)

func change_chicken_target_num(num):
	$ChickenTarget/Num.text = str(num)

func change_rabbit_target_num(num):
	$RabbitTarget/Num.text = str(num)

func show_target_num():
	$ChickenTarget.visible = true
	$RabbitTarget.visible = true
	
func hide_target_num():
	$ChickenTarget.visible = false
	$RabbitTarget.visible = false
