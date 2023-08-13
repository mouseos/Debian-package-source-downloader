# Debian Package-source Downloader

Debianにインストール済みのソフトウェアのソースコードを入手するためのスクリプトです。  
リマスターツールで作成したカスタムLinuxを配布する際に発生するGPL違反を回避できます。

### 注意点
`apt-get source`を使用するので､  
`sources.list`に`deb-src`を含める必要が有ります｡  
```
Reading package lists... Done
E: You must put some 'deb-src' URIs in your sources.list
```
