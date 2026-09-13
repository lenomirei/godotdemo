extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var level_scene: PackedScene = preload("res://level.tscn")
	var level := level_scene.instantiate()
	level.init()
	$"GameLevel".add_child(level)
	
	var scene: PackedScene = load("res://player.tscn") as PackedScene
	var player: Player = scene.instantiate() as Player
	player.position = level.get_node(^"PlayerInitial").position
	player.hp = 3
	player.max_hp = 6
	player.physics_attack_damage = 20
	player.health_changed.connect(player_health_changed)
	player.player_died.connect(handle_player_died)
	$"GameLevel".add_child(player)
	init_hud(player.hp, player.max_hp)

func init_hud(hp: int, max_hp: int) -> void:
	for i in max_hp:
		var texture_rect: TextureRect = TextureRect.new()
		var texture: AtlasTexture = AtlasTexture.new()
		texture.atlas = load("res://assets/Stone_UI_Sprite_Sheet.png")
		texture.region = Rect2(208, 64, 32, 32)
		
		if i >= hp:
			texture.region = Rect2(240, 64, 32, 32)
		else:
			texture.region = Rect2(208, 64, 32, 32)
			
		texture_rect.texture = texture
		$"HUD/HBoxContainer".add_child(texture_rect)
		
func change_hud(old_hp: int, hp: int) -> void:
	for i in range(hp, old_hp):
		var texture_rect: TextureRect = $"HUD/HBoxContainer".get_child(i)
		texture_rect.texture.region = Rect2(240, 64, 32, 32)

func player_health_changed(old_hp: int, hp: int) -> void:
	change_hud(old_hp, hp)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func handle_player_died() -> void:
	get_tree().paused = true
	$"Pause".visible = true

func _on_texture_button_pressed() -> void:
	# restart
	get_tree().paused = false
	get_tree().reload_current_scene() 
	pass # Replace with function body.
