extends Control




func _on_ButtonSimulator_pressed():
	get_tree().change_scene("res://src/WonderSimulator.tscn")


func _on_ButtonInspector_pressed():
	get_tree().change_scene("res://src/WonderInspector.tscn")
