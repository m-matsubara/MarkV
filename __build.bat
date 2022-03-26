@echo off
setlocal EnableDelayedExpansion

set INIT_DIR=%CD%
cd %INIT_DIR%\..
set BASE_DIR=%CD%
cd %~dp0
set SOURCE_DIR=%CD%
cd %SOURCE_DIR%

rem ■ 環境変数の設定
title 環境変数の設定
set MarkV_VER_APP=0.0.2 beta 2
rem set MarkV_VER_APP=1.0.0 release candidate 1
rem set MarkV_VER_APP=1.0.0

for /F "tokens=1-3 delims=/ " %%a in ('date /t') do SET DT=%%a%%b%%c
for /F "tokens=1-3 delims=: " %%a in ('time /t') do SET DT=%DT%_%%a%%b

set MarkV_VER=%MarkV_VER_APP%
set MarkV_VER=%MarkV_VER: beta =_beta%
set MarkV_VER=%MarkV_VER: release candidate =_rc%

rem RADSTUDIO_VER=19.0 ... Delphi 10.2 (CompilerVersion 32.0)
rem RADSTUDIO_VER=20.0 ... Delphi 10.3 (CompilerVersion 33.0)
rem RADSTUDIO_VER=21.0 ... Delphi 10.4 (CompilerVersion 34.0)
rem RADSTUDIO_VER=22.0 ... Delphi 11.0 (CompilerVersion 35.0)
set RADSTUDIO_VER=22.0

set ARCHIVE_DIR=..\MarkV_archive\MarkV_%MarkV_VER%_%DT%

set RADSTUDIO_HOME=C:\Program Files (x86)\Embarcadero\Studio\%RADSTUDIO_VER%


md Win64 > nul 2>&1
md Win64\Release > nul 2>&1
md Win64\Release\js > nul 2>&1
md Win64\Release\css > nul 2>&1
md %ARCHIVE_DIR%
md %ARCHIVE_DIR%\js
md %ARCHIVE_DIR%\css

rem ■ コミットハッシュ
for /f "DELIMS=" %%A in ('git rev-parse HEAD') do set COMMIT_HASH_MarkV=%%A

rem ■ ビルド
echo const VERSION_STRING = '%MarkV_VER_APP%';>_version.inc
rem fc version.inc _version.inc > nul
rem if not %errorlevel% == 0 echo const VERSION_STRING = '%MarkV_VER_APP%';>version.inc
rem del _version.inc
echo Version %MarkV_VER_APP%

rem for /F "tokens=1-3 delims=/ " %%a in ('date /t') do SET BUILD_DT=%%a/%%b/%%c
rem echo const BUILD_DATE = '%BUILD_DT%';>build_info.inc

title ビルド(x64)
set ARGS=
set ARGS=%ARGS% -$O+
set ARGS=%ARGS% -$C-
set ARGS=%ARGS% -$L-
set ARGS=%ARGS% -$Y-
set ARGS=%ARGS% -$D-
set ARGS=%ARGS% -$L-
set ARGS=%ARGS% -$Y-
set ARGS=%ARGS% --no-config
set ARGS=%ARGS% -M
set ARGS=%ARGS% -Q
set ARGS=%ARGS% --drc
set ARGS=%ARGS% -AGenerics.Collections=System.Generics.Collections
set ARGS=%ARGS%;Generics.Defaults=System.Generics.Defaults
set ARGS=%ARGS%;WinTypes=Windows
set ARGS=%ARGS%;WinProcs=Windows
set ARGS=%ARGS%;DbiTypes=BDE
set ARGS=%ARGS%;DbiProcs=BDE
set ARGS=%ARGS%;DbiErrs=BDE
set ARGS=%ARGS% -DRELEASE
set ARGS=%ARGS% -E".\Win64\Release"

set ARGS=%ARGS% -LE"C:\Users\Public\Documents\Embarcadero\Studio\%RADSTUDIO_VER%\Bpl"
set ARGS=%ARGS% -LN"C:\Users\Public\Documents\Embarcadero\Studio\%RADSTUDIO_VER%\Dcp"
set ARGS=%ARGS% -N0".\Win64\Release"
set ARGS=%ARGS% -NSDatasnap.Win
set ARGS=%ARGS%;Web.Win
set ARGS=%ARGS%;Soap.Win
set ARGS=%ARGS%;Xml.Win
set ARGS=%ARGS%;Vcl
set ARGS=%ARGS%;Vcl.Imaging
set ARGS=%ARGS%;Vcl.Touch
set ARGS=%ARGS%;Vcl.Samples
set ARGS=%ARGS%;Vcl.Shell
set ARGS=%ARGS%;System
set ARGS=%ARGS%;Xml
set ARGS=%ARGS%;Data;Datasnap
set ARGS=%ARGS%;Web
set ARGS=%ARGS%;Soap
set ARGS=%ARGS%;Winapi
set ARGS=%ARGS%;Data.Win
set ARGS=%ARGS%;System.Win
set ARGS=%ARGS%;

rem オブジェクトディレクトリ(ライブラリ, *.dcu)
set ARGS=%ARGS% -O"%RADSTUDIO_HOME%\lib\Win64\release"
set ARGS=%ARGS%;"C:\Users\%USERNAME%\Documents\Embarcadero\Studio\%RADSTUDIO_VER%\Imports"
set ARGS=%ARGS%;"%RADSTUDIO_HOME%\Imports"
set ARGS=%ARGS%;"C:\Users\Public\Documents\Embarcadero\Studio\%RADSTUDIO_VER%\Dcp\Win64"
set ARGS=%ARGS%;"%RADSTUDIO_HOME%\include"

rem リソースディレクトリ(*.dfmとか)
set ARGS=%ARGS% -R"%RADSTUDIO_HOME%\lib\Win64\release\JA"
set ARGS=%ARGS%;"%RADSTUDIO_HOME%\lib\Win64\release"
set ARGS=%ARGS%;"C:\Users\%USERNAME%\Documents\Embarcadero\Studio\%RADSTUDIO_VER%\Imports"
set ARGS=%ARGS%;"%RADSTUDIO_HOME%\Imports"
set ARGS=%ARGS%;"C:\Users\Public\Documents\Embarcadero\Studio\%RADSTUDIO_VER%\Dcp\Win64"
set ARGS=%ARGS%;"%RADSTUDIO_HOME%\include"

rem インクルードディレクトリ(*.inc)
set ARGS=%ARGS% -I"%RADSTUDIO_HOME%\lib\Win64\release\JA"
set ARGS=%ARGS%;"%RADSTUDIO_HOME%\lib\Win64\release"
set ARGS=%ARGS%;"C:\Users\%USERNAME%\Documents\Embarcadero\Studio\%RADSTUDIO_VER%\Imports"
set ARGS=%ARGS%;"%RADSTUDIO_HOME%\Imports"
set ARGS=%ARGS%;"C:\Users\Public\Documents\Embarcadero\Studio\%RADSTUDIO_VER%\Dcp\Win64"
set ARGS=%ARGS%;"%RADSTUDIO_HOME%\include"

rem ユニットディレクトリ(*.pas)
set ARGS=%ARGS%; -U"%RADSTUDIO_HOME%\lib\Win64\release\JA"
set ARGS=%ARGS%;"%RADSTUDIO_HOME%\lib\Win64\release"
set ARGS=%ARGS%;"C:\Users\%USERNAME%\Documents\Embarcadero\Studio\%RADSTUDIO_VER%\Imports"
set ARGS=%ARGS%;"%RADSTUDIO_HOME%\Imports"
set ARGS=%ARGS%;"C:\Users\Public\Documents\Embarcadero\Studio\%RADSTUDIO_VER%\Dcp\Win64"
set ARGS=%ARGS%;"%RADSTUDIO_HOME%\include"

set ARGS=%ARGS% -K00400000
set ARGS=%ARGS% -GS
set ARGS=%ARGS% -NB"C:\Users\Public\Documents\Embarcadero\Studio\%RADSTUDIO_VER%\Dcp\Win64"
set ARGS=%ARGS% -NH"C:\Users\Public\Documents\Embarcadero\Studio\%RADSTUDIO_VER%\hpp"
set ARGS=%ARGS% -N0".\Win64\Release"
rem set ARGS=%ARGS% -W+UNSAFE_TYPE
rem set ARGS=%ARGS% -W+UNSAFE_CODE
rem set ARGS=%ARGS% -W+UNSAFE_CAST
set ARGS=%ARGS% -W-
set ARGS=%ARGS% MarkV.dpr

"%RADSTUDIO_HOME%\bin\dcc64.exe" %ARGS% >_make_x64.log
set EL=%ERRORLEVEL%
if     %EL%==0 echo ビルド成功(x64)
if not %EL%==0 type _make_x64.log
if not %EL%==0 goto :BUILD_X64_FAILURE
"%RADSTUDIO_HOME%\bin\dcc64.exe" --version > Win64\Release\build_info.txt

xcopy /d /y "C:\Program Files (x86)\Embarcadero\Studio\%RADSTUDIO_VER%\Redist\Win64\WebView2Loader.dll" Win64\Release
xcopy /e /d /y *.md Win64\Release
xcopy /e /d /y *.bat Win64\Release
xcopy /e /d /y js\* Win64\Release\js
xcopy /e /d /y css\* Win64\Release\css

xcopy /y Win64\Release\MarkV.exe %ARCHIVE_DIR%
xcopy /d /y "C:\Program Files (x86)\Embarcadero\Studio\%RADSTUDIO_VER%\Redist\Win64\WebView2Loader.dll" %ARCHIVE_DIR%
xcopy /e /d /y *.md %ARCHIVE_DIR%
xcopy /e /d /y *.bat %ARCHIVE_DIR%
xcopy /e /d /y js\* %ARCHIVE_DIR%\js
xcopy /e /d /y css\* %ARCHIVE_DIR%\css

rem ■ アーカイブ
cd %ARCHIVE_DIR%
PowerShell Compress-Archive -DestinationPath .\Mark-V_%MarkV_VER%_x64.zip -Path MarkV.exe,WebView2Loader.dll,js,css,readme.md,LISENCE.md,install_webview2.bat

rmdir /S /Q js
rmdir /S /Q css
del install_webview2.bat
del LISENCE.md
del MarkV.exe
del readme.md
del WebView2Loader.dll

echo cd %INIT_DIR% > download_src_archive.bat
echo git archive %COMMIT_HASH_MarkV% --format=zip --output=%ARCHIVE_DIR%\Mark-V_%MarkV_VER%_%DT%_src.zip >> download_src_archive.bat

start .
cd %INIT_DIR%

:END
cd %INIT_DIR%
