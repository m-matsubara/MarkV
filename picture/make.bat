rem アイコン用画像ファイル生成

set INKSCAPE="C:\Program Files\Inkscape\bin\Inkscape.com"
set SIZE=40

mkdir PNGs

%INKSCAPE% -h %SIZE% -o "PNGs\fileopen.png"			"SVGs\fileopen.svg"
%INKSCAPE% -h %SIZE% -o "PNGs\reload.png"			"SVGs\reload.svg"
%INKSCAPE% -h %SIZE% -o "PNGs\left.png"				"SVGs\left.svg"
%INKSCAPE% -h %SIZE% -o "PNGs\right.png"			"SVGs\right.svg"
%INKSCAPE% -h %SIZE% -o "PNGs\light-right.png"		"SVGs\light-right.svg"
%INKSCAPE% -h %SIZE% -o "PNGs\print.png"			"SVGs\print.svg"

%INKSCAPE% -h 32  -o "PNGs\MarkV_Icon.png"			"SVGs\MarkV_Icon.svg"
%INKSCAPE% -h 44  -o "PNGs\MarkV_Icon_44.png"		"SVGs\MarkV_Icon.svg"
%INKSCAPE% -h 150 -o "PNGs\MarkV_Icon_150.png"		"SVGs\MarkV_Icon.svg"

wsl /bin/sh make_bmp.sh
