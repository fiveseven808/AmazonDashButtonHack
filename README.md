Amazon Dash Button Hack 
=============
## Dash Button Discovery App and Server Daemon 


### Summary: Updated 7/3/2016
Use your Amazon Dash buttons to perform any action! Setup a server and execute any program or script when a button is pushed! Now supports up to 253 buttons!   

###### If you're lazy and just want things to "work" a basic wifi based geofencing version is available at [\Prod\Package\Prod 2016_0702.7z](https://github.com/fiveseven808/AutoHueServer/raw/master/Prod/Package/Prod%202016_0702.7z)  


**Instructions as of 7/3/2016**  
**Requirements:**

  * Amazon Dash Button connected to Wifi (follow instructions [here](http://www.instructables.com/id/Amazon-Dash-Button-Hack/))
  * Class C subnet  
    *(If you don't know what this is, don't worry about it)*
  * Preferably a reserved DHCP IP for the button  
    *(If you don't know what this is, you may need to rerun the Discovery program from time to time)*
	
**Instructions:**

  1. Double click "AmazonButton_Discovery_160702_2233.exe" to start scanning for buttons
  2. Click "OK" at the prompt
  3. Start pushing the button you wish to pair repeatedly. Keep the LED "White!"
  4. If no Amazon Devices are found, try again, but start pushing the button as soon as you double click on the EXE a
  5. If more than one Amazon Devices are found, You'll have to go and figure out what IP corresponds with your button on your own. I have not automated this process yet. Disconnect and power off your other Amazon devices if you wish to use this program easily (i.e. Echo, Dash, Fire TV, Fire Tablet, etc) 
  6. Pick a program you wish to run when the Button is pushed
  7. Enter a comment for the daemon, this will identify the particular daemon corresponding with the particular button. Comment ex. "Elements button toggling Porch Lights" 
  8. Finish! Repeat as necessary for any other buttons. 
		
		  	 
**Wishlist:** *(To be implemented)*

  * Batch file creation to allow followup button usage (if Reserved IPs) without having to run through the Discovery program
  * Automatic "Amazon Button vs other Amazon device" distinguishing
  * Button "Manager" GUI 
  * Hover over tray icon to determine button

**License:** 

[Creative Commons Attribution-NonCommercial 4.0 International ](https://creativecommons.org/licenses/by-nc/4.0/)  

Obviously the creator of this software can't and won't be held responsible for any sort of "issues" or "problems" that may arise through use of or viewing of any files related to this project. 
