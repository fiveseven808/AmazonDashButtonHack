amazon_button_server_file := "c:\somefilehere.ahk"
Chosen_IP := "1.1.1.1"
DaemonFile := "text.txt"
Button_Comment := "comment lol"

DaemonCmd:= amazon_button_server_file . " " . Chosen_IP . " " . DaemonFile . " """ . Button_Comment . """ /s"
msgbox, %DaemonCmd%