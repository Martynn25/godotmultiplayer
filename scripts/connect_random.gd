extends Node2D
@onready var label: Label = $Label
@onready var label_2: Label = $Label2
@onready var button_2: Button = $Button2

var get_id = OS.get_unique_id()
func _on_join_pressed() -> void:
	MultiManager.joined_some1()
	playerid(get_id)
func playerid(id: String):
	label.text = "player %s joined the game " % id
func _on_host_pressed() -> void:
	MultiManager.become_host()
	playerid(get_id)

func _on_button_2_pressed() -> void:
	print(multiplayer.get_peers())
	button_2.text = str(multiplayer.get_peers())
