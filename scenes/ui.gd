extends CanvasLayer

var player = null
@onready var scoreLabel = $Score

func _ready() -> void:
	player = get_tree().get_nodes_in_group("player")[0]

func _process(delta) -> void:
	if player != null:
		scoreLabel.text = "Score: " + str(player.getScore())
		
