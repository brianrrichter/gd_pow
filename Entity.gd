extends "res://EntityBase.gd"

func _init():
	points = -30
	escaped_points = 5

#extends Area2D
#
#var move_speed = 50.0
#var direction = Vector2.RIGHT
#onready var type = e_type.FRIEND
#
#enum e_type {
#	FRIEND,
#	FOE
#}
#
##func _init(type):
##	self.type = type
#
## Called when the node enters the scene tree for the first time.
#func _ready():
#	print("eeeeeeeee")
#	connect("area_entered", self, "on_area_entered")
#
#	if type == e_type.FRIEND:
#		set_self_modulate(Color(0, 0, 1, 1))
#	else :
#		set_self_modulate(Color(1, 0, 0, 1))
#
##	connect(screen_exi)
#	pass # Replace with function body.
#
#func on_area_entered(object):
#	print("aaaaaaa")
#	queue_free()
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	position += direction.normalized() * move_speed * delta
#
#	if position.x < - 50 or position.x > get_viewport().size.x + 50 \
#			or position.y < - 50 or position.y > get_viewport().size.y + 50:
#		queue_free()
#
#
#
#	pass
