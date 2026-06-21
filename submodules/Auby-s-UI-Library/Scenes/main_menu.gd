extends Control

@onready var page1 = $UIMuseum0
@onready var page2 = $UIMuseum1

@onready var anim_player: AnimationPlayer = $AnimationPlayer

func _ready():
	page1.show()
	page2.hide()


func _on_ui_museum_0_to_page_2():
	page2.show()
	
	anim_player.play("menu-transition")
	await anim_player.animation_finished
	page1.hide()


func _on_ui_museum_1_to_page_1():
	page1.show()
	
	anim_player.play_backwards("menu-transition")
	await anim_player.animation_finished
	page2.hide()
