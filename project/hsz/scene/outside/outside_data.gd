extends Node
class_name OutsideData

var obstacles_destroy = false

var enemy_generator_1_enable = false
var enemy_generator_2_enable = false
var enemy_generator_3_enable = false

func enable_egenerator1():
	enemy_generator_1_enable = true

func enable_egenerator2():
	enemy_generator_2_enable = true
	
func enable_egenerator3():
	enemy_generator_3_enable = true

func _ready():
	pass
	
func reset():
	obstacles_destroy = false
	enemy_generator_1_enable = false
	enemy_generator_2_enable = false
	enemy_generator_3_enable = false
