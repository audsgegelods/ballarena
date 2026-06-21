extends Button

var tween

func _ready():
	tween = get_tree().create_tween()

func _process(delta):
	if is_hovered():
		hover_anim()
	else:
		unhover_anim()

func hover_anim() -> void:
	if disabled: return
	
	if tween and tween.is_running():
		tween.kill()
	
	tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	tween.parallel().tween_property($".", "scale:x", 1.20, 0.3)
	tween.parallel().tween_property($".", "scale:y", 1.20, 0.3)
	tween.parallel().tween_property($".", "rotation", deg_to_rad(10), 0.3).set_trans(Tween.TRANS_ELASTIC)

func unhover_anim() -> void:
	if disabled: return
	
	if tween and tween.is_running():
		tween.kill()
	
	tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	tween.parallel().tween_property($".", "scale:x", 1, 0.3)
	tween.parallel().tween_property($".", "scale:y", 1, 0.3)
	tween.parallel().tween_property($".", "rotation", 0, 0.3)
