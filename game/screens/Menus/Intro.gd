extends ColorRect

onready var top_1 := $VBoxContainer/SpaceBottom/Ranking/VBoxContainer/Rank1
onready var top_2 := $VBoxContainer/SpaceBottom/Ranking/VBoxContainer/Rank2
onready var top_3 := $VBoxContainer/SpaceBottom/Ranking/VBoxContainer/Rank3
onready var top_4 := $VBoxContainer/SpaceBottom/Ranking/VBoxContainer/Rank4
onready var top_5 := $VBoxContainer/SpaceBottom/Ranking/VBoxContainer/Rank5

func _ready() -> void:
	set_process_input(false)
	top_1.get_node("Name").text = PersistenceData.top[0]["name"]
	top_1.get_node("Pts").text = "%05d" % PersistenceData.top[0]["pts"]
	top_2.get_node("Name").text = PersistenceData.top[1]["name"]
	top_2.get_node("Pts").text = "%05d" % PersistenceData.top[1]["pts"]
	top_3.get_node("Name").text = PersistenceData.top[2]["name"]
	top_3.get_node("Pts").text = "%05d" % PersistenceData.top[2]["pts"]
	top_4.get_node("Name").text = PersistenceData.top[3]["name"]
	top_4.get_node("Pts").text = "%05d" % PersistenceData.top[3]["pts"]
	top_5.get_node("Name").text = PersistenceData.top[4]["name"]
	top_5.get_node("Pts").text = "%05d" % PersistenceData.top[4]["pts"]

func _input(event: InputEvent) -> void:
	if event is InputEventKey or event.is_action_type():
		var err = get_tree().change_scene("res://game/screens/Level.tscn")
		if err != OK:
			print_debug("Error al ir a Level")

func _on_TimeSkip_timeout() -> void:
	set_process_input(true)
