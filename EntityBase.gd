extends Area2D

var move_speed = 50.0
var direction = Vector2.RIGHT
onready var type = e_type.FRIEND
onready var status = e_status.CHARGE
var points = 0
var escaped_points = 0

signal died
signal escaped

enum e_type {
	FRIEND,
	FOE
}

enum e_status {
	CHARGE,
	RUNNING,
	DYING
}

#func _init(type):
#	self.type = type

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("area_entered", self, "on_area_entered")
	
	status = e_status.RUNNING
#
#	if type == e_type.FRIEND:
#		set_self_modulate(Color(0, 0, 1, 1))
#	else :
#		set_self_modulate(Color(1, 0, 0, 1))
	
#	connect(screen_exi)
	pass # Replace with function body.

func on_area_entered(object):
	print("aaaaaaa")
	die()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if status == e_status.RUNNING:
		position += direction.normalized() * move_speed * delta
		
		if position.x < - 50 or position.x > get_viewport().size.x + 50 \
				or position.y < - 50 or position.y > get_viewport().size.y + 50:
			escaped()
	


	pass

func die():
	emit_signal("died", points)
	queue_free()

func escaped():
	emit_signal("escaped", escaped_points)
	queue_free()
