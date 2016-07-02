#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

/*
what is the goal of this new build for september 2nd... 
well, better handling of multiple devices...s
how can we achieve this? 
	gui that shows what devices that show up? (probable devices, vs amazon devices? )
	when 2 or more devices are found, 
		a 1x ping goes on for all of them. 
		if the devices is detected, it goes in a waiting mode until the devices shuts off (at least 2 ng packets)
		the next device that turns on is the winner. why? because you pushed it and turned it back on	
		OR your amazon fire stick got disconnected from the network.... probably not though... 
	^ above works like how you can show up on an aircraft radar, 
		then you know a signal is "locked" lock onto the button possibilities 
	when multiple devices show up, 
		in the nice gui you can see what button/ IP is attached to what function?
		you can give the button a name, since it's not IP based
		
	

OR

quicker/more reliable discovery time? 
how can we achieve this?
	scan network once, delete common suspects and if not found yet, run a second time
	start from the middle of the ip range and work your way up and down at the same time? 
*/


comp_ip = %A_IPAddress1% 
ip_inc = 1 ; because 

StringGetPos, comp_temp, comp_ip, . , R1
stringlen, add_length, A_IPAddress1
comp_temp := comp_temp + 1
cut_char := add_length - comp_temp
;msgbox postition %comp_temp% `n %A_IPAddress1% `nAddress is %add_length% long `nSo trim %cut_char% from the right
StringTrimRight, comp_ip, comp_ip, cut_char
;msgbox, %comp_ip% is your final string
;now you have something that looks like 192.168.1. or whatever your IP range is :D 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;this is where it scans the IPs
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PingforButts:
;/*
tooltip, Starting Ping Sweep!
while ip_inc < 255
{
	;run a hidden command prompt to ping the ip
	ip_inc++ ;increment the ip
	if ip_inc = 254
		{
		tooltip, Starting Ping for %comp_ip%%ip_inc%
		msgbox, Click OK then Push button and keep it White!
		tooltip, Waiting for Pings to finish... Keep that LED white!
		PingCmd:="ping " . comp_ip . ip_inc . " -n 5"
		Runwait %comspec% /c """%PingCmd%""",,hide
		break
		}
	PingCmd:="ping " . comp_ip . ip_inc . " -n 5"
	Run %comspec% /c """%PingCmd%""",,Hide
	tooltip, Starting Ping for %comp_ip%%ip_inc%
	;sleep 10000
}
tooltip, Finished scanning, gathering results!
;*/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; this is where it pulls an arp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	PingCmd:="arp -a > arp.txt"
	Runwait %comspec% /c """%PingCmd%"""
	;msgbox, finished scanning all IPs
	;runwait arp.txt
tooltip, Interpreting results!
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; this is where it creates a list of IPs that aren't buttons or taken. 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;msgbox, your ip string is %comp_ip%
stringlen, compiplen, comp_ip
Loop
  {
	;msgbox, okay, in ping loop
	 PingError:=false
	 FileReadLine,ArpLine,arp.txt,%A_Index%
	If (ErrorLevel=1 )
	   Break 	; if there's an error with the readline break out of the line
	 IfInString,ArpLine,74-C2-46-
	 {
	   PingError:=true
	   StringGetPos, ARPedIP, ArpLine, 74-C2-46- , R1
	   ;run arp.txt
	   ;send {Down %A_Index%}
	   ;msgbox, postition of 74-C2-46- at %ARPedIP% on line %A_Index%
	   break ;because you found a button! 
	 }
	 IfInString,ArpLine,%comp_ip%
	 {
	   PingError:=true
	   StringGetPos, comptemp2, ArpLine, %comp_ip%
	   trimmed_ip := SubStr(ArpLine, comptemp2+1+compiplen, 3)
	   ;run arp.txt
	   ;send {Down %A_Index%}
	   ;msgbox, %trimmed_ip%`n%comptemp2%
	   ;break ;because you found a button! 
	 }
  }
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; this is where it looks for %comp_ip%(192.168.1.) addresses
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PingError = 0
Loop
  {
	;msgbox, okay, in ping loop
	 FileReadLine,ArpLine,arp.txt,%A_Index%
	If (ErrorLevel=1 )
	   Break 	; if there's an error with the readline break out of the line
	 IfInString,ArpLine,74-C2-46-
	 {
	   Gosub R_IP4MAC
	   /*StringGetPos, ARPedIP, ArpLine, 74-C2-46- , R1
	   StringGetPos, comptemp2, ArpLine, %comp_ip%
	   trimmed_ip := SubStr(ArpLine, comptemp2+1+compiplen, 3)
	   ;run arp.txt
	   ;send {Down %A_Index%}
	   tooltip, Dash Button Found!
	   ;msgbox, postition of 74-C2-46- at %ARPedIP% on line %A_Index%`nIP: %comp_ip%%trimmed_ip%
	   */
	 }
	 IfInString,ArpLine,F0-D2-F1-
	 {
	   Gosub R_IP4MAC
	 }
	 IfInString,ArpLine,0C-47-C9-
	 {
	   Gosub R_IP4MAC
	 }
	 IfInString,ArpLine,44-65-0D-
	 {
	   Gosub R_IP4MAC
	 }
	 IfInString,ArpLine,50-F5-DA-
	 {
	   Gosub R_IP4MAC
	 }
	 IfInString,ArpLine,74-75-48-
	 {
	   Gosub R_IP4MAC
	 }
	 IfInString,ArpLine,84-D6-D0-
	 {
	   Gosub R_IP4MAC
	 }
	 IfInString,ArpLine,F0-27-2D-
	 {
	   Gosub R_IP4MAC
	 }
	  IfInString,ArpLine,A0-02-DC-
	 {
	   Gosub R_IP4MAC
	 }
  }
 ;runwait Amazon_IPs.txt
 msgbox, %pingError% Amazon Devices found
FileDelete, arp.txt
if PingError = 0
	{
	tooltip, Dash Button Not Found!
	msgbox, didn't find the button... keep pressing it! next time!
	}
else if PingError > 1
	{
	;insert something here about autoprobing all of the IPs in Amazon_IPs.txt and whatever lights up first is the button you probably want lol
	msgbox, 1,too many amazon devices,too many amazon devices on the network. a better solution will be implemented in the future. `nping all of the IPs in this text file then figure out what you want. use the other exe to run what you want
	IfMsgbox Cancel
		exitapp
	runwait Amazon_IPs.txt
	InputBox, Chosen_IP , Enter IP of Button, Button IP Goes here
	if ErrorLevel
		exitapp
	FileSelectfile, DaemonFile
	DaemonFile = "%DaemonFile%"
	DaemonCmd:="AmazonButton_V2.exe " . Chosen_IP . " " . DaemonFile
	Run %DaemonCmd%
	FileDelete, Amazon_IPs.txt
	msgbox, You will now run %DaemonFile% When the button at %Chosen_IP% has been pressed! 
	exitapp
	}
else
	{
	FileDelete, Amazon_IPs.txt
	msgbox, 6, ,,Amazon Dash Button found! `n`nDo you want to launch the Amazon Dash Button Daemon for %comp_ip%%trimmed_ip%? `n`nPlease wait until there are no lights on the Button before continuing
	IfMsgbox TryAgain
		goto PingforButts
	IfMsgbox Cancel
		exitapp
	FileSelectfile, DaemonFile
	DaemonFile = "%DaemonFile%"
	DaemonCmd:="AmazonButton_V2.exe " . comp_ip . trimmed_ip . " " . DaemonFile
	;msgbox, %DaemonCmd%
	Run %DaemonCmd%
	msgbox, You will now run %DaemonFile% When the button at %Comp_IP%%trimmed_ip% has been pressed! 
	}
FileDelete, Amazon_IPs.txt
Exitapp


;---------------------------------Subroutines-------------------------------------
R_IP4MAC:
{
	PingError++
	StringGetPos, comptemp2, ArpLine, %comp_ip%
	trimmed_ip := SubStr(ArpLine, comptemp2+1+compiplen, 3)
	tooltip, Dash Button Found! @ %comp_ip%%trimmed_ip%
	FileAppend, %comp_ip%%trimmed_ip%`n, Amazon_IPs.txt
Return
}
/*
run a simultaneous ping for all IPs in a given subnet
should show up in the ARP table
scan arp table for mac addresses that start with the amazon button
any arp entries that exist within the subnet that do not have the button mac are excluded from the next round of pings
keep running simultaneous pings until buttons are discovered. 

when a button is found, post IP, mac and type (if identifiable by mac, like essentials vs tide or something)
associate with function. save to config file? kind of like how i saved the computers in AATT, use csv for ease of keeping track of stuff
also make a collum for "on" or not lol since they're not on for very long. make it like a green light or something so you know when the switch has been pressed visually 

you can do a "full refresh" button which will scan the existing IP addresses, and if the MACs change then they will be excluded. priority scanning. will take place. scan the known IPs to see if they're still buttons, exclude from next round. scan 1st round of everyone else, exclude anyone without matching MAC, end the procedure here because just a onetime refresh. 
keep scanning empty addresses space. 

"pairing mode"
this is when you keep scanning empty address space for the buttons, or any mac that could be the button. 


--------------------------
a new way to index usable possible IPs
run and scan everything, get arp table, find what aren't buttons (probably everything)
delete whatever IP is a button and save that, but keep the rest of the arp table
run a loop that increments IP and saves it to a text file. if it matches one of the ARP table IPs, then skip saving it to the text file 
then when you run a secondary ping"discovery" just increment lines on the file and pin that. that way the IPs are already parsed and won't eat up CPU time looking for a match in a file. 
any new IP found that isn't a button gets deleted from the "free IP list"
at least till a "full refresh" is performed and delets and rescans everything. 
-----------------------------
6/2/16 1:01pm update
added a shit tonn more amazon mac addresses. so many more devices now!!!

*/