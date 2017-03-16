#SingleInstance Off
PingResults:="PingResults.txt"
PingYas:="bytes=32"

/*
Changelog: 
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
If 0 > 0
	{
	Computername = %1%
	Comment = %3%
	Goto Checkcomp
	}
else
	{
	Msgbox, Must be run in command line with switches `n`nAmazonButton_v2 [Button IP] [Program to Launch] "[Optional Comment]"
	ExitApp
	}
}
Return

Checkcomp:
	gosub CheckCompison
	run %2%
	ToolTip, Button at %1%`nhas been pushed.
	SetTimer, RemoveToolTip, 2000
	gosub CheckCompisbackoff
goto Checkcomp


CheckCompison:
Loop
{
PingCmd:="ping " . ComputerName . " -n 2 >" . PingResults
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
		;msgbox, button disappeared!
		ToolTip, Button at %1%`nhas disappeared.
		SetTimer, RemoveToolTip, 2000
		break
		}
	}
Return

RemoveToolTip:
SetTimer, RemoveToolTip, Off
ToolTip
return

ExitSub:
if A_ExitReason not in Logoff,Shutdown  ; Avoid spaces around the comma in this line.
{
    MsgBox, 4, , Are you sure you want to close the daemon monitoring button at `n%1%?`n`nComment: %comment%
    IfMsgBox, No
        return
}
sleep 3000
FileDelete, %PingResults%
if ErrorLevel   ; i.e. it's not blank or zero.
    MsgBox, ummm... error says %ErrorLevel%
ExitApp
