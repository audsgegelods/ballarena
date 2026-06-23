extends CharacterBody2D

@export var show_debug: bool = false
var totalScore: int = 0

#Movement
@export var move_speed:= 256
@export var turn_speed:= 0.08
var move_dir: Vector2 = Vector2.ZERO

#Rotation
var rotate_speed: float = 2
var rotate_dir = -1
var rotate_decay = 0.2

#Knockback Vectors
var max_knockback: float = 550
var knockback_speed: float = 0.0
var knockback_dir: Vector2 = Vector2.ZERO
var knockback_decay: float = 450

@onready var sprite = $Sprite
var state: String = "turnLeft"

func _ready() -> void:
	$Debug.visible = show_debug
	if rotate_dir == -1:
		state = "turnLeft"
	elif rotate_dir == 1:
		state = "turnRight"

func _physics_process(delta) -> void:
	if state != "stop":
		# Movement Logic
		move_dir = rotate_towards_cursor().normalized()

		if knockback_speed != 0:
			knockback_speed = move_toward(knockback_speed, 0, knockback_decay * delta)	
		
		var move_velocity = move_dir * move_speed
		var knockback_velocity = knockback_dir * knockback_speed

		if knockback_velocity.length_squared() > move_velocity.length_squared():
			self.velocity = knockback_dir * knockback_speed
		else:
			self.velocity = (move_dir * move_speed)
		move_and_slide()
		
		# Rotation Logic
		sprite.rotate(rotate_speed * rotate_dir * delta)

		if Input.is_action_just_pressed("change_Direction"):
			rotate_dir = -rotate_dir
		if rotate_speed <= 0:
			rotate_speed = 0

		else:
			# this math could probably be better rn its a static decay
			rotate_speed -= rotate_decay * delta 

func _process(delta) -> void:
	if state != "stop":
		update_debug_arrows()
		if rotate_speed <= 0:
			die()

func get_cursor_dir() -> Vector2:
	var mouse_pos = get_viewport().get_mouse_position()
	var dir = mouse_pos - self.position
	return dir.normalized()

func rotate_towards_cursor() -> Vector2:
	return move_dir.lerp(get_cursor_dir(), turn_speed).normalized()

func update_debug_arrows() -> void:
	$Debug/CursorPosArrow.rotation = get_cursor_dir().angle()
	$Debug/MoveDirArrow.rotation = move_dir.angle()
	$Debug/RotateDirArrow.flip_h = (rotate_dir == 1)
	$Debug/RotateSpeedText.text = str(rotate_speed)
	
func set_knockback(dir) -> void:
	knockback_dir = dir
	knockback_speed = max_knockback
	
func add_rotate_speed(speed) -> void:
	rotate_speed += speed

func get_pos() -> Vector2:
	return self.position

func get_rotate_speed() -> float:
	return self.rotate_speed

func get_rotate_dir() -> int:
	return self.rotate_dir
	
func die():
	hide()
	state = "stop"
	$RespawnTimer.start()

func _on_respawn_timer_timeout() -> void:
	get_tree().reload_current_scene()
	
func addScore(score) -> void:
	totalScore += score
	
func getScore() -> int:
	return totalScore
