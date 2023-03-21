'iFit-Wolf2 - get and set speed and incline on treadmill via ADB

'to debug - enable wscript.echo and run by cscript in command line
'on error resume next 

createobject("wscript.shell").popup "Ensure treadmill is in manual workout mode and onscreen speed and incline controls are visible", 5, "Warning", 64

'initialize
set wso = createobject("wscript.shell")

'ifit tablet coordinates
speedx1 = 1845     'x pixel position of middle of speed slider
inclinex1 = 75	 'x pixel position of middle of incline slider
bottomy = 807      'y pixel position of bottom of sliders

'pixel scaling factors
speedscale = 31.0
inclinescale = 31.1

'construct todays wolflog filename
dy = right(string(2,"0") & day(now), 2)
mo = right(string(2,"0") & month(now), 2)
yr = year(now)
infilename = yr & "-" & mo & "-" & dy & "_logs.txt"
infilename2 = "/sdcard/.wolflogs/" & infilename
'wscript.echo infilename2

'loop - process todays wolflog
Do

  'query current speed
  cmdstring = "adb shell tail -n5000 " & infilename2 & " | grep -a ""Changed KPH""" & " | tail -n1 | grep -oE ""[^ ]+$"""
  'wscript.echo cmdstring 
  set oexec = wso.exec("cmd /c " & cmdstring)
  sValue = oexec.stdout.readline
  If sValue <> "" then

    'important that speed is rounded to 1 decimal here
    sValue = formatnumber(csng(sValue),1)
    'sValue = formatnumber(csng(sValue),2)

  Else
    sValue = 0  
  End If
  cSpeed = sValue
  wscript.echo "Current speed: " & cSpeed

  'query current incline
  cmdstring = "adb shell tail -n5000 " & infilename2 & " | grep -a ""Changed Grade""" & " | tail -n1 | grep -oE ""[^ ]+$"""
  'wscript.echo cmdstring 
  set oexec = wso.exec("cmd /c " & cmdstring)
  sValue = oexec.stdout.readline
  If sValue <> "" then
    sValue = formatnumber(csng(sValue),1)
  Else
    sValue = 0  
  End If
  cIncline = sValue
  wscript.echo "Current incline: " & cIncline

  'input new speed
  sSpeed = InputBox("Enter target speed in kph (allowable range is 1.0 to 19.3 @ 0.1 increments): ", "New Speed")
  'wscript.echo sSpeed 
  If IsEmpty(sSpeed) Then wscript.quit
  nSpeed = Csng(sSpeed)
  If nSpeed >= 1 And nSpeed <= 19.3 Then 

    'get y pixel position of speed slider from current speed
    speedy1 = bottomy - Round((cSpeed - 1.0) * speedscale)

    'set speed slider to target position
    speedy2 = speedy1 - Round((nSpeed - cSpeed) * speedscale)  'calculate vertical pixel position for new speed 
    cmdString = "adb shell input swipe " & speedx1 & " " & speedy1 & " " & speedx1 & " " & speedy2 & " 200"  'simulate touch-swipe on speed slider
    set oexec = wso.exec("cmd /c" & cmdstring)  'execute adb command
    'wscript.echo cmdString 

    'report new speed and corresponding swipe
    wscript.echo "New speed: " & formatnumber(nSpeed,1) & " - " & cmdString

  Else
    MsgBox("Invalid speed entered: " & sSpeed)
  End If
  wscript.sleep 1000
  
  'input new incline
  sIncline = InputBox("Enter target incline in % (range is -3 to 15 @ 0.5 increments): ", "New Incline")
  'wscript.echo sIncline 
  If IsEmpty(sIncline) Then wscript.quit
  nIncline = Csng(sIncline)
  If nIncline >= -3 And nIncline <= 15 Then 

    'get y pixel position of incline slider from current incline
    incliney1 = bottomy - Round((cIncline + 3.0) * inclinescale)

    'set incline slider to target position
    incliney2 = incliney1 - Round((nIncline - cIncline) * inclinescale)  'calculate vertical pixel position for new incline 
    cmdString = "adb shell input swipe " & inclinex1 & " " & incliney1 & " " & inclinex1 & " " & incliney2 & " 200"  'simulate touch-swipe on incline slider
    set oexec = wso.exec("cmd /c" & cmdstring)  'execute adb command
    'wscript.echo cmdString 

    'report new incline and corresponding swipe
    wscript.echo "New incline: " & formatnumber(nIncline,1) & " - " & cmdString

  Else
    MsgBox("Invalid incline entered: " & sIncline)
  End If

  wscript.echo 
  wscript.sleep 2000

Loop









