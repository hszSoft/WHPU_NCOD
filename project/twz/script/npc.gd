extends Area2D

var condition_start = true        #dialogic.Start 的bool条件
var condition_first = true
var condition_last  = true
var active = false
var my_dialogic=["Start","First","Last"]        
var index = 0                      #下标索引
func _ready():
	connect("body_entered",self,'_on_body_entered')
	connect("body_exited",self,'_on_body_exited')

func _on_Npc_body_entered(body):
	if body.name == 'Daogu':
		active = true
	pass # Replace with function body.


func _on_Npc_body_exited(body):
	if body.name =='Daogu':
		active = false
	pass # Replace with function body.
	
func _input(event):
	if get_node_or_null('DialogicNode')==null:
		if event.is_action_pressed("ui_accept") and active :
			get_tree().paused = true
			var dialogic = Dialogic.start(my_dialogic[index])
			if index<2:
				index+=1
			dialogic.pause_mode = Node.PAUSE_MODE_PROCESS
			dialogic.connect('timeline_end',self,'unpause')
			add_child(dialogic)
			
func unpause(timeline_name):
	get_tree().paused = false
