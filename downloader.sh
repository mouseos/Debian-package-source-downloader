#!/bin/bash

ex1() {
  echo -e "$1"
  exit 1
}

whiptail --title "確認" --yesno "$(dpkg -l | grep -c '^ii' | cut -d " " -f1)個のパッケージを検出しました｡\nソースファイルを取得しますか？" 0 0 || ex1 "処理を中止しました｡"

clear

mkdir -p ./package_sources/ && cd ./package_sources/
dpkg -l | grep '^ii' | awk '{print $2"="$3 > "./sources.list.txt"}'

count=0
while read -r line; do
  count=$((++count))
  echo -e "\n\n${count}個目：$line\n"
  apt-get source "$line" || ex1 "\n例外なエラーが発生しました：$?"
done < ./sources.list.txt

clear
whiptail --msgbox "\nダウンロードが完了しました｡\n" 0 0
exit 0
