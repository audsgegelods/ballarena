extends Control

signal play_game
@onready var anim_player: AnimationPlayer = $SceneTransition.anim_player

func _on_play_btn_pressed():
	#transition_to_game()
	$"/root/SceneManager".transition_to_game()
	

func _on_settings_btn_pressed():
	pass # Replace with function body.


func _on_quit_btn_pressed():
	pass # Replace with function body.

func transition_to_game():
	$"SceneTransition".wipe_transition()
	await $SceneTransition.wipe_transition_entered
	get_tree().change_scene_to_file("res://scenes/main.tscn")
