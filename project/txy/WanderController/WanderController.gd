extends Node2D

#定义可改变自变量初值，漫游的初始范围
export(int) var wander_range = 32

onready var start_position = global_position #获取它刚刚被引用进来的起始位置，也就是该物体刚进来时的位置
onready var target_position = global_position #获取终点位置，而且离起始位置不远

onready var timer = $Timer

func _ready():
	#开始时物体位置更新
	update_target_position()

#用开始位置创建终点位置
func update_target_position():
	#设置游荡范围，创建目标向量
	var target_vector = Vector2(rand_range(-wander_range, wander_range), rand_range(-wander_range, wander_range))
	#这样目标向量永远是相对于开始位置的，它不会远离开始位置
	target_position = start_position + target_vector

#检测Timer剩余时间
func get_time_left():
	return timer.time_left

#开始漫游时间
func start_wander_timer(duration):
	timer.start(duration)

func _on_Timer_timeout():
	#没到一个时间就更新一个新的目标位置（每秒）
	update_target_position()
