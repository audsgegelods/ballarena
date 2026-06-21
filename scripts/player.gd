extends CharacterBody2D

@export var show_debug: bool = false

#Movement
@export var move_speed:= 8.0
var move_dir: Vector2 = Vector2.ZERO

func _ready() -> void:
	$Debug.visible = show_debug

func _physics_process(delta) -> void:
	self.velocity = get_move_dir() * move_speed
	move_and_slide()

func _process(delta) -> void:
	update_debug_arrows()

func get_move_dir() -> Vector2:
	var mouse_pos = get_viewport().get_mouse_position()
	var dir = mouse_pos - self.position
	return dir.normalized()

func update_debug_arrows() -> void:
	$Debug/MoveDirArrow.rotation = get_move_dir().angle()
