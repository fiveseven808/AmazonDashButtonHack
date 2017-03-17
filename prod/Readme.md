Amazon Dash Button Hack 
=======================
### Dash Button Discovery App and Server Daemon v4.1


### Summary: 
------------
Updated components for specific versions can be found on the release page of the gitrepo
[https://github.com/fiveseven808/AmazonDashButtonHack/releases/tag/170316](https://github.com/fiveseven808/AmazonDashButtonHack/releases/tag/170316)


### Download the latest version [here!](https://github.com/fiveseven808/AmazonDashButtonHack/releases/download/170316/AmazonButton_Discovery_170316.zip)  


-----------------------------------------------------
**Instructions as of 3/16/2017**  
**Requirements:**  

  * Amazon Dash Button connected to Wifi (follow instructions [here](http://www.instructables.com/id/Amazon-Dash-Button-Hack/))  
  * Class C subnet  
    *(If you don't know what this is, don't worry about it)*
  * Preferably a reserved DHCP IP for the button  
    *(If you don't know what this is, you may need to rerun the Discovery program from time to time)*

	
**Normal Usage Instructions:**

  1. Double click "AmazonButton_Discovery.exe" to start scanning for buttons
  2. Click "OK" at the prompt
  3. Start pushing the button you wish to pair repeatedly. Keep the LED "White!"
  4. If no Amazon Devices are found, try again, but start pushing the button as soon as you double click on the EXE
  5. If more than one Amazon Devices are found, You'll have to go and figure out what IP corresponds with your button on your own. I have not automated this process yet. Disconnect and power off your other Amazon devices if you wish to use this program easily (i.e. Echo, Dash, Fire TV, Fire Tablet, etc) 
  6. Pick a program you wish to run when the Button is pushed
  7. Enter a comment for the daemon, this will identify the particular daemon corresponding with the particular button. Comment ex. "Elements button toggling Porch Lights" 
  8. If you do not wish to have the tooltip appear near your mouse every time a button is pushed, choose your option
  9. Finished! Repeat as necessary for any other buttons. 


**If you already know the IP of your button:**

  1. Double click *AmazonButton_Server.exe*
  2. Enter the known/reserved IP of your Dash button 
  3. Pick a program you wish to run when the Button is pushed
  4. Enter a comment for the daemon, this will identify the particular daemon corresponding with the particular button. Comment ex. "Elements button toggling Porch Lights" 
  5. If you do not wish to have the tooltip appear near your mouse every time a button is pushed, choose your option
  6. Finished! Repeat as necessary for any other buttons. 


**Command Line Arguments:**

  1. *AmazonButton_Server.exe* [Button IP] [Program to Launch] "[Optional Comment]" [/s]
  2. Repeat as necessary for any other buttons. 

-----------------------------------------------------


**Wishlist:** *(To be implemented)*

  * Batch file creation to allow followup button usage (if Reserved IPs) without having to run through the Discovery program
  * Automatic "Amazon Button vs other Amazon device" distinguishing
  * Button "Manager" GUI 

**Known bugs**

  * Windows Defender (and only Defender it seems) flags my program as a false positive. A review has been submitted to Microsoft already. Issues that are opened and are do not offer a suggestion on how to fix this will be closed immediately since source code is available. [More details here](https://github.com/fiveseven808/AmazonDashButtonHack/issues/1)

  * There are reports that the new JK29LP button loses it's Wifi configuration if you disassociate it with your amazon account. The current "workaround" is to use a dummy Amazon account to setup your button with your phone and then sign back into your own account so you can still use the app. [More details here](https://github.com/fiveseven808/AmazonDashButtonHack/issues/3)

**License:** 

[Creative Commons Attribution-NonCommercial 4.0 International ](https://creativecommons.org/licenses/by-nc/4.0/)  

Obviously the creator of this software can't and won't be held responsible for any sort of "issues" or "problems" that may arise through use of or viewing of any files related to this project. 

**Donations:**

If this project has been useful to you, I'd appreciate it if you would buy me a drink! :D 

[![](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=7V4SEHWVDNQL6)