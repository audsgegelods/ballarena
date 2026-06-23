extends CharacterBody2D

@export var show_debug: bool = true
var player = null

#Movement
@export var move_speed:= 100
@export var turn_speed:= 0.08
var move_dir: Vector2 = Vector2.ZERO

#Rotation
var rotate_speed: float = 1
var rotate_dir = -1

# Knockback
var max_knockback: float = 550
var knockback_speed: float = 0.0
var knockback_dir: Vector2 = Vector2.ZERO
var knockback_decay: float = 450


#Sprite
@onready var sprite = $Sprite

func _ready() -> void:
	$Debug.visible = show_debug
	player = get_tree().get_nodes_in_group("player")[0]

func _physics_process(delta) -> void:	
	sprite.rotate(rotate_speed * rotate_dir * delta)
	
	
	if player:
		if knockback_speed != 0:
			knockback_speed = move_toward(knockback_speed, 0, knockback_decay * delta)	
		move_dir = (player.get_pos()- self.position).normalized()
		self.velocity = (move_dir * move_speed) + (knockback_dir * knockback_speed)
		move_and_slide()
		
func _process(delta) -> void:
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
	$Debug/RotateDirArrow.flip_h = (rotate_dir == 1)
	$Debug/RotateSpeedText.text = str(rotate_speed)

func add_rotate_speed(speed) -> void:
	rotate_speed += speed

func _on_hurtbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var knockback_dir = (body.get_pos() - self.position).normalized()
		var player_rotate_speed = body.get_rotate_speed()
		body.set_knockback(knockback_dir)
		set_knockback(-knockback_dir)
		
		if body.get_rotate_dir() == rotate_dir: # if same direction
			if player_rotate_speed > rotate_speed: # if player faster than enemy
				add_rotate_speed(-player_rotate_speed / 2) # slow down enemy
				
			elif player_rotate_speed < rotate_speed: # if player slower than enemy
				body.add_rotate_speed(-rotate_speed / 2) # slow down player
				
			else: # if speeds are equal, slow down both
				body.add_rotate_speed(-rotate_speed / 2) 
				add_rotate_speed(-rotate_speed / 2) 

		else:
			body.add_rotate_speed(rotate_speed / 4) # add speed if player is going opposite
			add_rotate_speed(-player_rotate_speed / 4) # add speed if player is going opposite
			
func die():
	queue_free()

func set_knockback(dir) -> void:
	knockback_dir = dir
	knockback_speed = max_knockback
	
