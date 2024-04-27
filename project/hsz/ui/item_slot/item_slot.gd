extends Control
class_name ItemSlot

onready var icon_control = $Slot/Icon as TextureRect
onready var quantity_control = $Slot/Quantity as Label
onready var select_control = $Slot/Select as ColorRect

func set_item(id: int, quantity: int):
	if id == -1 || quantity <= 0:
		icon_control.texture = null
		quantity_control.text = ""
	else:
		icon_control.texture = ItemsDatabase.icons[id]
		quantity_control.text = str(quantity)

func set_highlight(is_highlight: bool):
	select_control.visible = is_highlight
