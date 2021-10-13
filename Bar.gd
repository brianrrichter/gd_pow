extends Control


onready var bar = $TextureProgress


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_current_value(value):
	print("set_curren_value: ", value)
	bar.value = value

