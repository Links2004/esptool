@echo off

title Build program...
@set curdir=%cd%
@set pythondir="C:\Python27"
@set prgname="esptool"

if exist %pythondir% (
  if not exist "%pythondir%\Scripts\pip.exe" (
    copy /Y get-pip.py %pythondir%
  )
  copy /Y %prgname%.py %pythondir%
  copy /Y %prgname%-build.py %pythondir%
  C:
  cd %pythondir%
  if exist "python.exe" (
    if not exist "%pythondir%\Scripts\pip.exe" (
      echo Installing Pip...
      python get-pip.py
    ) 
    if exist "%pythondir%\Scripts\pip.exe" (
      cd Scripts\
      if not exist "%pythondir%\Lib\site-packages\serial\__init__.py" (
        echo Installing pyserial...
        pip install pyserial
      )
      if not exist "%pythondir%\Lib\site-packages\argparse.py" (
        echo Installing argparse...
        pip install argparse
      )
      if not exist "%pythondir%\Lib\site-packages\pyinstaller\__init__.py" (
        echo Installing pyinstaller...
        pip.exe install pyinstaller
      )
      cd ..
    ) else (
      echo ERROR! %pythondir%\Scripts\pip.exe is not found
    )

	pyinstaller "./esptool.py"

  ) else (
    echo ERROR! python.exe is not found
    goto end
  )
) else (
  echo ERROR! Python 2.7 is not found
)
:end
pause
