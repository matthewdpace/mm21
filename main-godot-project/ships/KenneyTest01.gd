extends Ship

var lights:bool = false


func lightsOff():
	$LightForward01.visible = false
	$LightForward02.visible = false
	$LightDownward01.visible = false
	$LightDownward02.visible = false
	$LightDownward03.visible = false
	$LightDownward04.visible = false

func lightsOn():
	$LightForward01.visible = true
	$LightForward02.visible = true
	$LightDownward01.visible = true
	$LightDownward02.visible = true
	$LightDownward03.visible = true
	$LightDownward04.visible = true
