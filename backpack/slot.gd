extends Button

class_name Slot

# item data in this slot
@export var item: Item = null:
	set(i):
		item = i
		if i != null:
			$"TextureRect".texture = i.texture
		else:
			$"TextureRect".texture = null
		
var dragging: bool = false
# 松手后需要执行一次"落格"判定（避免 _process 的 else 每帧重复触发）
var perform_drop: bool = false
var slot_shadow_scene: PackedScene
var slot_shadow: SlotShadow = null
@export var count_of_item: int = 0:
	set(count):
		if count == 0:
			$"Label".text = ""
		else:
			count_of_item = count
			$"Label".text = String.num_uint64(count)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	slot_shadow_scene = load("res://slot_shadow.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dragging:
		if slot_shadow == null:
			slot_shadow = slot_shadow_scene.instantiate()
			slot_shadow.item = item
			slot_shadow.count = count_of_item
			slot_shadow.name = "Shadow"
			add_child(slot_shadow)
			_clean_slot()
		slot_shadow.global_position = get_global_mouse_position() - slot_shadow.size / 2
	else:
		if perform_drop:
			perform_drop = false
			_resolve_drop()

func _clean_slot() -> void:
	item = null
	count_of_item = 0

# 松手后：根据鼠标落点决定这份数据去哪里
func _resolve_drop() -> void:
	if slot_shadow == null:
		return
	var target := _slot_under_mouse()
	if target != null and target != self:
		# 鼠标落在一个"空的其它格子"上 → move the data
		var receive_result: bool = target.receive_item_with_slot_shadow(slot_shadow)
		if not receive_result:
			# target slot rejects to receive data → return the data to this slot
			item = slot_shadow.item
			count_of_item = slot_shadow.count
	else:
		# return the slot data
		item = slot_shadow.item
		count_of_item = slot_shadow.count

	# destroy
	slot_shadow.queue_free()
	slot_shadow = null
		

# 返回鼠标当前悬停的那个 Slot（没悬停在格子上则返回 null）
func _slot_under_mouse() -> Slot:
	var node: Node = get_viewport().gui_get_hovered_control()
	while node != null:
		if node is Slot:
			return node
		node = node.get_parent()
	return null

func is_empty() -> bool:
	return item == null

# this function is called by other Slot when they want to receive this slot some data
# return false if the slot can not receive the data
func receive_item_with_slot_shadow(data: SlotShadow) -> bool:
	if item == null:
		item = data.item
		count_of_item = data.count
		return true
	else:
		if item.item_id == data.item.item_id:
			count_of_item += data.count
			return true
		else:
			return false

func _on_button_down() -> void:
	if item != null:
		dragging = true

func _on_button_up() -> void:
	if dragging:
		dragging = false
		perform_drop = true
