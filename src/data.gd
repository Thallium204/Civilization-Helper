tool
extends Node


const TILES = {
	
	"1a" : {
		
	}
	
}


const LEADER = {
	
	"Amanitore" : {
		"image_name":"Amanitore",
		"civilization":"Nubia",
		"focus_card":"",
		"focus_row":[],},
	"Catherine de Medici" : {
		"image_name":"Catherine_de_Medici",
		"civilization":"France",
		"focus_card":"",
		"focus_row":[],},
	"Cleopatra" : {
		"image_name":"Cleopatra",
		"civilization":"Egypt",
		"focus_card":"",
		"focus_row":[],},
	"Gilgamesh" : {
		"image_name":"Gilgamesh",
		"civilization":"Sumeria",
		"focus_card":"",
		"focus_row":[],},
	"Gitarja" : {
		"image_name":"Gitarja",
		"civilization":"Indonesia",
		"focus_card":"",
		"focus_row":[],},
	"Hojo Tokimune" : {
		"image_name":"Hojo_Tokimune",
		"civilization":"Japan",
		"focus_card":"",
		"focus_row":[],},
	"Jadwiga" : {
		"image_name":"Jadwiga",
		"civilization":"Poland",
		"focus_card":"",
		"focus_row":[],},
	"Montezuma" : {
		"image_name":"Montezuma",
		"civilization":"Aztec",
		"focus_card":"",
		"focus_row":[],},
	"Pachacuti" : {
		"image_name":"Pachacuti",
		"civilization":"Inca",
		"focus_card":"",
		"focus_row":[],},
	"Qin Shi Huang" : {
		"image_name":"Qin_Shi_Huang",
		"civilization":"China",
		"focus_card":"",
		"focus_row":[],},
	"Shaka" : {
		"image_name":"Shaka",
		"civilization":"Zulu",
		"focus_card":"",
		"focus_row":[],},
	"Suleiman" : {
		"image_name":"Suleiman",
		"civilization":"Ottoman",
		"focus_card":"",
		"focus_row":[],},
	"Tamar" : {
		"image_name":"Tamar",
		"civilization":"Georgia",
		"focus_card":"",
		"focus_row":[],},
	"Teddy Roosevelt" : {
		"image_name":"Teddy_Roosevelt",
		"civilization":"America",
		"focus_card":"",
		"focus_row":[],},
	"Tomyris" : {
		"image_name":"Tomyris",
		"civilization":"Scythia",
		"focus_card":"",
		"focus_row":[],},
	"Trajan" : {
		"image_name":"Trajan",
		"civilization":"Rome",
		"focus_card":"",
		"focus_row":[],},
	"Victoria" : {
		"image_name":"Victoria",
		"civilization":"England",
		"focus_card":"",
		"focus_row":[],},
	"Wilhelmina" : {
		"image_name":"Wilhelmina",
		"civilization":"Netherlands",
		"focus_card":"",
		"focus_row":[],},
}

const FOCUS = {
	
	"Early Empire" : {
		"image_name":"Early_Empire",
		"tech_level":1,
		"focus_type":gl.FocusType.CULTURE,
		"description":"Place 2 control tokens on spaces matching this slot's terrain or lower that are adjacent to friendly cities."},
	"Drama and Poetry" : {
		"image_name":"Drama_and_Poetry",
		"tech_level":2,
		"focus_type":gl.FocusType.CULTURE,
		"description":"Place 2 control tokens on spaces matching this slot's terrain or lower that are adjacent to friendly cities.\n\nThen, you may move 1 of your control tokens to an adjacent, non-water space that is empty (does not contain a token or plastic figure)."},
	"Civil Service" : {
		"image_name":"Civil_Service",
		"tech_level":3,
		"focus_type":gl.FocusType.CULTURE,
		"description":"Place 2 control tokens on spaces matching this slot's terrain or lower that are adjacent to friendly cities.\n\nThen, place 1 control token on a space matching this slot's terrain or lower that is adjacent to a friendly space."},
	"Mass Media" : {
		"image_name":"Mass_Media",
		"tech_level":4,
		"focus_type":gl.FocusType.CULTURE,
		"description":"Place 3 control tokens on spaces matching this slot's terrain or lower that are adjacent to friendly cities.\n\nThen, choose a rival control token within 2 spaces of a friendly space. If the rival token is unreinforced, replace it with 1 of your control tokens on the unreinforced side. If the rival token is reinforced, flip it to it's unreinforced side."},
	
	"Foreign Trade" : {
		"image_name":"Foreign_Trade",
		"tech_level":1,
		"focus_type":gl.FocusType.ECONOMY,
		"description":"Move each of your caravans up to 3 spaces. They can move into spaces matching this slot's terrain or lower."},
	"Currency" : {
		"image_name":"Currency",
		"tech_level":2,
		"focus_type":gl.FocusType.ECONOMY,
		"description":"Move each of your caravans up to 4 spaces. They can move into spaces matching this slot's terrain or lower.\n\nYour caravans can move into a barbarian's space. If you move a caravan into a barbarian's space, remove that barbarian from the map without gaining a trade token and end that caravan's movement."},
	"Steam Power" : {
		"image_name":"Steam_Power",
		"tech_level":3,
		"focus_type":gl.FocusType.ECONOMY,
		"description":"Move each of your caravans up to 6 spaces. They can move into spaces matching this slot's terrain or lower, as well as water.\n\nThen, you may exchange 1 of your resource tokens with another resource token of any type from the supply."},
	"Capitalism" : {
		"image_name":"Capitalism",
		"tech_level":4,
		"focus_type":gl.FocusType.ECONOMY,
		"description":"Move each of your caravans up to 6 spaces. They can move into spaces matching this slot's terrain or lower, as well as water.\n\nOnce per turn, after you reset this card, choose another card in your focus row. Resolve that card as though it is in the first slot, but do not reset it."},
	
	"Irrigation" : {
		"image_name":"Irrigation",
		"tech_level":1,
		"focus_type":gl.FocusType.GROWTH,
		"description":"Place a district on a space matching this slot's terrain or lower that is adjacent to a friendly city.\n\nOr, reinforce a number of control tokens equal to this slot's number."},
	"Engineering" : {
		"image_name":"Engineering",
		"tech_level":2,
		"focus_type":gl.FocusType.GROWTH,
		"description":"Place a district on a space matching this slot's terrain or lower that is adjacent to a friendly city. Then place 1 control token on a space matching this slot's terrain or lower that is adjacent to a friendly district.\n\nOr, reinforce a number of control tokens equal to this slot's number."},
	"Sanitation" : {
		"image_name":"Sanitation",
		"tech_level":3,
		"focus_type":gl.FocusType.GROWTH,
		"description":"Place a district on a space matching this slot's terrain or lower that is adjacent to a friendly city.\n\nThen, reinforce a number of control tokens equal to this slot's number."},
	"Globalization" : {
		"image_name":"Globalization",
		"tech_level":4,
		"focus_type":gl.FocusType.GROWTH,
		"description":"Place a district on a space matching this slot's terrain or lower that is adjacent to a friendly city.\n\nThen, choose a type of district. Each player that has a district of that type on the map resolves its effect.\n\nThen, reinforce a number of control tokens equal to this slot's number."},
	
	"Pottery" : {
		"image_name":"Pottery",
		"tech_level":1,
		"focus_type":gl.FocusType.INDUSTRY,
		"description":"Build 1 world wonder. Your production equals this slot's number.\n\nOr, build 1 city on a legal space of this slot's terrain or lower with 2 spaces of a friendly space."},
	"Animal Husbandry" : {
		"image_name":"Animal_Husbandry",
		"tech_level":2,
		"focus_type":gl.FocusType.INDUSTRY,
		"description":"Build 1 world wonder. Your production equals this slot's number.\n\nOr, build 1 city on a legal space of this slot's terrain or lower with 3 spaces of a friendly space.\n\nOr, build 1 city on a legal space containing a friendly caravan or army. Then, return that caravan or army to your focus card."},
	"Nationalism" : {
		"image_name":"Nationalism",
		"tech_level":3,
		"focus_type":gl.FocusType.INDUSTRY,
		"description":"Build 1 world wonder. Your production equals this slot's number, or, if this card is in the fifth slot, your production equals 7.\n\nOr, build 1 city on a legal space of this slot's terrain or lower with 4 spaces of a friendly space. You can count through water."},
	"Urbanization" : {
		"image_name":"Urbanization",
		"tech_level":4,
		"focus_type":gl.FocusType.INDUSTRY,
		"description":"Build 1 world wonder. Your production equals this slot's number.\n\nOr, build 1 city on a legal space of this slot's terrain or lower with 5 spaces of a friendly space. You can count through water.\n\nThen, if you built a city, place up to 2 control tokens adjacent to that city. Those tokens can be placed on spaces matching this slot's terrain or lower."},
	
	"Masonry" : {
		"image_name":"Masonry",
		"tech_level":1,
		"focus_type":gl.FocusType.MILITARY,
		"description":"Move each of your armies up to 3 spaces. They can move into spaces matching this slot's terrain or lower. Your combat value equals this slot's number."},
	"Iron Working" : {
		"image_name":"Iron_Working",
		"tech_level":2,
		"focus_type":gl.FocusType.MILITARY,
		"description":"Move each of your armies up to 4 spaces. They can move into spaces matching this slot's terrain or lower. Your combat value equals this slot's number, plus 2 if attacking a barbarian."},
	"Mass Production" : {
		"image_name":"Mass_Production",
		"tech_level":3,
		"focus_type":gl.FocusType.MILITARY,
		"description":"Move each of your armies up to 5 spaces. They can move into spaces matching this slot's terrain or lower, as well as water. Your combat value equals this slot's number plus 2.\n\nYou may move (and attack with) 1 of your armies that was defeated this turn a second time after returning it to this card."},
	"Flight" : {
		"image_name":"Flight",
		"tech_level":4,
		"focus_type":gl.FocusType.MILITARY,
		"description":"Move each of your armies up to 6 spaces. They can move into spaces matching this slot's terrain or lower, as well as water. They can move through spaces with unreinforced control tokens, caravans, barbarians, and city-states. Your combat value equals this slot's number plus 3."},
	
	"Astrology" : {
		"image_name":"Astrology",
		"tech_level":1,
		"focus_type":gl.FocusType.SCIENCE,
		"description":"Advance your tech dial a number of spaces equal to this slot's number."},
	"Mathematics" : {
		"image_name":"Mathematics",
		"tech_level":2,
		"focus_type":gl.FocusType.SCIENCE,
		"description":"Place 1 trade token from the supply on 1 of your focus cards.\n\nThen, advance your tech dial a number of spaces equal to this slot's number."},
	"Replaceable Parts" : {
		"image_name":"Replaceable_Parts",
		"tech_level":3,
		"focus_type":gl.FocusType.SCIENCE,
		"description":"Gain 1 resource of your choice from the supply. You cannot gain a resource of a type taht you already have.\n\nThen, advance your tech dial a number of spaces equal to this slot's number."},
	"Nuclear Power" : {
		"image_name":"Nuclear_Power",
		"tech_level":4,
		"focus_type":gl.FocusType.SCIENCE,
		"description":"If you resolved this card in the fifth slot, choose 1 space. In that space and all adjacent spaces, destroy all unreinforced control tokens and flip all reinforced control tokens to their unreinforced side.\n\nThen, advance your tech dial a number of spaces equal to this slot's number."},
}

const WONDER = {
	
	"Hanging Gardens" : {
		"image_name":"Hanging_Gardens",
		"era_type":gl.EraType.ANCIENT,
		"focus_type":gl.FocusType.CULTURE,
		"description":"At the start of your turn, you may place 1 control token on a space of terrain difficulty 4 or less that is adjacent to a friendly city.",
		"cost":8,
		"additional_resource":gl.RESOURCE_DIAMOND},
	"Colosseum" : {
		"image_name":"Colosseum",
		"era_type":gl.EraType.ANCIENT,
		"focus_type":gl.FocusType.CULTURE,
		"description":"At the start of your turn, you may reinforce 1 of your control tokens that is adjacent to a friendly city.",
		"cost":9,
		"additional_resource":gl.RESOURCE_OIL},
	"Stonehenge" : {
		"image_name":"Stonehenge",
		"era_type":gl.EraType.ANCIENT,
		"focus_type":gl.FocusType.CULTURE,
		"description":"After you place a control token on a hill space, you may place a control token on 1 or more hill spaces (which can trigger this effect again).",
		"cost":7,
		"additional_resource":gl.RESOURCE_MERCURY},
	"Taj Mahal" : {
		"image_name":"Taj_Mahal",
		"era_type":gl.EraType.MEDIEVAL,
		"focus_type":gl.FocusType.CULTURE,
		"description":"When you resolve a focus card, resolve it as though it is 1 slot farther to the right for each world wonder you control matching the focus card's type.",
		"cost":9,
		"additional_resource":gl.RESOURCE_DIAMOND},
	"Forbidden City" : {
		"image_name":"Forbidden_City",
		"era_type":gl.EraType.MEDIEVAL,
		"focus_type":gl.FocusType.CULTURE,
		"description":"At the start of your turn, you may destroy 1 rival control token that is adjacent to a friendly space.",
		"cost":9,
		"additional_resource":gl.RESOURCE_OIL},
	"Chichen Itza" : {
		"image_name":"Chichen_Itza",
		"era_type":gl.EraType.MEDIEVAL,
		"focus_type":gl.FocusType.CULTURE,
		"description":"When placing control tokens, you can place them on empty forest spaces that are not adjacent to a friendly city.",
		"cost":10,
		"additional_resource":gl.RESOURCE_MERCURY},
	"Sydney Opera House" : {
		"image_name":"Sydney_Opera_House",
		"era_type":gl.EraType.MODERN,
		"focus_type":gl.FocusType.CULTURE,
		"description":"Rival control tokens contribute toward your cities' maturity.",
		"cost":10,
		"additional_resource":gl.RESOURCE_DIAMOND},
	"Eiffel Tower" : {
		"image_name":"Eiffel_Tower",
		"era_type":gl.EraType.MODERN,
		"focus_type":gl.FocusType.CULTURE,
		"description":"At the start of your turn, you may choose 2 rival control tokens on the map belonging to the same player. That player replaces 1 of those tokens with 1 of your unused unreinforced control tokens.",
		"cost":12,
		"additional_resource":gl.RESOURCE_OIL},
	"Cristo Redentor" : {
		"image_name":"Cristo_Redentor",
		"era_type":gl.EraType.MODERN,
		"focus_type":gl.FocusType.CULTURE,
		"description":"When you build or capture this wonder, choose a rival non-capital city (without an army in its space) within 3 spaces of this wonder. Replace that city with 1 of your unused cities.",
		"cost":11,
		"additional_resource":gl.RESOURCE_MERCURY},
	
	"Apadana" : {
		"image_name":"Apadana",
		"era_type":gl.EraType.ANCIENT,
		"focus_type":gl.FocusType.ECONOMY,
		"description":"When you build or capture this wonder, choose an edge space on any tile. Explore from that space.\n\nThen if you placed a tile, place 1 control token on an empty space on that tile.",
		"cost":8,
		"additional_resource":gl.RESOURCE_MARBLE},
	"Colossus" : {
		"image_name":"Colossus",
		"era_type":gl.EraType.ANCIENT,
		"focus_type":gl.FocusType.ECONOMY,
		"description":"When resolving your economy focus card, your caravans can move a total of 6 additional spaces, divided as you choose.",
		"cost":7,
		"additional_resource":gl.RESOURCE_OIL},
	"Great Lighthouse" : {
		"image_name":"Great_Lighthouse",
		"era_type":gl.EraType.ANCIENT,
		"focus_type":gl.FocusType.ECONOMY,
		"description":"When building cities, you can build in empty spaces on the edge of the map as if they were within 2 spaces of a friendly space.",
		"cost":8,
		"additional_resource":gl.RESOURCE_MERCURY},
	"Kilwa Kisiwani" : {
		"image_name":"Kilwa_Kisiwani",
		"era_type":gl.EraType.MEDIEVAL,
		"focus_type":gl.FocusType.ECONOMY,
		"description":"When you move a caravan to a city-state, place 1 additional trade token from the supply on any 1 of your focus cards.",
		"cost":9,
		"additional_resource":gl.RESOURCE_MARBLE},
	"Great Zimbabwe" : {
		"image_name":"Great_Zimbabwe",
		"era_type":gl.EraType.MEDIEVAL,
		"focus_type":gl.FocusType.ECONOMY,
		"description":"You can place trade tokens on this card instead of on your focus cards, up to a limit of 4.\n\nAt the start of your turn, you may move trade tokens from this card to cards in your focus row.",
		"cost":9,
		"additional_resource":gl.RESOURCE_OIL},
	"Machu Picchu" : {
		"image_name":"Machu_Picchu",
		"era_type":gl.EraType.MEDIEVAL,
		"focus_type":gl.FocusType.ECONOMY,
		"description":"When you resolve the card in the first or second slot of your focus row, resolve it as though it is 2 slots farther to the right.",
		"cost":10,
		"additional_resource":gl.RESOURCE_MERCURY},
	"Estadio do Maracana" : {
		"image_name":"Estadio_do_Maracana",
		"era_type":gl.EraType.MODERN,
		"focus_type":gl.FocusType.ECONOMY,
		"description":"After you resolve a focus card other than your economy card, you may resolve and reset your economy card.",
		"cost":10,
		"additional_resource":gl.RESOURCE_MARBLE},
	"Orszaghaz" : {
		"image_name":"Orszaghaz",
		"era_type":gl.EraType.MODERN,
		"focus_type":gl.FocusType.ECONOMY,
		"description":"After you move a caravan to a city-state, you may conquer it.",
		"cost":11,
		"additional_resource":gl.RESOURCE_OIL},
	"Big Ben" : {
		"image_name":"Big_Ben",
		"era_type":gl.EraType.MODERN,
		"focus_type":gl.FocusType.ECONOMY,
		"description":"When attacking or defending, increase your combat value by 2 for each caravan adjacent to the defending space.",
		"cost":10,
		"additional_resource":gl.RESOURCE_MERCURY},
	
	"Terracota Army" : {
		"image_name":"Terracotta_Army",
		"era_type":gl.EraType.ANCIENT,
		"focus_type":gl.FocusType.MILITARY,
		"description":"When attacking, increase your combat value by 2.",
		"cost":8,
		"additional_resource":gl.RESOURCE_MARBLE},
	"Petra" : {
		"image_name":"Petra",
		"era_type":gl.EraType.ANCIENT,
		"focus_type":gl.FocusType.MILITARY,
		"description":"When defending, increase your combat value by 2.\n\nBarbarians cannot move into spaces containing your cities or reinforced control tokens.",
		"cost":7,
		"additional_resource":gl.RESOURCE_DIAMOND},
	"Jebel Barkal" : {
		"image_name":"Jebel_Barkal",
		"era_type":gl.EraType.ANCIENT,
		"focus_type":gl.FocusType.MILITARY,
		"description":"When attacking or defending, you can spend resource tokens (not natural wonder tokens) to increase your combat value by 2 for each resource spent.",
		"cost":7,
		"additional_resource":gl.RESOURCE_MERCURY},
	"Alhambra" : {
		"image_name":"Alhambra",
		"era_type":gl.EraType.MEDIEVAL,
		"focus_type":gl.FocusType.MILITARY,
		"description":"When attacking or defending, increase yout combat value by 2.",
		"cost":10,
		"additional_resource":gl.RESOURCE_MARBLE},
	"Venetian Arsenal" : {
		"image_name":"Venetian_Arsenal",
		"era_type":gl.EraType.MEDIEVAL,
		"focus_type":gl.FocusType.MILITARY,
		"description":"Once per turn, after you resolve the card in the fifth slot of your focus row, you may resolve it again, treating it as if it was in the first slot.",
		"cost":10,
		"additional_resource":gl.RESOURCE_DIAMOND},
	"Huey Teocalli" : {
		"image_name":"Huey_Teocalli",
		"era_type":gl.EraType.MEDIEVAL,
		"focus_type":gl.FocusType.MILITARY,
		"description":"When defending, increase your combat value by 1 for each water space that is adjacent to the defending space.",
		"cost":9,
		"additional_resource":gl.RESOURCE_MERCURY},
	"Statue of Liberty" : {
		"image_name":"Statue_of_Liberty",
		"era_type":gl.EraType.MODERN,
		"focus_type":gl.FocusType.MILITARY,
		"description":"Before you replace a rival city with 1 of your cities, replace all rival control tokens that are adjacent to that rival city with your unused, unreinforced control tokens.",
		"cost":12,
		"additional_resource":gl.RESOURCE_MARBLE},
	"Pentagon" : {
		"image_name":"Pentagon",
		"era_type":gl.EraType.MODERN,
		"focus_type":gl.FocusType.MILITARY,
		"description":"When attacking, increase your combat value by 2.\n\nYour armies can move any number of spaces. (They must still obey all other movement rules.)",
		"cost":12,
		"additional_resource":gl.RESOURCE_DIAMOND},
	"Ruhr Valley" : {
		"image_name":"Ruhr_Valley",
		"era_type":gl.EraType.MODERN,
		"focus_type":gl.FocusType.MILITARY,
		"description":"When defending, increase your combat value by 5.",
		"cost":11,
		"additional_resource":gl.RESOURCE_MERCURY},
	
	"Oracle" : {
		"image_name":"Oracle",
		"era_type":gl.EraType.ANCIENT,
		"focus_type":gl.FocusType.SCIENCE,
		"description":"At the start of your turn, you may swap 2 adjacent cards in your focus row.",
		"cost":8,
		"additional_resource":gl.RESOURCE_MARBLE},
	"Great Library" : {
		"image_name":"Great_Library",
		"era_type":gl.EraType.ANCIENT,
		"focus_type":gl.FocusType.SCIENCE,
		"description":"When your caravan moves to another player's city, you may gain a focus card of the same type and tech level as a card in that player's focus row, replacing your card of the same type.",
		"cost":8,
		"additional_resource":gl.RESOURCE_DIAMOND},
	"Pyramids" : {
		"image_name":"Pyramids",
		"era_type":gl.EraType.ANCIENT,
		"focus_type":gl.FocusType.SCIENCE,
		"description":"When you build this wonder, choose up to 3 level-I cards in your focus row. Replace each with a level-II card of the same type.",
		"cost":9,
		"additional_resource":gl.RESOURCE_OIL},
	"Potala Palace" : {
		"image_name":"Potala_Palace",
		"era_type":gl.EraType.MEDIEVAL,
		"focus_type":gl.FocusType.SCIENCE,
		"description":"You can have 4 diplomacy cards from each other player.\n\nWhen you build this wonder, you may take a total of 3 diplomacy cards of your choice from other players.",
		"cost":10,
		"additional_resource":gl.RESOURCE_MARBLE},
	"Porcelain Tower" : {
		"image_name":"Porcelain_Tower",
		"era_type":gl.EraType.MEDIEVAL,
		"focus_type":gl.FocusType.SCIENCE,
		"description":"When you build this wonder, replace up to 2 cards in your focus row with cards of the next highest level of the same type.",
		"cost":9,
		"additional_resource":gl.RESOURCE_DIAMOND},
	"University of Sankore" : {
		"image_name":"University_of_Sankore",
		"era_type":gl.EraType.MEDIEVAL,
		"focus_type":gl.FocusType.SCIENCE,
		"description":"At the end of your turn, if you replaced 1 or more of your focus cards this turn, you may swap any 2 non-science cards in your focus row.",
		"cost":9,
		"additional_resource":gl.RESOURCE_OIL},
	"Oxford University" : {
		"image_name":"Oxford_University",
		"era_type":gl.EraType.MODERN,
		"focus_type":gl.FocusType.SCIENCE,
		"description":"When you replace a focus card other than a science focus card, you do not have to replace it with a card of the same type.",
		"cost":10,
		"additional_resource":gl.RESOURCE_MARBLE},
	"Amundsen-Scott Research Station" : {
		"image_name":"Amundsen-Scott_Research_Station",
		"era_type":gl.EraType.MODERN,
		"focus_type":gl.FocusType.SCIENCE,
		"description":"When you build this wonder, build a city on any legal space of the edge of the map and place this wonder in that city. Then place up to 2 control tokens in spaces adjacent to that city.",
		"cost":10,
		"additional_resource":gl.RESOURCE_DIAMOND},
	"Kremlin" : {
		"image_name":"Kremlin",
		"era_type":gl.EraType.MODERN,
		"focus_type":gl.FocusType.SCIENCE,
		"description":"When attacking a rival space, increase your combat value by 4 if you have more reinforced control tokens on the map than the defending player.",
		"cost":11,
		"additional_resource":gl.RESOURCE_OIL},
	
}
