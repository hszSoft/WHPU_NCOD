extends Control

export var hearts = 4 setget set_hearts
export var max_hearts = 4 setget set_max_hearts

onready var heartUIFull = $HeartUIFull
onready var heartUIEmpty = $HeartUIEmpty

export var player_stats_path: NodePath
onready var player_stats := get_node(player_stats_path) as Stats

func set_hearts(value):
	#钳制 value ，返回一个不小于 min 且不大于 max 的值
	hearts = clamp(value, 0, max_hearts)
	if heartUIFull != null:
		heartUIFull.rect_size.x = hearts * 15

func set_max_hearts(value):
	max_hearts = max(value, 1)
	self.hearts = min(hearts,max_hearts)
	if heartUIEmpty != null:
		heartUIEmpty.rect_size.x = max_hearts * 15

func _ready():
	#设置玩家生命值
	self.max_hearts = player_stats.max_health
	self.hearts = player_stats.health
	player_stats.connect("health_changed", self, "set_hearts")
	player_stats.connect("max_health_changed", self, "set_max_hearts")
