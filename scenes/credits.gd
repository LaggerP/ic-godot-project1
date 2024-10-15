extends Control

@onready var click_sound: AudioStreamPlayer = $ClickSound
const MENU_SELECTION_CLICK = preload("res://assets/sounds/MenuSelectionClick.wav")
const MAIN_MENU = preload("res://scenes/main_menu.tscn")
func reproduce_click_sound():
	if !click_sound.is_playing():
		click_sound.stream = MENU_SELECTION_CLICK
		click_sound.play()

#FIXME cuando se pierde una partida y entras a creditos, cuando tocas volver no vuelve.
#Pero si tocas creditos antes de jugar y tocas volver, si vuelve...
func _on_exit_pressed() -> void:
	reproduce_click_sound()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
