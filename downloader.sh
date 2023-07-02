#!/bin/bash

if !(whiptail --title "確認" --yesno "$(dpkg -l | grep '^ii' | wc -l | cut -d " " -f1)個のパッケージを検出しました｡\nソースファイルを取得しますか？" 0 0); then
  echo "処理を中止しました｡"
  exit 1
fi

clear

mkdir -p ./package_sources/
cd ./package_sources/
dpkg -l | grep '^ii' | awk '{print $2"="$3 > "./sources.list.txt"}'

count=0
while read line; do
  count=$((++count))
  echo -e "\n\n${count}個目：$line\n"
  apt-get source $line || echo -e "\n例外なエラーが発生しました：$?"
done < ./sources.list.txt

clear
whiptail --msgbox "\nダウンロードが完了しました｡\n" 0 0
cd - >&2 /dev/null
exit 0
