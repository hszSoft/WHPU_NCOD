extends VBoxContainer
class_name Scoreboard

var hen_num: int = 0 setget set_hen_num
var cock_num: int = 0 setget set_cock_num
var rabbit_num: int = 0 setget set_rabbit_num
var krabbit_num: int = 0 setget set_krabbit_num

func set_hen_num(num):
	hen_num = num
	$Hen/Num.text = str(num)

func set_cock_num(num):
	cock_num = num
	$Cock/Num.text = str(num)
	
func set_rabbit_num(num):
	rabbit_num = num
	$Rabbit/Num.text = str(num)

func set_krabbit_num(num):
	krabbit_num = num
	$KillerRabiit/Num.text = str(num)

func _on_enemy_death(type):
	if type == "hen":
		set_hen_num(hen_num + 1)
	elif type == "cock":
		set_cock_num(cock_num + 1)
	elif type == "rabbit":
		set_rabbit_num(rabbit_num + 1)
	elif type == "krabbit":
		set_krabbit_num(krabbit_num + 1)
