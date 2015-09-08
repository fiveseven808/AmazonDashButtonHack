/*
Summary:
The computer is pinged until its off (so its not fucking around with file transfer operations or something... stalling the reboot..)
Then when the comptuer is off, it loops attempting to transfer a 0 byte file. 
When it is successful, then you know when the OS is loaded enough to interpret commands :] 
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
	computername = 192.168.1.172
	Goto Checkcomp
}
Return

Checkcomp:
		gosub CheckCompison
		;Msgbox, Computer %ComputerName% is back online! :D 
		;run calc
		tooltip, 
		clickcount++
		tooltip, clickcount = %clickcount%
		gosub CheckCompisbackoff
goto main ;reset program after 5 seconds

;-----------------------------------------------------------------------------------------------------------------------------
;----------------------------------------------------------Subroutines ----------------------------------------------------------
;------------------------------------------------------------------------------------------------------------------------------

CheckCompison:
	tooltip, 
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
	tooltip, clickcount = %clickcount%
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
