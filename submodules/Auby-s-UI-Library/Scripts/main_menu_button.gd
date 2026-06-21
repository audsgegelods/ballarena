extends Button

@export var content: String = ""
var tween

func _ready():
	tween = get_tree().create_tween()
	$Label.text = content

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
	tween.parallel().tween_property($".", "scale:x", 1.10, 0.3)
	tween.parallel().tween_property($".", "scale:y", 0.90, 0.3)

func unhover_anim() -> void:
	if disabled: return
	
	if tween and tween.is_running():
		tween.kill()
	
	tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	tween.parallel().tween_property(self, "scale:x", 1, 0.3)
	tween.parallel().tween_property(self, "scale:y", 1, 0.3)
