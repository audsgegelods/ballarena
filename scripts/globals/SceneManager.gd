extends Node

func transition_to_game():
	$SceneTransition.wipe_transition()
	await $SceneTransition.wipe_transition_entered
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	
