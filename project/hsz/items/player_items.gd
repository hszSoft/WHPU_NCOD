extends Node
class_name PlayerItems

class ItemData:
	var id: int
	var quantity: int
	
	func _init():
		id = -1
		quantity = 0

var items_data: Array = []
var items_map: Dictionary = {}
var item_in_hand: int = 0

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
	if items_map.has(id):
		var idx = items_map.get(id)
		var item_data: ItemData = items_data[idx]
		item_data.quantity += quantity
		emit_signal("item_change", idx, id, item_data.quantity)
	else:
		var idx = find_new_place()
		if idx == -1:
			return
		items_data[idx].id = id
		items_data[idx].quantity = quantity
		emit_signal("item_change", idx, id, quantity)

func use_item():
	if items_data[item_in_hand].id != -1:
		items_data[item_in_hand].quantity -= 1
		emit_signal("item_use", items_data[item_in_hand].id)
		if items_data[item_in_hand].quantity <= 0:
			items_data[item_in_hand].id = -1
			items_data[item_in_hand].quantity = 0
		emit_signal("item_change", item_in_hand, items_data[item_in_hand].id, items_data[item_in_hand].quantity)
