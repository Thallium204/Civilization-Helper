extends WindowDialog

signal selected(player_name,player_color_data,player_civ_data)

var player_name = ""
var player_color_id = 0
var player_civ_id = 0

export(NodePath) onready var NameField = get_node(NameField) as LineEdit
export(NodePath) onready var ColorOption = get_node(ColorOption) as OptionButton
export(NodePath) onready var CivOption = get_node(CivOption) as OptionButton

export(NodePath) onready var LabelCiv = get_node(LabelCiv) as Label
export(NodePath) onready var LabelLeader = get_node(LabelLeader) as Label
export(NodePath) onready var TextureCiv = get_node(TextureCiv) as TextureRect
export(NodePath) onready var TextureLeader = get_node(TextureLeader) as TextureRect

export(NodePath) onready var LabelAbilityName = get_node(LabelAbilityName) as Label
export(NodePath) onready var LabelAbilityText = get_node(LabelAbilityText) as Label

export(NodePath) onready var HBoxFocus = get_node(HBoxFocus) as HBoxContainer



func _init():
	randomize()

func update_options():
	
	player_name = ""
	NameField.text = ""
	
	ColorOption.clear()
	for color_id in game.COLOR_POOL.size():
		var color_data = game.COLOR_POOL[color_id]
		ColorOption.add_icon_item(color_data.image,color_data.name,color_id)
	ColorOption.add_item("Random",game.COLOR_POOL.size())
	ColorOption.select(game.COLOR_POOL.size())
	_on_Color_item_selected(game.COLOR_POOL.size())
	
	CivOption.clear()
	for civ_id in game.CIVILIZATION_POOL.size():
		var civ_data = game.CIVILIZATION_POOL[civ_id]
		CivOption.add_icon_item(civ_data.leader_image,civ_data.civ_name,civ_id)
	CivOption.add_item("Random",game.CIVILIZATION_POOL.size())
	CivOption.select(game.CIVILIZATION_POOL.size())
	_on_Civ_item_selected(game.CIVILIZATION_POOL.size())

func update_details():
	
	var player_civ_data
	if player_civ_id == game.CIVILIZATION_POOL.size():
		player_civ_data = null
	else:
		player_civ_data = game.CIVILIZATION_POOL[player_civ_id]
	
	if player_civ_data is civ_CivilizationData:
		LabelCiv.text = player_civ_data.civ_name
		TextureCiv.texture = player_civ_data.civ_image
		LabelLeader.text = player_civ_data.leader_name
		TextureLeader.texture = player_civ_data.leader_image
		LabelAbilityName.text = player_civ_data.ability_name
		LabelAbilityText.text = player_civ_data.ability_text
		var focus_texture_array = HBoxFocus.get_children()
		for id in range(6):
			focus_texture_array[id].texture = assets.get_focus_image(player_civ_data.focus_setup[id])
	else:
		LabelCiv.text = "Randomized"
		TextureCiv.texture = null
		LabelLeader.text = "Randomized"
		TextureLeader.texture = null
		LabelAbilityName.text = "???"
		LabelAbilityText.text = "???"
		var focus_texture_array = HBoxFocus.get_children()
		for id in range(6):
			focus_texture_array[id].texture = null

func _on_Confirm_pressed():
	
	hide()
	
	var player_color_data
	if player_color_id == game.COLOR_POOL.size():
		player_color_data = game.COLOR_POOL[randi()%game.COLOR_POOL.size()]
	else:
		player_color_data = game.COLOR_POOL[player_color_id]
	
	var player_civ_data
	if player_civ_id == game.CIVILIZATION_POOL.size():
		player_civ_data = game.CIVILIZATION_POOL[randi()%game.CIVILIZATION_POOL.size()]
	else:
		player_civ_data = game.CIVILIZATION_POOL[player_civ_id]
	
	if player_name.length() == 0:
		player_name = player_civ_data.leader_name
	
	emit_signal("selected",player_name,player_color_data,player_civ_data)


func _on_Field_text_changed(new_text):
	player_name = new_text

func _on_Color_item_selected(index):
	player_color_id = index

func _on_Civ_item_selected(index):
	player_civ_id = index
	update_details()

