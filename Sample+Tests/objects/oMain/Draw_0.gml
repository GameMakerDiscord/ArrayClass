/// @desc
if keyboard_check_pressed(vk_space)
	__Array_test()


rotatingAngle = function() {
	static ang = 0
	static ang_spd = 1
	
	if ang >= 45 {
		ang_spd = -1
	}
	else if ang <= -45 {
		ang_spd = 1
	}
	ang += ang_spd
	return ang
}

draw_set_color(c_yellow)
draw_set_halign(fa_center)
draw_set_valign(fa_middle)
var scale = 3
var angle = rotatingAngle()
draw_text_transformed(room_width/2, room_height/2, "Yo nothin here :/\n check out the console,\n ArrayClass.gml and Tests.gml", scale, scale, angle)