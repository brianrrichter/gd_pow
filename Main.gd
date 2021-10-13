extends Node2D

var pow_scene = preload("res://Pow.tscn")
var entity_scene = preload("res://Entity.tscn")
var entity2_scene = preload("res://Entity2.tscn")
var entity3_scene = preload("res://Entity3.tscn")
var pow_instance = null
var position_clicked = Vector2.UP
var position_moved = Vector2.UP

var equilibrium = 0

onready var bar = $Control/EquilibriumBar
onready var status = e_status.RUNNING

enum e_status {
	RUNNING,
	OVER
}


# Called when the node enters the scene tree for the first time.
func _ready():
	
	$SpawnTimer.connect("timeout", self, "on_spawn_timer")
	update_equilibrium(150)
	pass # Replace with function body.

func on_spawn_timer():
	
	if status == e_status.RUNNING: 
		spawn_enemy_at(Vector2(-50,100))
		if equilibrium >= 60:
			spawn_enemy_at(Vector2(-50,200))
		if equilibrium >= 80:
			spawn_enemy_at(Vector2(-50,300))

func spawn_enemy_at(pos):
	var r = randi() % 100
	if r < 40:
		var entity_instance = entity_scene.instance()
		entity_instance.position = pos
		entity_instance.connect("died", self, "on_entity_died")
		entity_instance.connect("escaped", self, "on_entity_escaped")
		add_child(entity_instance)
	elif r < 80:
		var entity2_instance = entity2_scene.instance()
		entity2_instance.position = pos
		entity2_instance.connect("died", self, "on_entity_died")
		entity2_instance.connect("escaped", self, "on_entity_escaped")
		add_child(entity2_instance)
	elif r < 95:
		var entity3_instance = entity3_scene.instance()
		entity3_instance.position = pos
		entity3_instance.connect("died", self, "on_entity_died")
		entity3_instance.connect("escaped", self, "on_entity_escaped")
		add_child(entity3_instance)

func on_entity_died(points):
	if status == e_status.RUNNING: 
		update_equilibrium(equilibrium + points)

func on_entity_escaped(escaped_points):
	if status == e_status.RUNNING: 
		update_equilibrium(equilibrium + escaped_points)

func update_equilibrium(eq):
	equilibrium = eq
	print ("update_equilibrium: ", eq)
	bar.set_current_value(int(equilibrium / 300.0 * 100.0))
	
	if equilibrium >= 300:
		status = e_status.OVER
		$img_won.show()
		$Control/endGameLabel.show()
	elif equilibrium <= 0:
		status = e_status.OVER
		$img_lose.show()
		$Control/endGameLabel.show()

func _input(event):
	if event is InputEventKey and event.scancode == KEY_ESCAPE and event.pressed:
		queue_free()
	if event is InputEventKey and event.scancode == KEY_R and event.pressed:
		get_tree().reload_current_scene()

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				print("mouse pressed")
				instantiate_power(event.position)
			else:
				print("released")
				throw_power(event.position)
	elif event is InputEventMouseMotion:
#		print("Mouse Motion at: ", event.position)
		if is_instance_valid(pow_instance):
			if (pow_instance.status == pow_instance.e_status.CHARGE):
				pow_instance.direction = event.position - position_clicked
				position_moved = event.position


func instantiate_power(var pos):
	pow_instance = pow_scene.instance()
	position_clicked = pos
	pow_instance.position = $CastOrigin.position
	add_child(pow_instance)

func throw_power(var pos):
	if is_instance_valid(pow_instance):
		var direction = (pos - position_clicked).normalized()
		pow_instance.go(direction)
	pass

func _process(delta):
	# 300 ganha, 0 perde
	update() #for draw

func _draw():
	if is_instance_valid(pow_instance) and pow_instance.status == pow_instance.e_status.CHARGE: 
		draw_circle(position_clicked, 5, Color(.5,1,.5))
#	draw_line($CastOrigin.position, get_viewport().get_mouse_position(), Color(1,1,1))
#	draw_line(position_clicked, position_moved, Color(1,1,1))
	var direction = (position_moved - position_clicked).normalized()
	var pos2 = $CastOrigin.position + (direction.normalized() * 100)
	draw_line($CastOrigin.position, pos2, Color(1,1,1))
#	draw_line($CastOrigin.position, ($CastOrigin.position.normalized() + direction).normalized() * 50 , Color(1,1,1))







