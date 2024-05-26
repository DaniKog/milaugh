extends GridContainer


func SetPitch(value):
	%Current_P_Value.text = str(value)

func SetSpeed(value):
	%Current_S_Value.text = str(value)
	
func SetVolume(value):
	%Current_V_Value.text = str(value)
	
func GetPitch():
	return int(%Current_P_Value.text)

func GetSpeed():
	return int(%Current_S_Value.text)
	
func GetVolume():
	return int(%Current_V_Value.text)
