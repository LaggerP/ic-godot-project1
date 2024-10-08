extends Control
@onready var click_sound: AudioStreamPlayer = $ClickSound
const LEVEL_SCENE = preload("res://scenes/levels/scene.tscn")
const CREDITS = preload("res://scenes/credits.tscn")
const MENU_SELECTION_CLICK = preload("res://assets/sounds/MenuSelectionClick.wav")

func _on_start_pressed() -> void:
	reproduce_click_sound()
	GameManager
	get_tree().paused = false
	get_tree().change_scene_to_packed(LEVEL_SCENE)
	
func _on_exit_pressed() -> void:
	reproduce_click_sound()
	get_tree().quit() # default behavior

func _on_credits_pressed() -> void:
	reproduce_click_sound()
	get_tree().change_scene_to_packed(CREDITS)
	
func reproduce_click_sound():
	if !click_sound.is_playing():
		click_sound.stream = MENU_SELECTION_CLICK
		click_sound.play()
