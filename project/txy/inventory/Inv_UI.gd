extends Control

#onready var inv: Inv = preload("")
onready var slots: Array = $HBoxContainer.get_children()

var is_open = false

func _ready():
	update_solts()
	close()
	
func update_solts():
	for i in range(min(inv.items.size(),slots.size())):
		slots[i].update(inv.items[i])

func _process(delta):
	if Input.is_action_just_pressed("i"):
		if is_open:
			close()
		else:
			open()
			
func open():
	visible = true
	is_open = true
	
func close():
	visible = false
	is_open = false
