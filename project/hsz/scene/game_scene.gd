extends Node2D

onready var player_items: PlayerItems = $PlayerItems
onready var player_stats: Stats = $PlayerStats
onready var outside_data: OutsideData = $OutsideData
onready var hud: CanvasLayer = $HUD
onready var bgm: AudioStreamPlayer = $BGM

func _on_RecoveryTimer_timeout():
	player_stats.health += 1

func _on_ItemCanUseTimer_timeout():
	player_items.item_can_use = true

func play_music(path):
	$BGM.stream = load(path)
	$BGM.play()

func stop_music():
	$BGM.stop()

func open_store():
	$HUD/Store.visible = true
	$HUD/Store.mouse_filter = Control.MOUSE_FILTER_STOP

func close_store():
	$HUD/Store.visible = false
	$HUD/Store.mouse_filter = Control.MOUSE_FILTER_IGNORE
	unpause_game()
	
func open_book():
	get_tree().paused = true
	$HUD/Book.visible = true
	$HUD/Store.mouse_filter = Control.MOUSE_FILTER_STOP
	
func close_book():
	get_tree().paused = false
	$HUD/Book.visible = false
	$HUD/Store.mouse_filter = Control.MOUSE_FILTER_IGNORE

func start_dialog(name):
	player_items.item_can_use = false
	var dialog = Dialogic.start(name)
	dialog.pause_mode = Node.PAUSE_MODE_PROCESS
	dialog.connect("dialogic_signal", self, "_on_dialogic_signal")
	$HUD.add_child(dialog)
	get_tree().paused = true
	return dialog

func unpause_game():
	get_tree().paused = false
	$ItemCanUseTimer.start()

func reset_game():
	player_items.reset()
	player_stats.reset()
	outside_data.reset()
	hud.reset()
	hud.visible = false	
	Global.color_rect.visible = false

func _on_dialogic_signal(val):
	if val == "unpause":
		unpause_game()
