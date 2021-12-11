class_name civ_WorldWonderData
extends Resource

export(String) var name = ""
export(gl.EraType) var era_type
export(Texture) var image
export(gl.FocusType) var focus_type
export(String, MULTILINE) var ability_text
export(int,7,12) var cost_base = 7
export(Resource) var primary_resource_data = primary_resource_data as civ_ResourceData
export(Resource) var secondary_resource_data = secondary_resource_data as civ_ResourceData

func _to_string():
	return "["+name+"]"
