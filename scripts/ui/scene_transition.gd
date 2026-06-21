extends CanvasLayer

@onready var anim_player: AnimationPlayer = $AnimationPlayer

signal wipe_transition_entered
signal wipe_transition_exited

func wipe_transition() -> void:
	anim_player.play("wipe_enter")
	await anim_player.animation_finished
	print("SceneTransition: entered wipe animation")
	wipe_transition_entered.emit()
	
	anim_player.play("wipe_exit")
	await anim_player.animation_finished
	print("SceneTransition: exited wipe animation")
	wipe_transition_exited.emit()
