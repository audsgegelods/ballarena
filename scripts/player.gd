extends CharacterBody2D

@export var show_debug: bool = false

#Movement
@export var move_speed:= 8.0
@export var turn_speed:= 0.08
var move_dir: Vector2 = Vector2.ZERO

func _ready() -> void:
	$Debug.visible = show_debug

func _physics_process(delta) -> void:
	move_dir = rotate_towards_cursor()
	self.velocity = move_dir * move_speed
	move_and_slide()

func _process(delta) -> void:
	update_debug_arrows()

func get_cursor_dir() -> Vector2:
	var mouse_pos = get_viewport().get_mouse_position()
	var dir = mouse_pos - self.position
	return dir.normalized()

func rotate_towards_cursor() -> Vector2:
	return move_dir.lerp(get_cursor_dir(), turn_speed).normalized()

func update_debug_arrows() -> void:
	$Debug/CursorPosArrow.rotation = get_cursor_dir().angle()
	$Debug/MoveDirArrow.rotation = rotate_towards_cursor().angle()
