#!/bin/bash
currentdir=$(pwd)
whiptail --msgbox このプログラムはシステムにインストールされたソフトウェアを検出し自動でソースファイルをダウンロードするものです。GPLライセンスの関係上、自作ディストリビューションを配布するときに必要となるものです。 0 0
if (whiptail --title "確認" --yesno "パッケージの検出を行いますか？" 10 60)
then 

cd $USERNAME

if [ -d ./Debian_source_downloader ]
then
echo 作業用フォルダが存在します
else
echo 作業用フォルダを作成します
mkdir Debian_source_downloader
fi

cd Debian_source_downloader

pkgcount=($(dpkg -l | grep '^ii' | awk '{print "apt-get source " $2"=" $3 }'))
#> "get_source.txt"
count=0
for eachValue in ${pkgcount[@]}; do
    echo ${eachValue}
count=$((++count))
done
 if (whiptail --title "確認" --yesno "$count 個のパッケージを検出しました。ソースファイルを取得しますか？"  0 0)
then 

aptscript=($(dpkg -l | grep '^ii' | awk '{print "apt-get source " $2"=" $3 > "get_source.txt"}'))

for eachValue in ${aptscript[@]}; do
    echo ${eachValue}
done

while read line
do
 $line
done < ./get_source.txt
cd "$currentdir"
whiptail --msgbox ダウンロードが完了しました。 0 0

else
echo 終了します
fi



else
echo "終了します"
fi 

