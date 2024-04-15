tool #tool关键字可使脚本有些内容实时在编辑器中显现
extends CenterContainer

export (Texture) var texture = null setget set_texture,get_texture#添加一个texture属性变量，用于设置内部图片显示,setget用于属性变量与函数的连接
export (Vector2) var item_size = Vector2.ZERO setget set_item_size,get_item_size

# 添加一个物品图片大小的属性
var picture = TextureRect.new()

# 添加有关属性设置的函数
func set_texture(value : Texture):
	texture = value
	picture.texture = value
	
func get_texture() -> Texture:
	return texture
	
func set_item_size(value : Vector2):
	item_size = value
	picture.rect_size = value
	
func get_item_size() -> Vector2:
	return item_size

func _init(): #用于编辑内部创造节点的设置
	# 设置初始属性
	add_child(picture)
	picture.expand = true
	picture.rect_size = item_size
