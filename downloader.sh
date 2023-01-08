#!/bin/bash

function exitScript() {
  echo "処理を中止しました"
  exit 1
}

whiptail --msgbox "このプログラムはシステムにインストールされたソフトウェアを検出し自動でソースファイルをダウンロードするものです。\nGPLライセンスの関係上、自作ディストリビューションを配布するときに必要となるものです。" 0 0
whiptail --title "確認" --yesno "パッケージの検出を行いますか？" 0 0
if [ $? != 0 ]; then exitScript; fi

mkdir -p ./package_sources/
cd ./package_sources/
echo -n > sources.list.txt

pkgCount=$(dpkg -l | grep '^ii' | awk '{print "apt-get source " $2"="$3}')

count=0
for eachValue in ${pkgCount[@]}; do
  count=$((++count))
done

clear
whiptail --title "確認" --yesno "${count}個のパッケージを検出しました。\nソースファイルを取得しますか？" 0 0
if [ $? != 0 ]; then exitScript; fi
aptScript=$(dpkg -l | grep '^ii' | awk '{print $2"="$3 > "./sources.list.txt"}')

count=0
while read line; do
  count=$((++count))
  echo -e "\n${count}個目です\n"
  apt-get source $line
done < ./sources.list.txt

whiptail --msgbox "ダウンロードが完了しました。" 0 0
clear
exit 0
