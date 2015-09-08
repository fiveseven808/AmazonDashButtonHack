/*
Amazon Button v2
The button stays offline until it 
Summary:
Command line usage:
AmazonButton_v2.exe IPaddress program_to_launch.exe
AmazonButton_v2.exe 192.168.1.100 calc.exe

*/
#SingleInstance Off
PingResults:="PingResults.txt" 
PingErr1:="Destination host unreachable"
PingErr2:="Request Timed Out"
PingErr3:="TTL Expired in Transit"
PingErr4:="Unknown Host"
PingErr5:="Ping Request could not find host"
Clickcount = 0


Main:
{	
	FileDelete,%PingResults% ;Just in case the file is still there from a failed run 
	If 0 > 0
	{
		Computername = %1%
		;msgbox, Checking %computername% is on or not
		;computername = 192.168.1.172
		Goto Checkcomp
	}
	else
	{
		Msgbox, Must be run in command line with switches `n`nAmazonButton_v2 [Button IP] [Program to Launch]
		ExitApp
	}
}
Return

Checkcomp:
		gosub CheckCompison
		;Msgbox, Computer %ComputerName% is back online! :D 
		;run calc
		/*tooltip, 
		clickcount++
		tooltip, clickcount = %clickcount%
		*/
		;run %2%
		send {space}
		gosub CheckCompisbackoff
goto main ;reset program after 5 seconds

;-----------------------------------------------------------------------------------------------------------------------------
;----------------------------------------------------------Subroutines ----------------------------------------------------------
;------------------------------------------------------------------------------------------------------------------------------

CheckCompison:
	;tooltip, 
	Loop
	{
	PingCmd:="ping " . ComputerName . " -n 1 >" . PingResults
	RunWait %comspec% /c """%PingCmd%""",,Hide
	Loop
	  {
		;msgbox, okay, in ping loop
		 PingError:=false
		 FileReadLine,PingLine,%PingResults%,%A_Index%
		If (ErrorLevel=1 )
		   Break 	; if there's an error with the readline break out of the line
		 IfInString,PingLine,%PingErr1%
		 {
		   PingError:=true
		   ;msgbox, failed %PingErr1%
		   break
		 }
		 IfInString,PingLine,%PingErr2%
		 {
		   PingError:=true
		   ;msgbox, failed %PingErr2%
		   break
		 }
		 IfInString,PingLine,%PingErr3%
		 {
		   PingError:=true
		   ;msgbox, failed %PingErr3%
			break
		 }
		 IfInString,PingLine,%PingErr4%
		 {
		   PingError:=true
		   ;msgbox, failed %PingErr4%
			break
		 }
		 IfInString,PingLine,%PingErr5%
		 {
		   PingError:=true
		   ;msgbox, failed %PingErr5%
		   break
		 }
		
	  }
		;okay, scanned file for errors and i must've found them. 
		FileDelete,%PingResults%
		;msgbox pingerror is %PingError%
		If PingError != 1
		  {
			;msgbox, okay computer is back on
			break
		  }  
	}
return

CheckCompisbackoff:
	;tooltip, clickcount = %clickcount%
	Loop
	{
	sleep 2000
	PingCmd:="ping " . ComputerName . " -n 1 >" . PingResults
	RunWait %comspec% /c """%PingCmd%""",,Hide
	Loop
	  {
		;msgbox, okay, in ping loop
		 PingError:=false
		 FileReadLine,PingLine,%PingResults%,%A_Index%
		If (ErrorLevel=1 )
		   Break 	; if there's an error with the readline break out of the line
		 IfInString,PingLine,%PingErr1%
		 {
		   PingError:=true
		   ;msgbox, failed %PingErr1%
		   break
		 }
		 IfInString,PingLine,%PingErr2%
		 {
		   PingError:=true
		   ;msgbox, failed %PingErr2%
		   break
		 }
		 IfInString,PingLine,%PingErr3%
		 {
		   PingError:=true
		   ;msgbox, failed %PingErr3%
			break
		 }
		 IfInString,PingLine,%PingErr4%
		 {
		   PingError:=true
		   ;msgbox, failed %PingErr4%
			break
		 }
		 IfInString,PingLine,%PingErr5%
		 {
		   PingError:=true
		   ;msgbox, failed %PingErr5%
		   break
		 }
		
	  }
		;okay, scanned file for errors and i must've found them. 
		FileDelete,%PingResults%
		;msgbox pingerror is %PingError%
		If PingError != 0
		  {
			;msgbox, okay computer is back off
			break
		  }  
	}
Return
