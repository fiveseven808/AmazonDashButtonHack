#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Off
PingResults:="PingResults.txt"
PingYas:="bytes=32"
debug = no
EarlyExit = 0 
silence_switch = 0

WelcomeVar =
(
Daemon is now running in Standalone mode
View Readme.md to understand how to run from console

Button IP Goes here
)


/*
Changelog: 
v4.1b 
	+ Bug fix. Silence switch now silences when the button disappears. (untested)
v4.1a
	+ New version! 
	+ Added the ability to silence tooltip notifications
v4.0
	+ Adding in a gui from the discovery program so you can run the thing by just knowing the IP
	+ also gonna try and make the IP and program and comment show on systray mouseover. 
	- also gonna add in the pause feature. for home automation and resource saving 
	+ bug fixes
7/11/16
	- integrating tping to compensate for the newer amazon buttons and testing 
	- tping doesn't seem to work, i get some weird invalid parameter as the IP address... 
2016/6/16
	- at some point I found a way to use an onexit command this alllows the user to add a comment that is viewable upon closing
	- added button IP to the pingresult text file so this program can be run at the same time i nthe same directory
2016/6/9
	- reduced memory footprint
	- changed detection algorithm from 5 or so checks to 1 check per iteration. 
	- reduced cpu load
	- optimized off-checking. (so you can use the button again faster)
	- added tooltips for status on amazon button so you know what it's doing
	- no longer deletes pingresult.txt unless 
*/
OnExit, ExitSub

Main:
{
FileDelete,%PingResults%
if debug = yes
	goto presetstart
If 0 > 0
	{
	Computername = %1%
	Comment = %3%
	ptorun = %2%
	if 4 = "/s"
		silence_switch = 1
	else 
		silence_switch = 0
	Goto StartDaemon
	}
else
	{
	comp_ip = %A_IPAddress1% 
	StringGetPos, comp_temp, comp_ip, . , R1
	stringlen, add_length, A_IPAddress1
	comp_temp := comp_temp + 1
	cut_char := add_length - comp_temp
	StringTrimRight, comp_ip, comp_ip, cut_char
InputBox, Computername , Button Daemon Standalone Mode,%WelcomeVar%,,,,,,,,%comp_ip%
	if ErrorLevel
		{
		EarlyExit = 1
		exitapp
		}
	FileSelectfile, ptorun
	InputBox, Comment , Enter Comment of Button, Comment for Button Goes here
	if ErrorLevel
		{
		EarlyExit = 1
		exitapp
		}
	MsgBox, 4,, Would you like to a notification to be displayed everytime a button is pressed? (Silence Notifications)
	IfMsgBox Yes
		silence_switch = 0
	else
		silence_switch = 1
	Goto StartDaemon
	}
}
Return

presetstart:
	Computername = 192.168.1.229
	ptorun = msgbox.ahk
	PingResults:="PingResults" . Computername . ".txt"
	Comment = "debug comment"
Goto StartDaemon

StartDaemon:
	PingResults:="PingResults" . Computername . ".txt"
	menu, tray, tip,%A_ScriptName% `nFor button at:           %Computername%`nRunning program:   %ptorun%`nComment:                %Comment%
Checkcomp:
	gosub CheckCompison
	run %ptorun%
	If (silence_switch=0)
		{
		ToolTip, Button at %Computername%`nhas been pushed.
		SetTimer, RemoveToolTip, 2000
		}
	gosub CheckCompisbackoff
goto Checkcomp


CheckCompison:
Loop
{
;PingCmd:="tping -d 10 " . ComputerName . " >" . PingResults
PingCmd:="ping -w 1 -n 3 " . ComputerName . " >" . PingResults
;msgbox %PingCmd%
RunWait %comspec% /c """%PingCmd%""",,Hide
Loop
	{
	PingError:=false
	FileReadLine,PingLine,%PingResults%,%A_Index%
	If (ErrorLevel=1 )
	Break
	IfInString,PingLine,%PingYas%
		{
		PingError:=true
		break
		}
	}		
;runwait %PingResults%	
;FileDelete,%PingResults%
If PingError = 1
	{
	break
	}
}
return

CheckCompisbackoff:
	Loop
	{
	sleep 1000
	PingCmd:="ping " . ComputerName . " -n 1 >" . PingResults
	RunWait %comspec% /c """%PingCmd%""",,Hide
	Loop
		{
		PingError:=false
		FileReadLine,PingLine,%PingResults%,%A_Index%
		If (ErrorLevel=1 )
		Break
		IfInString,PingLine,%PingYas%
			{
			PingError:=true
			break
			}
		}
	;msgbox, broke out of loop
	;FileDelete,%PingResults%
	If PingError = 0
		{
		If (silence_switch=0)
			{
			;msgbox, button disappeared!
			ToolTip, Button at %Computername%`nhas disappeared.
			SetTimer, RemoveToolTip, 2000
			}
		break
		}
	}
Return

RemoveToolTip:
SetTimer, RemoveToolTip, Off
ToolTip
return

ExitSub:
if EarlyExit = 1 
	{
	FileDelete, %PingResults%
	ExitApp
	}
if A_ExitReason not in Logoff,Shutdown  ; Avoid spaces around the comma in this line.
{
    MsgBox, 4, , Are you sure you want to close the daemon monitoring button at `n%ComputerName%?`n`nSet to run program at:`n%ptorun%`n`nComment: %Comment%
    IfMsgBox, No
        return
}
sleep 3000
FileDelete, %PingResults%
;if ErrorLevel   ; i.e. it's not blank or zero.
;    MsgBox, ummm... error says %ErrorLevel%
ExitApp
