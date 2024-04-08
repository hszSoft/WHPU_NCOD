extends CanvasLayer

const AVATAR_MAP={
	"npc":preload("res://twz/image/npc的avatar.png"),
	"player":preload("res://twz/image/player.png"),
}
var dialogs=[]         #对话内容
var current = 0        #第几句话


@onready var content=$Content
@onready var avatar=$Content/Avatar

func _ready():
	hide_dialog_box()
	show_dialog_box([
		{ avatar="npc",text="第一关：《鸡兔同笼》，你准备好了吗？"},
		{avatar="player",text="yes,我需要了解中国古代数学知识，来吧我已经迫不及待了！！"},
		{avatar="npc",text="好的，那么你进去前面的门，然后开始探索吧！"},
		
	])
	
	
func _unhandled_input(event):
	if event.is_action_pressed("ui_accept")	:
		if current+1<dialogs.size():
			_show_dialog(current+1)
		else:
			hide_dialog_box()
		get_viewport().set_input_as_handled()
	
	
	
	
	
	
	
func hide_dialog_box():
	content.hide()
	
	
	
func show_dialog_box(_dialogs):
	dialogs=_dialogs
	content.show()
	_show_dialog(0)
	
	
	
func _show_dialog(index):
	current=index
	var dialog =dialogs[current]
	content.text=dialog.text
	#content.texture=AVATAR_MAP[dialog.avatar]
	
