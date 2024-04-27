extends Control

export var items_data_path: NodePath
onready var items_data = get_node(items_data_path) as PlayerItems

onready var slots: Array = [
	$NinePatchRect/HBoxContainer/Slot1,
	$NinePatchRect/HBoxContainer/Slot2,
	$NinePatchRect/HBoxContainer/Slot3,
	$NinePatchRect/HBoxContainer/Slot4,
	$NinePatchRect/HBoxContainer/Slot5,
	$NinePatchRect/HBoxContainer/Slot6,
	$NinePatchRect/HBoxContainer/Slot7,
	$NinePatchRect/HBoxContainer/Slot8,
	$NinePatchRect/HBoxContainer/Slot9
]

func _ready():
	items_data.connect("item_change", self, "_on_item_change")
	items_data.connect("item_in_hand_change", self, "_on_item_in_hand_change")
	slots[items_data.item_in_hand].set_highlight(true)

func _on_item_change(idx: int, new_id: int, new_quantity: int):
	var item_slot: ItemSlot = slots[idx]
	item_slot.set_item(new_id, new_quantity)

func _on_item_in_hand_change(old_idx: int, new_idx: int):
	var old_item_slot: ItemSlot = slots[old_idx]
	var new_item_slot: ItemSlot = slots[new_idx]
	old_item_slot.set_highlight(false)
	new_item_slot.set_highlight(true)
