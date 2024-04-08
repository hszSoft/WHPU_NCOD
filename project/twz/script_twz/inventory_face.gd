extends Control
@onready var player = $"../../player"
@onready var inventory = $inventory


# Called when the node enters the scene tree for the first time.
func _ready():
	player.toggle_inventory.connect(_on_player_toggle_inventory)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_toggle_inventory():
	inventory.visible=!inventory.visible
	pass # Replace with function body.
