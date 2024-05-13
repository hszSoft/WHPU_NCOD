extends Node
class_name PlayerItems

class ItemData:
	var id: int
	var quantity: int
	var can_use: bool = true
	
	func _init():
		id = -1
		quantity = 0

var items_data: Array = []
var items_map: Dictionary = {}
var item_in_hand: int = 0
var item_can_use: bool = true

signal item_change(idx, new_id, new_quantity)
signal item_in_hand_change(new_idx)
signal item_use(id)

func _ready():
	for i in range(9):
		var item = ItemData.new()
		items_data.append(item)

func switch_to_last_item():
	if item_in_hand != 0:
		item_in_hand -= 1
		emit_signal("item_in_hand_change", item_in_hand + 1, item_in_hand)
	else:
		item_in_hand = 8
		emit_signal("item_in_hand_change", 0, 8)
		
func switch_to_next_item():
	if item_in_hand != 8:
		item_in_hand += 1
		emit_signal("item_in_hand_change", item_in_hand - 1, item_in_hand)
	else:
		item_in_hand = 0
		emit_signal("item_in_hand_change", 8, 0)

func _process(delta):
	if Input.is_action_just_pressed("last_item"):
		switch_to_last_item()
	if Input.is_action_just_pressed("next_item"):
		switch_to_next_item()
	if Input.is_action_just_pressed("use_item"):
		use_item()
		
func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == BUTTON_WHEEL_UP:
			switch_to_last_item()
		elif event.button_index == BUTTON_WHEEL_DOWN:
			switch_to_next_item()

func find_new_place():
	for idx in range(9):
		if items_data[idx].id == -1:
			return idx
	return -1

func add_item(id: int, quantity: int):
	print("add: ", id)
	if items_map.has(id):
		var idx = items_map.get(id)
		var item_data: ItemData = items_data[idx]
		item_data.quantity += quantity
		emit_signal("item_change", idx, id, item_data.quantity)
	else:
		var idx = find_new_place()
		if idx == -1:
			return
		items_map[id] = idx
		items_data[idx].id = id
		items_data[idx].quantity = quantity
		emit_signal("item_change", idx, id, quantity)
		
func delete_item(id: int):
	if items_map.has(id):
		var idx = items_map.get(id)
		var item_data: ItemData = items_data[idx]
		item_data.id = -1
		item_data.quantity = 0	
		items_map.erase(id)
		emit_signal("item_change", idx, -1, 0)

func use_item():
	if not item_can_use:
		return
	if not items_data[item_in_hand].can_use:
		return
	if items_data[item_in_hand].id != -1:
		if items_data[item_in_hand].quantity > 0:
			items_data[item_in_hand].quantity -= 1
		emit_signal("item_use", items_data[item_in_hand].id)
		
		var cooling_time = ItemsDatabase.items_cooling[items_data[item_in_hand].id]
		if cooling_time != 0.0:
			items_data[item_in_hand].can_use = false
			var cooling_timer = Timer.new()
			cooling_timer.wait_time = cooling_time
			cooling_timer.autostart = true
			cooling_timer.one_shot = true
			cooling_timer.connect("timeout", self, "_on_cooling_end", [cooling_timer, item_in_hand])
			add_child(cooling_timer)
		
		if items_data[item_in_hand].quantity == 0:
			items_map.erase(items_data[item_in_hand].id)
			items_data[item_in_hand].id = -1
			items_data[item_in_hand].quantity = 0
		emit_signal("item_change", item_in_hand, items_data[item_in_hand].id, items_data[item_in_hand].quantity)


func _on_cooling_end(timer, idx):
	items_data[idx].can_use = true
	timer.queue_free()

var money: int = 0 setget set_money
signal money_change(num)
func set_money(num):
	money = num
	emit_signal("money_change", num)

var chicken_num: int = 0 setget set_chicken_num
signal chicken_num_change(num)
func set_chicken_num(num):
	chicken_num = num
	emit_signal("chicken_num_change", num)

var chicken_price: int = 20

var rabbit_num: int = 0 setget set_rabbit_num
signal rabbit_num_change(num)
func set_rabbit_num(num):
	rabbit_num = num
	emit_signal("rabbit_num_change", num)

var rabbit_price: int = 30
func _on_enemy_death(type):
	if type == "hen":
		set_chicken_num(chicken_num + 1)
	elif type == "cock":
		set_chicken_num(chicken_num + 1)
	elif type == "rabbit":
		set_rabbit_num(rabbit_num + 1)
	elif type == "krabbit":
		set_rabbit_num(rabbit_num + 1)

var current_task: String = "none" setget set_current_task
func set_current_task(name):
	current_task = name

func is_task_finished(c_num, r_num):
	if chicken_num < c_num:
		return false
	if rabbit_num < r_num:
		return false
	set_chicken_num(chicken_num - c_num)
	set_rabbit_num(rabbit_num - r_num)
	set_money(money + 1.5 * (c_num * chicken_price + r_num * rabbit_price))
	return true

func is_task1_finished():
	return is_task_finished(3, 3)

func is_task2_finished():
	return is_task_finished(6, 2)
	
func is_task3_finished():
	return is_task_finished(8, 4)

func sold_goods():
	if current_task == "finish":
		if chicken_num <= 0 && rabbit_num <= 0:
			GameScene.start_dialog("normal_fail")
		else:
			set_money(money + chicken_num * chicken_price + rabbit_num * rabbit_price)
			set_chicken_num(0)
			set_rabbit_num(0)
			GameScene.start_dialog("sold")
	elif current_task == "task1":
		if is_task1_finished():
			GameScene.start_dialog("task2")
			GameScene.hud.set_target_num(6, 2)
		else:
			GameScene.start_dialog("fail")
	elif current_task == "task2":
		if is_task2_finished():
			GameScene.start_dialog("task3")
			GameScene.hud.set_target_num(8, 4)
		else:
			GameScene.start_dialog("fail")
	elif current_task == "task3":
		if is_task3_finished():
			GameScene.start_dialog("task4")
			GameScene.hud.set_target_num(0, 0)
		else:
			GameScene.start_dialog("fail")

# 是否有指南针
var has_compass: bool = false

# 捕网变大
var is_skill_1: bool = false
# 能开箱子
var is_skill_4: bool = false
# 主角和捕网速度加快
signal skill_5_active
var is_skill_5: bool = false
# 杀手兔概率减小
signal skill_6_active
var is_skill_6: bool = false
# 盈不足，提升出售价格，并且可以赊账买道具
var is_skill_7: bool = false
# 方程
signal skill_8_active
var is_skill_8: bool = false
# 勾股，摧毁赵爽弦图所在处的石头，进入结局
signal obstacles_destroy
var is_skill_9: bool = true

var is_over: bool = false

signal skill_process_change(val)
var current_skill_process: int = -1 setget set_skill_process
func set_skill_process(val):
	current_skill_process = val
	trigger_new_skill(val)
	emit_signal("skill_process_change", val)

func trigger_new_skill(val):
	if val == 0:
		is_skill_1 = true
	elif val == 1:
		$"../HUD/Store".get_node("TextureRect/Goods/Commodity2").visible = true
	elif val == 2:
		ItemsDatabase.items_cooling[ItemsDatabase.NET] /= 2.0
	elif val == 3:
		is_skill_4 = true
	elif val == 4:
		is_skill_5 = true
		emit_signal("skill_5_active")
	elif val == 5:
		is_skill_6 = true
		emit_signal("skill_6_active")
	elif val == 6:
		chicken_price += 10
		rabbit_price += 15
		is_skill_7 = true
	elif val == 7:
		is_skill_8 = true
		emit_signal("skill_8_active")
	elif val == 8:
		GameScene.close_book()
		delete_item(ItemsDatabase.BOOK)
		GameScene.outside_data.obstacles_destroy = true
		current_task = "finish"
		GameScene.hud.set_target_num(0, 0)
		emit_signal("obstacles_destroy")
		
func reset():
	is_skill_1 = false
	is_skill_4 = false
	is_skill_5 = false
	is_skill_6 = false
	is_skill_7 = false
	is_skill_8 = false
	is_skill_9 = false
	
	has_compass = false
	set_money(0)
	set_chicken_num(0)
	set_rabbit_num(0)
	GameScene.hud.set_target_num(0, 0)
	
	item_in_hand = 0
	item_can_use = true
	chicken_price = 20
	rabbit_price = 30
	is_over = false
	current_task = "none"
	current_skill_process = -1
	items_data.clear()
	items_map.clear()
	
	for i in range(9):
		var item = ItemData.new()
		items_data.append(item)
