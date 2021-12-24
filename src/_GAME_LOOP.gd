extends Node

var PLAYER_COUNT = 0
var CURRENT_PLAYER_ID = 0
var PLAYER_LIST = []
var CURRENT_PLAYER : civ_PlayerData

var COLOR_POOL = []
var CIVILIZATION_POOL = []

var UI_NODE = null
var WORLD_NODE : civ_WORLD = null

func _unhandled_key_input(event):
	if event.scancode == KEY_F1 and event.pressed:
		START_GAME()

func START_GAME():
	
	# Build Pools
	BUILD_POOLS()
	
	# Pre-init (6. Set Direction Token and Event Dial | 11. Create Supply)
	PRE_INIT()
	
	# Get player count
	UI_NODE.PopupPlayerCount.popup_centered()
	PLAYER_COUNT = yield(UI_NODE,"player_count_selected")
	
	PLAYER_LIST = GENERATE_PLAYER_LIST(PLAYER_COUNT)
	
	# 1. Select Leader and Player Color
	for player_res in PLAYER_LIST:
		if player_res is civ_PlayerData:
			UI_NODE.PopupPlayerDetails.popup_centered()
			UI_NODE.PopupPlayerDetails.update_options()
			var details_array = yield(UI_NODE.PopupPlayerDetails,"selected")
			player_res.name = details_array[0]
			player_res.color_data = details_array[1]
			COLOR_POOL.erase(details_array[1])
			player_res.civilization_data = details_array[2]
			CIVILIZATION_POOL.erase(details_array[2])
			print(player_res)
	
	# 2. Construct Focus Bars
	CONSTRUCT_FOCUS_BARS()
	
	# 3. Construct Map | 4. Populate Map | 5. Place City-State Cards
	CONSTRUCT_MAP()
	
	# 7. Separate Wonder Cards | 8. Create Wonder Decks | 9. Organise Wonder Tokens
	GENERATE_WONDER_DECKS()
	
	# 10. Deal Victory Cards
	GENERATE_VICTORY_CARDS()




func BUILD_POOLS():
	COLOR_POOL = res.COLORS.duplicate(true)
	CIVILIZATION_POOL = res.CIVILIZATIONS.duplicate(true)

func PRE_INIT():
	pass

# Queries the user for the player count
func QUERY_PLAYER_COUNT() -> int:
	UI_NODE.PopupPlayerCount.popup_centered()
	var player_count = yield(UI_NODE,"player_count_selected")
	return player_count

func GENERATE_PLAYER_LIST(player_count : int):
	var temp_PLAYER_LIST = []
	for id in player_count:
		var new_player_res = civ_PlayerData.new()
		new_player_res.id = id
		temp_PLAYER_LIST.append(new_player_res)
	return temp_PLAYER_LIST

func CONSTRUCT_FOCUS_BARS():
	for player_res in PLAYER_LIST:
		if player_res is civ_PlayerData:
			player_res.construct_focus_bar()

func CONSTRUCT_MAP():
	WORLD_NODE.auto_spawn_and_place_tile()
	WORLD_NODE.auto_spawn_and_place_tile()
	if PLAYER_LIST.size() > 3:
		WORLD_NODE.auto_spawn_and_place_tile()
		WORLD_NODE.auto_spawn_and_place_tile()

func GENERATE_WONDER_DECKS():
	pass

func GENERATE_VICTORY_CARDS():
	pass

