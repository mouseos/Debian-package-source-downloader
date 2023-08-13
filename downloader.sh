#!/bin/bash

abort() {
  echo -e "$1"
  if [ "$2" ]; then
    exit "$2"
  fi
}

whiptail --title "確認" --yesno "$(dpkg -l | grep -c '^ii')個のパッケージを検出しました｡\nソースファイルを取得しますか？" 0 0 || abort "処理を中止しました｡" 1

clear

mkdir -p package_sources && cd package_sources || abort "\nダウンロードディレクトリの作成に失敗しました｡" 1
dpkg -l | grep '^ii' | awk '{print $2"="$3 > "./sources.list.txt"}'

count=0
while read -r line; do
  count=$((++count))
  echo -e "\n\n${count}個目：$line\n"
  apt-get source "$line" || abort "\n例外なエラーが発生しました：$?"
done < ./sources.list.txt

clear
abort "\nダウンロードが完了しました｡\n" 0
