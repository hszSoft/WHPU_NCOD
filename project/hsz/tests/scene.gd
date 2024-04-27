extends Node2D

func _ready():
	$PlayerItems.add_item(ItemsDatabase.NET, 99)
	$PlayerItems.add_item(ItemsDatabase.MILLET, 12)
