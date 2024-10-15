extends Node2D

@export var player: CharacterBody2D
@export var enemies: Array[PackedScene]

var minute : int:
	set(value):
		minute = value
 
var second : int:
	set(value):
		second = value
		if second >= 10:
			second -= 10
			minute += 1

var distance: float = 600 #distance from player
var can_spawn: bool = true

func _physics_process(_delta: float) -> void:
	#limit the instances of Enemies
	if get_tree().get_node_count_in_group("Enemy") < 200:
		can_spawn = true
	else:
		can_spawn = false

func spawn(pos: Vector2, is_elite: bool = false):
	if not can_spawn and player != null:
		return
		
	var new_enemy = enemies.pick_random().instantiate() as Enemy
	new_enemy.position = pos
	new_enemy.player_ref = player
	
	get_tree().current_scene.add_child(new_enemy)

# get random position from player
func get_rand_position()-> Vector2:
	return player.position + distance * Vector2.RIGHT.rotated(randf_range(0, 2 * PI))

func _on_normal_timeout() -> void:
	#spawn new enemy with each timeout
	second += 1	
	for i in range(second % 10):
		spawn(get_rand_position())

func _on_pattern_timeout() -> void:
	for i in range(75):
		spawn(get_rand_position())

func _on_elite_timeout() -> void:
	spawn(get_rand_position(), true)
