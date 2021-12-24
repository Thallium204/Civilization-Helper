class_name civ_ControlTokenData
tool
extends Resource


export(bool) var is_reinforced = false
export(String) var name = ""
export(Texture) var image
export(Resource) var player_data = player_data as civ_PlayerData setget set_player_data

func set_player_data(new_player_data):
	player_data = new_player_data
	image = player_data.image
	emit_changed()
