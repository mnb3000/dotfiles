#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Link Keyboard to iPad
# @raycast.mode compact

# Optional parameters:
# @raycast.icon ⌨️
# @raycast.packageName System Preferences

# Documentation:
# @raycast.description Link keyboard and mouse to iPad
# @raycast.author mnb3000
# @raycast.authorURL https://github.com/mnb3000

set airPlayDevice to "myk-ipad"

tell application "System Events"
	tell its application process "ControlCenter"
		set osVersion to get system version of (system info)
		-- log osVersion
		set status to ""
		-- click on Display dropdown if it's on the menu bar
		if exists (first UI element of menu bar 1 whose value of attribute "AXIdentifier" contains "display") then
			set displayDropDownButton to first UI element of menu bar 1 whose value of attribute "AXIdentifier" contains "display"
			click displayDropDownButton
			delay 0.15
			set window_ to title of its window as string
			-- click on the Control Center drop down on menu bar
		else
			set controlCenter to first UI element of menu bar 1 whose value of attribute "AXIdentifier" contains "controlcenter"
			click controlCenter
			delay 0.15
			set window_ to title of its window as string
			set status to controlCenterDropDown(osVersion, window_) of me as string
			
		end if
		
		if status is not "failed" then
			getDisplayDropDown(osVersion, airPlayDevice, window_) of me
		end if
		
	end tell
end tell
return


-- "click" on display on the Control Center drop down
on controlCenterDropDown(osVersion, window_)
	tell application "System Events"
		tell its application process "ControlCenter"
			tell its window window_
				
				-- clicking doesn't actually work on the display text 
				-- in the Control Center dropdown so it's click action is "perform action 1" or "perform action 2" depending on system version
				-- we will also find the Display by using AXIdentifier or title
				try
					-- ventura
					if osVersion > 13 then
						set controlCenterElements to UI elements of group 1
						set myattribute to "AXIdentifier"
						set myaction to 1
						
						-- Monterey 
					else if osVersion < 13 and osVersion > 12 then
						set controlCenterElements to UI elements
						set myattribute to "AXIdentifier"
						set myaction to 1
						
						-- big sur
					else
						set controlCenterElements to UI elements of group 1 of group 1
						set myattribute to "AXTitle"
						set myaction to 1
					end if
				on error
					log "Error getting display button"
					return "failed"
				end try
				-- go through the UI elements of Control Center drop down and "click" on the display button
				repeat with anItem in controlCenterElements
					try
						if exists attribute myattribute of anItem then
							if value of attribute myattribute of anItem contains "display" or value of attribute myattribute of anItem contains "Display" then
                click anItem
                perform action 1 of anItem
								exit repeat
							end if
						end if
					on error
						log "error clicking display"
						return "failed"
					end try
				end repeat
				delay 0.3
			end tell
		end tell
	end tell
	return
end controlCenterDropDown


on getDisplayDropDown(osVersion, airPlayDevice, window_)
	tell application "System Events"
		tell its application process "ControlCenter"
			tell its window window_
				set displayDropDown to ""
				try
					-- get ui elements of display drop down
					-- Ventura
					if osVersion > 13 then
						set x to UI elements --?? if in menu bar this is needed ??
						set displayDropDown to UI elements of group 1
					-- Monterey
					else if osVersion < 13 and osVersion > 12 then
						set x to UI elements --?? if in menu bar this is needed ??
						set displayDropDown to UI elements
						-- big sur
					else
						set displayDropDown to UI elements of group 1
						
					end if
				on error
					log "Error getting UI elements of display drop down."
					return "failed"
				end try
				
				repeat with anItem in displayDropDown
					try
						set itemsOfDisplayMenu to value of attribute "AXChildren" of anItem
						-- find ipad device and click
						repeat with childItem in itemsOfDisplayMenu
							if (exists attribute "AXIdentifier" of childItem) then
								set aDisplayItem to value of attribute "AXIdentifier" of childItem
								--	log aDisplayItem
							else
								set aDisplayItem to title of childItem
								--	log aDisplayItem
							end if
							if aDisplayItem ends with airPlayDevice then
								click childItem
                # key code 53
                log "Connected!"
								exit repeat
							end if
						end repeat
					on error errStr
            log errStr
						log "error clicking on or setting device in Display drop down "
					end try
				end repeat
			end tell
		end tell
    delay 1
    key code 53
	end tell
	return
end getDisplayDropDown
