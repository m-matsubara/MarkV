#!/bin/bash

# png file to bmp file.

mkdir BMPs
cp -r PNGs/* BMPs

dir_path="BMPs/*"
dirs=`find $dir_path -maxdepth 10 -type f -name *.png`

for dir in $dirs;
do
    echo $dir ${dir%\.png}.bmp
    # ここから実行処理を記述
    # convert $dir -transparent "#FFFFFF" ${dir%\.png}.bmp
    # convert $dir \( +clone -fill "#123456"  -colorize 100% \) +swap  -compose  over  -composite ${dir%\.png}.bmp

    # 透明色を WHITE に変換し、BMP v3 として保存する。
    # （左下ドットを透明色として扱う）
    convert $dir -background WHITE -flatten -define bmp:format=bmp3 ${dir%\.png}.bmp

    # pngファイルは削除
    rm $dir
done

cd ..
