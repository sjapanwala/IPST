@echo off
chcp 65001
title IP Locator Advanced
:startscreen
mode 45,18
:: Modifyable Variables - You Can Modify These Variables
set activationcode=0
set safeip=1.1.1.1
set autosavestatus=false
set autosavefilename=savefile1
::set githublink=
:: start settings vars
::
::               __ __ ________________     ____  __  ________        
::              / //_// ____/ ____/ __ \   / __ \/ / / /_  __/        
:: ____________/ ,<  / __/ / __/ / /_/ /  / / / / / / / / /___________
::/_____/_____/ /| |/ /___/ /___/ ____/  / /_/ / /_/ / / /_____/_____/
::           /_/ |_/_____/_____/_/       \____/\____/ /_/             
::                                                                 
set version=[0.1]
if exist developerfiles.dev set developermode=[Active]
set developermode=[Inactive]
set ipvformatsaccepted=[IPV4, IPV6]
set safeipmode=[False]
if %safeip%==%safeip% set safeipmode=[True]
if exist developerfiles.dev set deviceexposure=[Hidden]
set deviceexposure=[Always Shown]
:: start data vars
::
::               __ __ ________________     ____  __  ________        
::              / //_// ____/ ____/ __ \   / __ \/ / / /_  __/        
:: ____________/ ,<  / __/ / __/ / /_/ /  / / / / / / / / /___________
::/_____/_____/ /| |/ /___/ /___/ ____/  / /_/ / /_/ / / /_____/_____/
::           /_/ |_/_____/_____/_/       \____/\____/ /_/             
::                                                                    
FOR /F %%b IN ('curl https://ipv4.icanhazip.com/') DO set INITIALIPV4=%%b
FOR /F %%a IN ('curl https://ipv4.icanhazip.com/') DO set homeipv4=%%a
FOR /F %%c IN ('curl https://icanhazip.com/') DO set homeipv6=%%c
FOR /F %%d IN ('tzutil /g') DO set TIMEZONE=%%d
FOR /F %%e IN ('curl https://ipapi.co/%homeipv4%/country/') DO set country=%%e
FOR /F %%f IN ('curl https://ipapi.co/%homeipv4%/org/') DO set networkorg=%%f
set targetip=%INITIALIPV4%
set Iptype=IPV4
:: github connection
rem coming in the future
:: autosave functionality
if %autosavestatus%==true set autosave=on
if %autosavestatus%==false set autosave=off
:: formatibilityy of autosave
if %autosavestatus%==false set autosavedisplay=[False]
if %autosavestatus%==true set autosavedisplay=[True]
:: countires defined
:mainscreengraphic
:mainscreen
set autosavefilename=savefile1
mode 45,20
cls
echo [40;37m╔══════════════════════════════════════════╗
echo [40;37m║
echo [40;37m║ ┍Target IP [[40;32m%iptype%[40;37m]
echo [40;37m║ └[[40;34m%targetip%[40;37m]
echo [40;37m║
echo [40;37m╠══════════════════════════════════════════╗ 
echo [40;37m║                                          [40;37m║
echo [40;37m║ [[40;31m1[40;37m] IP INFO {IPV4 ONLY}                  [40;37m║
echo [40;37m║ [[40;31m2[40;37m] IP INFO {IPV4 + IPV6}                [40;37m║
echo [40;37m║ [[40;31m3[40;37m] Change Target                        [40;37m║ 
echo [40;37m║ [[40;31m4[40;37m] GeoLocation                          [40;37m║
echo [40;37m║ [[40;31m5[40;37m] Settings                             [40;37m║
echo [40;37m║ [[40;31m6[40;37m] Help                                 [40;37m║
echo [40;37m║                                          [40;37m║ 
echo [40;37m╚══════════════════════════════════════════╝
set choice=
set /p choice=→ 

if %choice%==1 goto site1
if %choice%==2 goto site2
if %choice%==3 goto changeip
if %choice%==4 goto geolocation
if %choice%==5 goto settings
if %choice%==6 goto help
goto wronginput

:wronginput
echo x=msgbox("Wrong Input!" ,16, "Input Error") >> msgbox.vbs
start msgbox.vbs
timeout 1 >nul
del msgbox.vbs
goto mainscreen

:site1
if %targetip%==%safeip% goto ipcannotwork
if %iptype%==IPV4 goto continuetosite1
goto wrongformat1
:continuetosite1
mode 67, 40
curl http://ip-api.com/line/?fields=%targetip%,status,message,continent,continentCode,country,countryCode,region,regionName,city,district,zip,lat,lon,timezone,offset,currency,isp,org,as,asname,reverse,mobile,proxy,hosting,query
echo.
echo.
if %autosave%==on set filename=%autosavefilename%
if %autosave%==on goto savefilesite1
set /p savechoice= Save File? (Y/N): 
if %savechoice%==y goto savefilesite1
if %savechoice%==Y goto savefilesite1
if %savechoice%==n goto mainscreen
if %savechoice%==N goto mainscreen
goto badinput
:savefilesite1
set /p filename=Set A File Name [Will Be Saved With .txt Extention]:
if exist %filename%.txt echo [40;31mFile Exists Already[40;37m && goto savefilesite1
echo IP ADDRESS------: %targetip% >>%filename%.txt
echo IPV FORMAT------: %iptype% >>%filename%.txt
echo IP REQUEST TIME-: %time% >>%filename%.txt
echo IP REQUEST DATE-: %date% >>%filename%.txt
echo HOME IPV4-------: %homeipv4% >>%filename%.txt
echo HOME IPV6-------: %homeipv6% >>%filename%.txt
echo HOME TIMEZONE---: %TIMEZONE% >>%filename%.txt
echo REQUEST USERNAME: %username% >>%filename%.txt
echo. >>%filename%.txt
echo.  >>%filename%.txt
echo TARGET IP-------: %targetip% >>%filename%.txt
curl http://ip-api.com/line/?fields=%targetip%,status,message,continent,continentCode,country,countryCode,region,regionName,city,district,zip,lat,lon,timezone,offset,currency,isp,org,as,asname,reverse,mobile,proxy,hosting,query>>%filename%.txt
goto filesaved

:site2
if %targetip%==%safeip% goto ipcannotwork
if %iptype%==IPV4 goto continuetosite2
if %iptype%==IPV6 goto continuetosite2
goto wrongformat2
:continuetosite2
mode 67, 35
curl https://ipapi.co/%targetip%/json/
echo.
echo.
if %autosave%==on set filename=%autosavefilename%
if %autosave%==on goto savefilesite2
set /p savechoice= Save File? (Y/N): 
if %savechoice%==y goto savefilesite2
if %savechoice%==Y goto savefilesite2
if %savechoice%==n goto mainscreen
if %savechoice%==N goto mainscreen
goto badinput
:savefilesite2
set /p filename=Set A File Name [Will Be Saved With .txt Extention]:
if exist %filename%.txt echo [40;31mFile Exists Already[40;37m && goto savefilesite2
echo IP ADDRESS------: %targetip% >>%filename%.txt
echo IPV FORMAT------: %iptype% >>%filename%.txt
echo IP REQUEST TIME-: %time% >>%filename%.txt
echo IP REQUEST DATE-: %date% >>%filename%.txt
echo HOME IPV4-------: %homeipv4% >>%filename%.txt
echo HOME IPV6-------: %homeipv6% >>%filename%.txt
echo HOME TIMEZONE---: %TIMEZONE% >>%filename%.txt
echo REQUEST USERNAME: %username% >>%filename%.txt
echo. >>%filename%.txt
echo.  >>%filename%.txt
echo TARGET IP-------: %targetip% >>%filename%.txt
curl https://ipapi.co/%targetip%/json/>>%filename%.txt
goto filesaved

:changeip
mode 48,20
cls
echo ╔═════════════════════════════════════════════╗
echo  [[40;34m%networkorg%[40;37m] Communications
echo ╚═════════════════════════════════════════════╝
echo ╔═════════════════════════════════════════════╗
echo  ┍This Devices [[40;32mIPV4[40;37m]
echo  └[[40;31m*[40;37m] %homeipv4%
echo  ┍This Devices [[40;32mIPV6[40;37m]
echo  └[[40;31m*[40;37m] %homeipv6%
echo ╚═════════════════════════════════════════════╝
echo.
echo Set Your Target IP Form As [[40;32mIPV4[40;37m] or [[40;32mIPV6[40;37m]
set /p usersetiptype=→ 
if %usersetiptype%==IPV4 goto continueipset
if %usersetiptype%==IPV6 goto continueipset
goto iptypenotsupported

:continueipset
echo Set Your Target IP Following the Format Entered Previously
set /p usersetip=→ 

::check if IP is valid, usable, or block listed
if %usersetiptype%==IPV4 goto verifysetipsite1
if %usersetiptype%==IPV6 goto verifysetipsite1
:verifysetipsite1
echo ╔═════════════════════════════════════════════╗
curl http://ip-api.com/line/%usersetip%?fields=query
curl http://ip-api.com/line/%usersetip%?fields=status
curl http://ip-api.com/line/%usersetip%?fields=message
curl http://ip-api.com/line/%usersetip%?fields=org
echo ╚═════════════════════════════════════════════╝
echo.
echo If Line Says---: success, Connection Is Good
echo If Line Says---: fail   , Connection Is Bad
echo.
set targetip=%usersetip%
set iptype=%usersetiptype%
pause
goto mainscreen

:geolocation
cls
mode 80,25
FOR /F %%h IN ('curl https://ipapi.co/%targetip%/country/') DO set geolocation=%%h
if %geolocation%==US goto NA
if %geolocation%==CA goto NA 
if %geolocation%==MX goto NA
if %geolocation%==DE goto EU
if %geolocation%==AU goto OCE
if %geolocation%==PK goto ASIA
if %geolocation%==RU goto ASIA
::chcp 65001
::mode 80,25
::cls
::echo GEO LOCATION OF [%targetip%]. Continent [%geolocation%]
::echo ------------------------------------------------------------------------------- 
::echo.
::echo              [40;31m        ○○○○z○ ○○○○○○   [40;33m                                  
::echo              [40;31m     ○○○○○○○○○○○○○○○○○○ [40;33m  ○○○○          [40;35m○○○               
::echo              [40;31m   ○○○○○○○○○○○○○○○○○○○  [40;33m   ○     [40;35m○○o○○○○○○○○○  ○○○       
::echo         [40;31m○○○○○[40;31m○○○○○○○○○○○○○○ ○○○○○○   [40;33m   ○○ooo[40;35m○○○○○○○○○○○○○○○○○○○○○○○○○ 
::echo         [40;31m○○○○○[40;31m○○○○○○○○○○○○○○○○○○○ ○○  [40;33m ○○oooo[40;35m○○○○○○○○○○○○○○○○○○○○○○○○○○○
::echo          [40;31m○○○○[40;31m○○○○○○○○○○○○○○○        [40;33m○○○oooo[40;35m○○○○○○○○○○○○○○○○○○○○○○○     
::echo                  [40;31m○○○○○○○○○○○○○       [40;33m○○○○○oooo[40;35m○○○○○○○○○○○○○○○○○○ ○     
::echo                  [40;31m○○○○○○○○○○○         [40;33m○○○○○○oooo[40;35m○○○○○○○○○○○○○○○○○        
::echo                   [40;31m○○○○○○           [40;33m○○○○○○○○oooo[40;35m○○○○○○○○○○○○○○○         
::echo                   [40;31m○○○○○○○○○       [40;34m○○○○○○○○○[40;35m○○○○○○○○○○○○○○○○            
::echo                       [40;31m○○○○       [40;34m○○○○○○○○○○○[40;35m○○   ○○  ○○○○○○           
::echo                           [40;32m○○○○○○○       [40;34m○○○○○ [40;36m○○○        ○○○○○○○○○○      
::echo                         [40;32m○○○○○○○○       [40;34m○○○○○○○○         [40;36m○○○○○○○○○○     
::echo                          [40;32m○○○○○        [40;34m○○○○○○○○          [40;36m○○○○○○○ ○○ ○  
::echo                          [40;32m○○○○○          [40;34m○○○○             [40;36m○○○○○○○  ○   
::echo                         [40;32m○○○○                                  [40;36m○○  ○○○  
::echo                         [40;32m○○○○                                      [40;36m○○   
::echo                          [40;32m○○    
::pause>nul
@echo off
cls
mode 80,25
:NA
cls
echo GEO LOCATION OF [%targetip%]. Country [%geolocation%]
echo ------------------------------------------------------------------------------- 
echo.
echo            [40;31m        ○○○○z○ ○○○○○○   [40;37m                                  
echo            [40;31m     ○○○○○○○○○○○○○○○○○○ [40;37m  ○○○○          [40;37mm○○○               
echo            [40;31m   ○○○○○○○○○○○○○○○○○○○  [40;37m   ○     [40;37mm○○o○○○○○○○○○  ○○○       
echo       [40;31mm○○○○○[40;31m○○○○○○○○○○○○○○ ○○○○○○   [40;37m   ○○ooo[40;37mm○○○○○○○○○○○○○○○○○○○○○○○○○ 
echo       [40;31mm○○○○○[40;31m○○○○○○○○○○○○○○○○○○○ ○○  [40;37m ○○oooo[40;37mm○○○○○○○○○○○○○○○○○○○○○○○○○○○
echo        [40;31mm○○○○[40;31m○○○○○○○○○○○○○○○        [40;37m○○○oooo[40;37mm○○○○○○○○○○○○○○○○○○○○○○○     
echo                [40;31mm○○○○○○○○○○○○○       [40;37m○○○○○oooo[40;37mm○○○○○○○○○○○○○○○○○○ ○     
echo                [40;31mm○○○○○○○○○○○         [40;37m○○○○○○oooo[40;37mm○○○○○○○○○○○○○○○○○        
echo                 [40;31mm○○○○○○           [40;37m○○○○○○○○oooo[40;37mm○○○○○○○○○○○○○○○         
echo                 [40;31mm○○○○○○○○○       [40;37mm○○○○○○○○○[40;37mm○○○○○○○○○○○○○○○○            
echo                     [40;31mm○○○○       [40;37mm○○○○○○○○○○○[40;37mm○○   ○○  ○○○○○○           
echo                           [40;37m○○○○○○○       [40;37mm○○○○○ ○○○        [40;37mm○○○○○○○○○○      
echo                         [40;37m○○○○○○○○       [40;37mm○○○○○○○○         [40;37mm○○○○○○○○○○     
echo                          [40;37m○○○○○        [40;37mm○○○○○○○○          [40;37mm○○○○○○○ ○○ ○  
echo                          [40;37m○○○○○          [40;37mm○○○○             [40;37mm○○○○○○○  ○   
echo                         [40;37m○○○○                                  [40;37mm○○  ○○○  
echo                         [40;37m○○○○                                      [40;37mm○○   
echo                          [40;37m○○    
pause>nul
goto mainscreen
:SA
mode 80,25
cls
echo GEO LOCATION OF [%targetip%]. Country [%geolocation%]
echo ------------------------------------------------------------------------------- 
echo.
echo            [40;37m        ○○○○z○ ○○○○○○   [40;37m                                  
echo            [40;37m     ○○○○○○○○○○○○○○○○○○ [40;37m  ○○○○          [40;37mm○○○               
echo            [40;37m   ○○○○○○○○○○○○○○○○○○○  [40;37m   ○     [40;37mm○○o○○○○○○○○○  ○○○       
echo       [40;37mm○○○○○[40;37m○○○○○○○○○○○○○○ ○○○○○○   [40;37m   ○○ooo[40;37mm○○○○○○○○○○○○○○○○○○○○○○○○○ 
echo       [40;37mm○○○○○[40;37m○○○○○○○○○○○○○○○○○○○ ○○  [40;37m ○○oooo[40;37mm○○○○○○○○○○○○○○○○○○○○○○○○○○○
echo        [40;37mm○○○○[40;37m○○○○○○○○○○○○○○○        [40;37m○○○oooo[40;37mm○○○○○○○○○○○○○○○○○○○○○○○     
echo                [40;37mm○○○○○○○○○○○○○       [40;37m○○○○○oooo[40;37mm○○○○○○○○○○○○○○○○○○ ○     
echo                [40;37mm○○○○○○○○○○○         [40;37m○○○○○○oooo[40;37mm○○○○○○○○○○○○○○○○○        
echo                 [40;37mm○○○○○○           [40;37m○○○○○○○○oooo[40;37mm○○○○○○○○○○○○○○○         
echo                 [40;37mm○○○○○○○○○       [40;37mm○○○○○○○○○[40;37mm○○○○○○○○○○○○○○○○            
echo                     [40;37mm○○○○       [40;37mm○○○○○○○○○○○[40;37mm○○   ○○  ○○○○○○           
echo                           [40;31m○○○○○○○       [40;37mm○○○○○ ○○○        [40;37mm○○○○○○○○○○      
echo                         [40;31m○○○○○○○○       [40;37mm○○○○○○○○         [40;37mm○○○○○○○○○○     
echo                          [40;31m○○○○○        [40;37mm○○○○○○○○          [40;37mm○○○○○○○ ○○ ○  
echo                          [40;31m○○○○○          [40;37mm○○○○             [40;37mm○○○○○○○  ○   
echo                         [40;31m○○○○                                  [40;37mm○○  ○○○  
echo                         [40;31m○○○○                                      [40;37mm○○   
echo                          [40;31m○○    
pause>nul
goto mainscreen
:EU
mode 80,25
cls
echo [40;37mGEO LOCATION OF [%targetip%]. Country [%geolocation%]
echo ------------------------------------------------------------------------------- 
echo.
echo            [40;37m        ○○○○z○ ○○○○○○   [40;31m                                  
echo            [40;37m     ○○○○○○○○○○○○○○○○○○ [40;31m  ○○○○          [40;37mm○○○               
echo            [40;37m   ○○○○○○○○○○○○○○○○○○○  [40;31m   ○     [40;37mm○○o○○○○○○○○○  ○○○       
echo       [40;37mm○○○○○[40;37m○○○○○○○○○○○○○○ ○○○○○○   [40;31m   ○○ooo[40;37mm○○○○○○○○○○○○○○○○○○○○○○○○○ 
echo       [40;37mm○○○○○[40;37m○○○○○○○○○○○○○○○○○○○ ○○  [40;31m ○○oooo[40;37mm○○○○○○○○○○○○○○○○○○○○○○○○○○○
echo        [40;37mm○○○○[40;37m○○○○○○○○○○○○○○○        [40;31m○○○oooo[40;37mm○○○○○○○○○○○○○○○○○○○○○○○     
echo                [40;37mm○○○○○○○○○○○○○       [40;31m○○○○○oooo[40;37mm○○○○○○○○○○○○○○○○○○ ○     
echo                [40;37mm○○○○○○○○○○○         [40;31m○○○○○○oooo[40;37mm○○○○○○○○○○○○○○○○○        
echo                 [40;37mm○○○○○○           [40;31m○○○○○○○○oooo[40;37mm○○○○○○○○○○○○○○○         
echo                 [40;37mm○○○○○○○○○       [40;31mm○○○○○○○○○[40;37mm○○○○○○○○○○○○○○○○            
echo                     [40;37mm○○○○       [40;37mm○○○○○○○○○○○[40;37mm○○   ○○  ○○○○○○           
echo                           [40;37m○○○○○○○       [40;37mm○○○○○ ○○○        [40;37mm○○○○○○○○○○      
echo                         [40;37m○○○○○○○○       [40;37mm○○○○○○○○         [40;37mm○○○○○○○○○○     
echo                          [40;37m○○○○○        [40;37mm○○○○○○○○          [40;37mm○○○○○○○ ○○ ○  
echo                          [40;37m○○○○○          [40;37mm○○○○             [40;37mm○○○○○○○  ○   
echo                         [40;37m○○○○                                  [40;37mm○○  ○○○  
echo                         [40;37m○○○○                                      [40;37mm○○   
echo                          [40;37m○○    
pause>nul
goto mainscreen
:AF
mode 80,25
cls
echo [40;37mGEO LOCATION OF [%targetip%]. Country [%geolocation%]
echo ------------------------------------------------------------------------------- 
echo.
echo            [40;37m        ○○○○z○ ○○○○○○   [40;37m                                  
echo            [40;37m     ○○○○○○○○○○○○○○○○○○ [40;37m  ○○○○          [40;37mm○○○               
echo            [40;37m   ○○○○○○○○○○○○○○○○○○○  [40;37m   ○     [40;37mm○○o○○○○○○○○○  ○○○       
echo       [40;37mm○○○○○[40;37m○○○○○○○○○○○○○○ ○○○○○○   [40;37m   ○○ooo[40;37mm○○○○○○○○○○○○○○○○○○○○○○○○○ 
echo       [40;37mm○○○○○[40;37m○○○○○○○○○○○○○○○○○○○ ○○  [40;37m ○○oooo[40;37mm○○○○○○○○○○○○○○○○○○○○○○○○○○○
echo        [40;37mm○○○○[40;37m○○○○○○○○○○○○○○○        [40;37m○○○oooo[40;37mm○○○○○○○○○○○○○○○○○○○○○○○     
echo                [40;37mm○○○○○○○○○○○○○       [40;37m○○○○○oooo[40;37mm○○○○○○○○○○○○○○○○○○ ○     
echo                [40;37mm○○○○○○○○○○○         [40;37m○○○○○○oooo[40;37mm○○○○○○○○○○○○○○○○○        
echo                 [40;37mm○○○○○○           [40;37m○○○○○○○○oooo[40;37mm○○○○○○○○○○○○○○○         
echo                 [40;37mm○○○○○○○○○       [40;37mm○○○○○○○○○[40;37mm○○○○○○○○○○○○○○○○            
echo                     [40;37mm○○○○       [40;31mm○○○○○○○○○○○[40;37mm○○   ○○  ○○○○○○           
echo                           [40;37m○○○○○○○       [40;31mm○○○○○ ○○○        [40;37mm○○○○○○○○○○      
echo                         [40;37m○○○○○○○○       [40;31mm○○○○○○○○         [40;37mm○○○○○○○○○○     
echo                          [40;37m○○○○○        [40;31mm○○○○○○○○          [40;37mm○○○○○○○ ○○ ○  
echo                          [40;37m○○○○○          [40;31mm○○○○             [40;37mm○○○○○○○  ○   
echo                         [40;37m○○○○                                  [40;37mm○○  ○○○  
echo                         [40;37m○○○○                                      [40;37mm○○   
echo                          [40;37m○○    
pause>nul
goto mainscreen
:ASIA
mode 80,25
cls
echo [40;37mGEO LOCATION OF [%targetip%]. Country [%geolocation%]
echo ------------------------------------------------------------------------------- 
echo.
echo            [40;37m        ○○○○z○ ○○○○○○   [40;37m                                  
echo            [40;37m     ○○○○○○○○○○○○○○○○○○ [40;37m  ○○○○          [40;31mm○○○               
echo            [40;37m   ○○○○○○○○○○○○○○○○○○○  [40;37m   ○     [40;31mm○○o○○○○○○○○○  ○○○       
echo       [40;37mm○○○○○[40;37m○○○○○○○○○○○○○○ ○○○○○○   [40;37m   ○○ooo[40;31mm○○○○○○○○○○○○○○○○○○○○○○○○○ 
echo       [40;37mm○○○○○[40;37m○○○○○○○○○○○○○○○○○○○ ○○  [40;37m ○○oooo[40;31mm○○○○○○○○○○○○○○○○○○○○○○○○○○○
echo        [40;37mm○○○○[40;37m○○○○○○○○○○○○○○○        [40;37m○○○oooo[40;31mm○○○○○○○○○○○○○○○○○○○○○○○     
echo                [40;37mm○○○○○○○○○○○○○       [40;37m○○○○○oooo[40;31mm○○○○○○○○○○○○○○○○○○ ○     
echo                [40;37mm○○○○○○○○○○○         [40;37m○○○○○○oooo[40;31mm○○○○○○○○○○○○○○○○○        
echo                 [40;37mm○○○○○○           [40;37m○○○○○○○○oooo[40;31mm○○○○○○○○○○○○○○○         
echo                 [40;37mm○○○○○○○○○       [40;37mm○○○○○○○○○[40;31mm○○○○○○○○○○○○○○○○            
echo                     [40;37mm○○○○       [40;37mm○○○○○○○○○○○[40;37mm○○   ○○  ○○○○○○           
echo                           [40;37m○○○○○○○       [40;37mm○○○○○ ○○○        [40;37mm○○○○○○○○○○      
echo                         [40;37m○○○○○○○○       [40;37mm○○○○○○○○         [40;37mm○○○○○○○○○○     
echo                          [40;37m○○○○○        [40;37mm○○○○○○○○          [40;37mm○○○○○○○ ○○ ○  
echo                          [40;37m○○○○○          [40;37mm○○○○             [40;37mm○○○○○○○  ○   
echo                         [40;37m○○○○                                  [40;37mm○○  ○○○  
echo                         [40;37m○○○○                                      [40;37mm○○   
pause>nul
goto mainscreen
:OCE
mode 80,25
cls
echo [40;37mGEO LOCATION OF [%targetip%]. Country [%geolocation%]
echo ------------------------------------------------------------------------------- 
echo.
echo            [40;37m        ○○○○z○ ○○○○○○   [40;37m                                  
echo            [40;37m     ○○○○○○○○○○○○○○○○○○ [40;37m  ○○○○          [40;37mm○○○               
echo            [40;37m   ○○○○○○○○○○○○○○○○○○○  [40;37m   ○     [40;37mm○○o○○○○○○○○○  ○○○       
echo       [40;37mm○○○○○[40;37m○○○○○○○○○○○○○○ ○○○○○○   [40;37m   ○○ooo[40;37mm○○○○○○○○○○○○○○○○○○○○○○○○○ 
echo       [40;37mm○○○○○[40;37m○○○○○○○○○○○○○○○○○○○ ○○  [40;37m ○○oooo[40;37mm○○○○○○○○○○○○○○○○○○○○○○○○○○○
echo        [40;37mm○○○○[40;37m○○○○○○○○○○○○○○○        [40;37m○○○oooo[40;37mm○○○○○○○○○○○○○○○○○○○○○○○     
echo                [40;37mm○○○○○○○○○○○○○       [40;37m○○○○○oooo[40;37mm○○○○○○○○○○○○○○○○○○ ○     
echo                [40;37mm○○○○○○○○○○○         [40;37m○○○○○○oooo[40;37mm○○○○○○○○○○○○○○○○○        
echo                 [40;37mm○○○○○○           [40;37m○○○○○○○○oooo[40;37mm○○○○○○○○○○○○○○○         
echo                 [40;37mm○○○○○○○○○       [40;37mm○○○○○○○○○[40;37mm○○○○○○○○○○○○○○○○            
echo                     [40;37mm○○○○       [40;37mm○○○○○○○○○○○[40;37mm○○   [40;31○○  ○○○○○○           
echo                           [40;37m○○○○○○○       [40;37mm○○○○○ ○○○        [40;31mm○○○○○○○○○○      
echo                         [40;37m○○○○○○○○       [40;37mm○○○○○○○○         [40;31mm○○○○○○○○○○     
echo                          [40;37m○○○○○        [40;37mm○○○○○○○○          [40;31mm○○○○○○○ ○○ ○  
echo                          [40;37m○○○○○          [40;37mm○○○○             [40;31mm○○○○○○○  ○   
echo                         [40;37m○○○○                                  [40;31mm○○  ○○○  
echo                         [40;37m○○○○                                      [40;31mm○○   
echo                          [40;37m○○    
pause>nul
goto mainscreen
:settings
mode 45,20
cls
echo [40;37m------------------Settings------------------
echo.
echo Version State---------------:%version%
echo Current Formats Accepted----:%ipvformatsaccepted%
echo Developer Mode--------------:%developermode%
echo Safe IP Mode----------------:%safeipmode%
echo Device Exposure-------------:%deviceexposure%
echo Auto Save-------------------:%autosavedisplay%
echo.
echo ------------------Details-------------------
echo.
echo Computer Name---------------:%computername%
echo User Name-------------------:%username%
echo Country---------------------:%country%
echo Time Zone-------------------:%TIMEZONE%
echo Activation Code-------------:%activationcode%
echo GitHub Connection-----------:Not Available

pause>nul
goto mainscreen
:help
cls
echo Welcome To Help
echo - - - - - - - - - - - - - -

:wrongformat1
echo x=msgbox("Wrong IPV Format. This Function Requires IPV4. Please Check Your Format For Writing Errors" ,16, "IP Format Error") >> msgbox.vbs
start msgbox.vbs
timeout 1 >nul
del msgbox.vbs
goto mainscreen

:wrongformat2
echo x=msgbox("Wrong IPV Format. This Function Requires IPV4 or IPV6. Please Check Your Format For Writing Errors" ,16, "IP Format Error") >> msgbox.vbs
start msgbox.vbs
timeout 1 >nul
del msgbox.vbs
goto mainscreen

:badinput
echo x=msgbox("Bad Input Detected. File Not Saved. Please Enter IP Again And Save File" ,16, "Input Error") >> msgbox.vbs
start msgbox.vbs
timeout 1 >nul
del msgbox.vbs
goto mainscreen

:filesaved
echo x=msgbox("File Saved As [ %filename%.txt ]" ,64, "Save Successful") >> msgbox.vbs
start msgbox.vbs
timeout 1 >nul
del msgbox.vbs
goto mainscreen

:iptypenotsupported
echo x=msgbox("Sorry, This IP Type Is Not Supported Or Is Entered Incorrectly. Please Check For Errors In Typing" ,16, "Input Error") >> msgbox.vbs
start msgbox.vbs
timeout 1 >nul
del msgbox.vbs
goto changeip

:ipcannotwork
echo x=msgbox("Sorry [%targetip%] Has Been Saved as a Safe IP and Cannot Be Searched. Please Enter A Different IP or Remove SafeIP" ,16, "IP Safe Error") >> msgbox.vbs
start msgbox.vbs
timeout 1 >nul
del msgbox.vbs
goto mainscreen