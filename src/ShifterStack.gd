tool
extends HBoxContainer

onready var gov = $Gov
onready var georgia = $Georgia
onready var taj = $Taj
onready var machu = $Machu

func update_stack(has_government,focus_type,player_id):
	gov.active = has_government
	if gov.active:
		gov.active = true
		gov.set_texture(assets.get_government_image_by_focus_type(focus_type))
		gov.set_arrows(2)
