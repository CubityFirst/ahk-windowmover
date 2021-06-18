#NoTrayIcon
SetTitleMatchMode, 2
#SingleInstance Ignore
#WinActivateForce
 
; ### LAUNCHING PROGRAMS ###
; All programs only launch if they are not already open.
; This avoids duplicate windows being launched.
 
; Launch "OBS"
if !WinExist("ahk_exe obs64.exe")
	Run, "F:\Scripts\window-mover\Shortcuts\obs64.lnk"

; Launch "Streamlabels"
if !WinExist("ahk_exe StreamLabels.exe")
	Run, "C:\Users\Cubity_First\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\StreamLabels.lnk"
 
; Launch "Discord". Uses this shortcut because Discord installs into a version specific folder.
; If I attempt to launch "Discord.exe" directly, it will eventually break. But this shortcut won't.
Run "C:\Users\Cubity_First\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Discord Inc\Discord.lnk"
 
; Close & Relaunch Spotify. Not closing it first can cause window display issues.
Process,Close,Spotify.exe
Run, "C:\Users\Cubity_First\AppData\Roaming\Spotify\Spotify.exe"
 
; ; Launch "Notepad"
; if !WinExist("test ahk_class Notepad")
; {
; 	Run,D:\OBS\assets\test.txt
; 	varNotepad=0
 
; }

; Moving Programs                                                                                                                                                                              
 
; Waits for "Discord" to be done launching, then moves it.
WinWait,Discord ahk_class Chrome_WidgetWin_1
if WinExist("Discord ahk_class Chrome_WidgetWin_1")
{
	WinActivate,Discord ahk_class Chrome_WidgetWin_1
	WinRestore,Discord ahk_class Chrome_WidgetWin_1
	ResizeWin(960,1040)
	WinMove,Discord ahk_class Chrome_WidgetWin_1,,1920,0
}
 
; Waits for "Spotify" to be done launching, then moves it. 
; Spotify is VERY finicky, so a custom script targets the window itself.
WinWait, ahk_exe Spotify.exe
if WinExist("ahk_exe Spotify.exe")
{
	winId := Get_Spotify_Id()
	WinGetTitle, outputText, ahk_id %winId%
	WinActivate, ahk_id %winId%
}
if WinActive("ahk_exe Spotify.exe")
{
	WinMove,ahk_id %winId%,,2880,0
	ResizeWin(960, 1040)
 
	; Get the ID of the Spotify window (using cache)
	Get_Spotify_Id()
	{
		if (Is_Spotify(cached_spotify_window))
			return cached_spotify_window
 
		WinGet, windows, List, ahk_exe Spotify.exe
		Loop, %windows%
		{
			winId := windows%A_Index%
			if (Is_Spotify(winId))
			{
				cached_spotify_window = %winId%
				return winId
			}
		}
	}
 
	; # Check if the given ID is a Spotify window #
	Is_Spotify(winId)
	{
		WinGetClass, class, ahk_id %winId%
		if (class == "Chrome_WidgetWin_0") 
		{
			WinGetTitle, title, ahk_id %winId%
			return (title != "")
		}
		return false
	}
}
 
; Waits for "OBS" to be done launching, then moves it. 
WinWait,OBS ahk_exe obs64.exe
if WinExist("OBS ahk_exe obs64.exe")
{
	WinActivate,OBS ahk_exe obs64.exe
	ResizeWin(1416,1046) ; This has a +6 added for some stupid fucking reason, ShareX & Windows both agree that that's 1040 px vert, but then AHK is like "eh fuck it"
	WinMove,OBS ahk_exe obs64.exe,,-1926,0 ; same here, -1920 should be far left top corner on left hand side screen, but it requires -6 to make it clean.
}

; Waits for "StreamLabels" to be done launching, then moves it. 
; StreamLabels is VERY finicky, so a custom script targets the window itself.
; This code was originally from Spotify, but it seems to use the exact same issue as chrome.
WinWait, ahk_exe StreamLabels.exe
if WinExist("ahk_exe StreamLabels.exe")
{
	winId := Get_StreamLabels_Id()
	WinGetTitle, outputText, ahk_id %winId%
	WinActivate, ahk_id %winId%
}
if WinActive("ahk_exe StreamLabels.exe")
{
	WinMove,ahk_id %winId%,,-524,0
	ResizeWin(530,1045)
 
	; Get the ID of the StreamLabels window (using cache)
	Get_StreamLabels_Id()
	{
		if (Is_StreamLabels(cached_StreamLabels_window))
			return cached_StreamLabels_window
 
		WinGet, windows, List, ahk_exe StreamLabels.exe
		Loop, %windows%
		{
			winId := windows%A_Index%
			if (Is_StreamLabels(winId))
			{
				cached_StreamLabels_window = %winId%
				return winId
			}
		}
	}
 
	; # Check if the given ID is a StreamLabels window #
	Is_StreamLabels(winId)
	{
		WinGetClass, class, ahk_id %winId%
		if (class == "Chrome_WidgetWin_1") 
		{
			WinGetTitle, title, ahk_id %winId%
			return (title != "")
		}
		return false
	}
}
 
; Handles window resizing, as AHK's "WinMove" resizing can be finnicky.
ResizeWin(Width = 0,Height = 0)
{
	WinGetPos,X,Y,W,H,A
	If %Width% = 0
		Width := W
	If %Height% = 0
		Height := H
	WinMove,A,,%X%,%Y%,%Width%,%Height%
}