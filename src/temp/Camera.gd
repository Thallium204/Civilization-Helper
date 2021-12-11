extends Camera

var rotate_mode = false

func _unhandled_input(event):
	
	if event is InputEventMouseButton:
		
		if event.button_index == BUTTON_RIGHT:
			
			rotate_mode = event.pressed
			
		elif event.button_index == BUTTON_WHEEL_UP:
			
			translation *= 1.0/1.1
			
		elif event.button_index == BUTTON_WHEEL_DOWN:
			
			translation *= 1.1/1.0
	
	elif event is InputEventMouseMotion:
		
		if rotate_mode:
			
			get_parent().rotation_degrees.y -= event.relative.x
			get_parent().rotation_degrees.x -= event.relative.y
