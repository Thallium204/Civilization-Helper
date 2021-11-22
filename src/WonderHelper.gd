extends Control

var current_era_type = gl.ERA_ANCIENT
onready var era_label = $EraPanel/Label

onready var stack_data = {
	gl.FOCUS_CULTURE : {
		"stack":[],
		"discount":0,
		"slot":$HBoxCards/Culture,
		"card":null
	},
	gl.FOCUS_ECONOMY : {
		"stack":[],
		"discount":0,
		"slot":$HBoxCards/Economy,
		"card":null
	},
	gl.FOCUS_MILITARY : {
		"stack":[],
		"discount":0,
		"slot":$HBoxCards/Military,
		"card":null
	},
	gl.FOCUS_SCIENCE : {
		"stack":[],
		"discount":0,
		"slot":$HBoxCards/Science,
		"card":null
	},
}

func _ready():
	randomize()
	prepare_stacks()
	start_stacks()


func prepare_stacks():
	var wonder_context = gl.WONDER_CONTEXT.duplicate(true)
	for focus_type in stack_data.keys():
		var dat = stack_data[focus_type]
		dat.stack = create_stack(focus_type,wonder_context)

func create_stack(focus_type,context):
	var temp_stack:Array = []
	var main_stack = []
	
	temp_stack = context[focus_type][gl.ERA_ANCIENT]
	temp_stack.shuffle()
	temp_stack.pop_front()
	main_stack += temp_stack
	
	temp_stack = context[focus_type][gl.ERA_MEDIEVAL]
	temp_stack.shuffle()
	temp_stack.pop_front()
	main_stack += temp_stack
	
	temp_stack = context[focus_type][gl.ERA_MODERN]
	temp_stack.shuffle()
	main_stack += temp_stack
	
	return main_stack

func start_stacks():
	for focus_type in stack_data.keys():
		var dat = stack_data[focus_type]
		dat.card = gl.get_wonder_card(dat.stack.pop_front())
		dat.slot.add_child(dat.card)

func progress_stack(focus_type):
	var dat = stack_data[focus_type]
	if not dat.card:
		return
	if dat.discount == -1:
		dat.card.free()
		dat.card = null
		var wonder_name = dat.stack.pop_front()
		if wonder_name:
			dat.card = gl.get_wonder_card(wonder_name)
			dat.slot.add_child(dat.card)
			update_era_type(dat.card.era_type)
			dat.discount = 0
	else:
		dat.discount = -1
		dat.card.cost_mod = -1

func build_wonder(focus_type):
	var dat = stack_data[focus_type]
	dat.discount = -1
	progress_stack(focus_type)


func update_era_type(era_type):
	current_era_type = max(era_type,current_era_type)
	update_era_type_UI()

func update_era_type_UI():
	if era_label:
		era_label.text = gl.ERA_NAMES_LIST[current_era_type]

func _on_Progress_pressed():
	
	for focus_type in stack_data.keys():
		progress_stack(focus_type)


func _on_build_pressed(focus_type):
	build_wonder(focus_type)
