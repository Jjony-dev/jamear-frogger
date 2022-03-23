extends Node

var Car: PackedScene = preload("res://game/entities/entities/Car.tscn")
var CarScript: GDScript = preload("res://game/entities/entities/Car.gd")
var Turtle: PackedScene = preload("res://game/entities/entities/Tourtle.tscn")
var Water: PackedScene = preload("res://game/entities/entities/Water.tscn")
var Log: PackedScene = preload("res://game/entities/entities/Log.tscn")
var Crocodile: PackedScene = preload("res://game/entities/entities/Crocodile.tscn")
var Snake: PackedScene = preload("res://game/entities/entities/Snake.tscn")

func _ready() -> void:
	pass

func createCarNormal() -> Node2D:
	var temp = Car.instance()
	temp.type = CarScript.CarType.NORMAL
	return temp

func createCarNormal2() -> Node2D:
	var temp = Car.instance()
	temp.type = CarScript.CarType.NORMAL2
	return temp

func createCarSpeed() -> Node2D:
	var temp = Car.instance()
	temp.type = CarScript.CarType.SPEED
	return temp

func createCarLarge() -> Node2D:
	var temp = Car.instance()
	temp.type = CarScript.CarType.LARGE
	return temp

func createTurtleNormal() -> Node2D:
	var temp = Turtle.instance()
	temp.DIVE = false
	return temp

func createTurtleDive() -> Node2D:
	var temp = Turtle.instance()
	temp.DIVE = true
	return temp

func createLogShort() -> Node2D:
	var temp = Log.instance()
	temp.LARGE = 3
	return temp

func createLogMedium() -> Node2D:
	var temp = Log.instance()
	temp.LARGE = 4
	return temp

func createLogLong() -> Node2D:
	var temp = Log.instance()
	temp.LARGE = 5
	return temp

func createWater() -> Node2D:
	var temp = Water.instance()
	return temp

func createCrocodile() -> Node2D:
	var temp = Crocodile.instance()
	return temp

func createSnake() -> Node2D:
	var temp = Snake.instance()
	return temp

func create_from_id(id: int = 0) -> Node2D:
	var obj: Node2D
	match id:
		0:
			obj = createCarNormal()
		1:
			obj = createCarNormal2()
		2:
			obj = createCarSpeed()
		3:
			obj = createCarLarge()
		4:
			obj = createTurtleNormal()
		5:
			obj = createTurtleDive()
		6:
			obj = createCrocodile()
		7:
			obj = createLogShort()
		8:
			obj = createLogMedium()
		9:
			obj = createLogLong()
		10:
			obj = createWater()
		11:
			obj = createSnake()
		_:
			assert(true, "Id %d no existe" % id)
	return obj
