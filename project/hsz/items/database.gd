extends Node

enum {
	NET,
	MILLET,
	BOOK
}

var icons: Dictionary = {
	NET: preload("res://hsz/items/icons/net.png"),
	MILLET: preload("res://hsz/items/icons/millet.png"),
	BOOK: preload("res://hsz/items/icons/book_icon.png")
}

func get_icon(id: int) -> Texture:
	if not icons.has(id):
		return null
	return icons[id]

var packed_scenes: Dictionary = {
	NET: preload("res://hsz/weapons/net/net.tscn"),
	MILLET: preload("res://hsz/weapons/millet/millet.tscn")
}

var items_usage: Dictionary = {
	NET: funcref(self, "_on_net_use"),
	MILLET: funcref(self, "_on_millet_use"),
	BOOK: funcref(self, "_on_book_use")
}

var items_cooling: Dictionary = {
	NET: 2.0,
	MILLET: 1.0,
	BOOK: 0.0
}

func _on_net_use(player, weapon_parent):
	var instanced_net = packed_scenes[NET].instance()
	instanced_net.position = player.position
	instanced_net.move_direction = player.aim_direction
	if GameScene.player_items.is_skill_1:
		instanced_net.scale = Vector2(0.45, 0.45)
	if GameScene.player_items.is_skill_5:
		instanced_net.max_speed = 300

	weapon_parent.add_child(instanced_net)

func _on_millet_use(player, weapon_parent):
	var instanced_millet = packed_scenes[MILLET].instance()
	instanced_millet.position = player.position
	weapon_parent.add_child(instanced_millet)

func _on_book_use(player, weapon_parent):
	GameScene.open_book()
