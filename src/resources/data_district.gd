class_name civ_DistrictData
tool
extends Resource


export(String) var name = ""
export(gl.EraType) var era_type setget set_era_type
export(Texture) var image
export(Resource) var player_data = player_data as civ_PlayerData
export(Array,Texture) var era_images = [null,null,null]

func set_era_type(new_era_type):
	era_type = new_era_type
	if era_images[era_type]:
		image = era_images[era_type]
	emit_changed()
