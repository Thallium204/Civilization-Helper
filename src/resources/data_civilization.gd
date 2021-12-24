class_name civ_CivilizationData
tool
extends Resource

export(String) var civ_name = ""
export(Texture) var civ_image
export(String) var leader_name = ""
export(Texture) var leader_image
export(String) var ability_name = ""
export(String,MULTILINE) var ability_text = ""
export(Array,gl.FocusType) var focus_setup = [2,0,0,0,0,0]
export(Array,String) var city_names = ["","","","","","","",""]

func _to_string():
	return "[CivilizationData: "+civ_name+"]"
