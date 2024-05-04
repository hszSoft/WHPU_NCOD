extends Node
class_name WeaponGenerator

export var player_path: NodePath
onready var player = get_node(player_path) as Character

export var weapon_parent_path: NodePath
onready var weapon_parent = get_node(weapon_parent_path) as Node2D

func _ready():
	GameScene.player_items.connect("item_use", self, "_on_item_use")

func _on_item_use(id):	
	ItemsDatabase.items_usage[id].call_func(player, weapon_parent)
