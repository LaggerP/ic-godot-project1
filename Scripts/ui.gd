extends Node

@onready var score_progress: ProgressBar = $Experience/ProgressBar
@onready var meta_enemies: Label = $Experience/MetaEnemies
@onready var next_level: Control = $NextLevel
@onready var finish_game: Control = $FinishGame
@onready var game_over: Control = $GameOver

@onready var prrr_sound: AudioStreamPlayer = $NextLevel/PrrrSound

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("ui_events")
	score_progress.value = 0
	score_progress.max_value = GameManager.get_enemies_to_kill()
	meta_enemies.text = str(GameManager.get_killed_enemies()) + "/" + str(GameManager.get_enemies_to_kill())
	next_level.visible = false
	finish_game.visible = false
	
func update_score():
	score_progress.value = GameManager.get_killed_enemies()
	meta_enemies.text = str(GameManager.get_killed_enemies()) + "/" + str(GameManager.get_enemies_to_kill())

func show_win_panel():
	prrr_sound.play()
	next_level.visible = true
	
func show_finish_game_panel():
	finish_game.visible = true
	
func show_game_over_game_panel():
	game_over.visible = true
	
func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_restart_pressed() -> void:
	game_over.visible = false
	get_tree().paused = false
	get_tree().reload_current_scene()
		
func _on_next_level_pressed() -> void:
	next_level.visible = false
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_weapon_velocity_upgrade_pressed() -> void:
	get_tree().call_group("game_manager", "increment_attack_velocity")
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_weapon_damage_upgrade_pressed() -> void:
	get_tree().call_group("game_manager", "increment_damage")
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_weapon_cooldown_upgrade_pressed() -> void:
	get_tree().call_group("game_manager", "decrement_cooldown")
	get_tree().paused = false
	get_tree().reload_current_scene()
