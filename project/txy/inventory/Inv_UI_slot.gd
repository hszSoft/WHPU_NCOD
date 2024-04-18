extends Panel

onready var item_visual: Sprite2D = $CenterContainer/Panel/Item_Display

func update_xxx(slot: InvSlot):
	if not slot.item:
		item_visual.visible = false
	else:
		item_visual = true
		item_visual.texture = slot.item.texture
