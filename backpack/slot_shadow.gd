extends Control

class_name SlotShadow

@export var item: Item
@export var count: int

func _initialize(i: Item, c: int) -> void:
	item = i
	count = c

func _ready() -> void:
	$"TextureRect".texture = item.texture
	$"Count".text = String.num_uint64(count)
