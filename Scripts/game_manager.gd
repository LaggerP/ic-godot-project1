extends Node

var current_level: int = 1
var level_dictionary: Dictionary = {"1":5, "2":10, "3":15}
var enemies_killed: int = 0
var weapon_upgrades: Dictionary = {
	"increment_damage": false,
	"increment_velocity": false,
	"decrement_cooldown": false,
}

func _ready() -> void:
	add_to_group("enemy_events")
	add_to_group("game_manager")

func on_enemy_dead():
	enemies_killed += 1
	get_tree().call_group("ui_events", "update_score")
	if enemies_killed == get_enemies_to_kill(): new_level()

func new_level():
	#check for more levels
	if !has_next_level(): 
		current_level = 1 #reset level
		get_tree().call_group("ui_events", "show_finish_game_panel")
	increment_current_level()
	enemies_killed = 0
	get_tree().call_group("ui_events", "show_win_panel")
	get_tree().paused = true
	
func game_over():
	#check for more levels
	current_level = 1 #reset level
	enemies_killed = 0 #reset enemies
	get_tree().call_group("ui_events", "show_game_over_game_panel")
	get_tree().paused = true

func increment_current_level() -> void:
	if current_level != level_dictionary.size():
		current_level += 1

func get_current_level() -> int:
	return current_level
	
func get_enemies_to_kill() -> int:
	return level_dictionary[str(current_level)]
	
func get_killed_enemies() -> int:
	return enemies_killed
	
func has_next_level() -> bool:
	return !(current_level == level_dictionary.size())
	
func get_weapon_upgrades() -> Dictionary:
	return weapon_upgrades


func increment_attack_velocity():
	weapon_upgrades["increment_velocity"] = true
func increment_damage():
	weapon_upgrades["increment_damage"] = true
func decrement_cooldown():
	weapon_upgrades["decrement_cooldown"] = true
