extends Node

enum {
	NET,
	MILLET
}

var icons: Dictionary = {
	NET: preload("res://hsz/items/icons/net.png"),
	MILLET: preload("res://hsz/items/icons/millet.png")
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
	MILLET: funcref(self, "_on_millet_use")
}

func _on_net_use(player, weapon_parent):
	var instanced_net = packed_scenes[NET].instance()
	instanced_net.position = player.position
	instanced_net.move_direction = player.aim_direction
	weapon_parent.add_child(instanced_net)

func _on_millet_use(player, weapon_parent):
	var instanced_millet = packed_scenes[MILLET].instance()
	instanced_millet.position = player.position
	weapon_parent.add_child(instanced_millet)
