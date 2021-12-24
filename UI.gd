class_name civ_UI
extends Control

signal player_count_selected(player_count)

onready var PopupPlayerCount : Popup = $PopupPlayerCount
onready var PopupPlayerDetails : Popup = $PopupPlayerDetails

func _init():
	game.UI_NODE = self


func _on_PlayerCount_pressed(player_count):
	PopupPlayerCount.hide()
	emit_signal("player_count_selected",player_count)
