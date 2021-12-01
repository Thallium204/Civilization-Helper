extends Control

const Leader_load = preload("res://src/Leader.tscn")

var leader_array = []

func _ready():
	randomize()
	generate_leaders()


func generate_leaders():
	clear_UI()
	leader_array = []
	for leader_name in data.LEADER.keys():
		var Leader = Leader_load.instance()
		Leader.get_node("ImagePortrait").texture = assets.get_leader_portrait(leader_name)
		Leader.get_node("ImageFlag").texture = assets.get_leader_flag(leader_name)
		$VBoxStack.add_child(Leader)
		leader_array.append(Leader)

func clear_UI():
	$ButtonGet.disabled = false
	for child in $VBoxStack.get_children():
		child.free()
	for child in $VBoxUsed.get_children():
		child.free()

func make_used(Leader):
	$VBoxStack.remove_child(Leader)
	$VBoxUsed.add_child(Leader)

func _on_ButtonGet_pressed():
	leader_array.shuffle()
	make_used(leader_array.pop_front())
	$ButtonGet.disabled = leader_array.empty()

func _on_ButtonReset_pressed():
	generate_leaders()
