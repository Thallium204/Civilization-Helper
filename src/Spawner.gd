extends GridContainer

enum ST{
	SPAWN_TYPE_WONDER,
	SPAWN_TYPE_FOCUS_CARD,
}

export(ST) var spawn_type = ST.SPAWN_TYPE_WONDER

func _ready():
	match spawn_type:
		ST.SPAWN_TYPE_WONDER:
			spawn_wonders()
		ST.SPAWN_TYPE_FOCUS_CARD:
			spawn_focus_cards()

func spawn_wonders():
	for wonder_id in gl.WORLD_WONDER_IDS_SORTED:
		var WonderCard = res.get_wonder_card(wonder_id)
		add_child(WonderCard)

func spawn_focus_cards():
	for focus_card_name in data.FOCUS.keys():
		var FocusCard = res.get_focus_card(focus_card_name)
		add_child(FocusCard)
