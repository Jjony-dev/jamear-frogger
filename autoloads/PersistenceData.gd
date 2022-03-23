extends Node

onready var label_last_score := $CanvasLayer/HBoxContainer/Player1/Score1P
onready var label_hi_score := $CanvasLayer/HBoxContainer/HiScore/HiScore

var last_score: int = 0 setget set_score
var hight_score: int = 0
var top: Array = []

var data: Dictionary = {
	"last_score": {"name":"YOU", "pts":0},
	"hi_score": 7000,
	"top": {
		0:{"name":"AAA", "pts":7000},
		1:{"name":"BBB", "pts":6000},
		2:{"name":"CCC", "pts":5000},
		3:{"name":"DDD", "pts":4000},
		4:{"name":"EEE", "pts":3000}
		}
	}

func set_score(amount: int) -> void:
	last_score = amount
	update_label_score(last_score)
	if last_score > hight_score:
		hight_score = last_score
		update_hi_score(hight_score)

func load_current_data() -> void:
	last_score = data["last_score"]["pts"]
	hight_score = data["hi_score"]
	for r in data["top"].keys():
		top.insert(int(r), data["top"][r])

func save_data() -> void:
	var file: File = File.new()
	var err: int = file.open("user://savedata.json", File.WRITE)
	if err != OK:
		print_debug("Error in write")
		return
	else:
		file.store_line(to_json(data))

func load_data() -> void:
	var file: File = File.new()
	var err: int = file.open("user://savedata.json", File.READ)
	if err != OK:
		load_current_data()
		save_data()
		return
	else:
		var dic: Dictionary = parse_json(file.get_as_text())
		data = dic
		load_current_data()

func update_data() -> void:
	data["last_score"] = {"name": "YOU", "pts": last_score}
	data["hi_score"] = hight_score
	data["top"].clear()
	for r in top.size():
		if top[r]["pts"] > last_score:
			continue
		top.insert(r, data["last_score"])
		top.remove(top.size() - 1)
		break
	for k in top.size():
		data["top"][k] = top[k]
	save_data()
	
func update_label_score(amount: int) -> void:
	label_last_score.text = "%05d" % amount

func update_hi_score(amount: int) -> void:
	label_hi_score.text = "%05d" % amount

func _ready() -> void:
	load_data()
	update_label_score(last_score)
	update_hi_score(hight_score)

