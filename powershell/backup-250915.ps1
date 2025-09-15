try{if(Get-Command scoop){}} catch {iex (new-object net.webclient).downloadstring('https://get.scoop.sh')}
scoop install git
scoop bucket add main https://gitee.com/scoop-bucket/main.git
scoop bucket add extras https://gitee.com/scoop-bucket/extras.git
scoop bucket add versions https://gitee.com/scoop-bucket/versions.git
scoop bucket add nerd-fonts https://gitee.com/scoop-bucket/nerd-fonts.git
scoop bucket add java https://gitee.com/scoop-bucket/java.git
scoop bucket add apps https://github.com/kkzzhizhou/scoop-apps.git
scoop bucket add backit https://gitee.com/scoop-bucket/backit.git
scoop bucket add diklios https://github.com/diklios5768/diklios-scoop-bucket.git
scoop bucket add dorado https://gitee.com/scoop-bucket/dorado.git
scoop install main/7zip
scoop install extras/alacritty
scoop install main/aria2
scoop install extras/autohotkey
scoop install main/bat
scoop install main/cacert
scoop install main/clink
scoop install main/curl
scoop install extras/dbeaver
scoop install apps/dingtalk
scoop install apps/dismplusplus
scoop install extras/dnsjumper
scoop install extras/draw.io
scoop install apps/evcapture
scoop install main/ffmpeg
scoop install apps/fiddler
scoop install extras/filezilla
scoop install extras/firefox
scoop install extras/folo
scoop install main/fzf
scoop install main/gawk
scoop install main/gcc
scoop install main/git
scoop install apps/goldendict
scoop install main/gzip
scoop install extras/heynote
scoop install nerd-fonts/JetBrainsMono-NF
scoop install nerd-fonts/JetBrainsMono-NF-Mono
scoop install nerd-fonts/jetbrainsmono-nf-propo
scoop install apps/jmeter
scoop install extras/joplin
scoop install main/less
scoop install apps/lua53
scoop install extras/mobaxterm
scoop install apps/mongodb-compass
scoop install main/msys2
scoop install main/mysql-workbench
scoop install extras/neovide
scoop install main/neovim
scoop install extras/neovim-qt
scoop install apps/neteasemusic
scoop install main/nodejs
scoop install apps/notepad--
scoop install main/nvm
scoop install extras/obsidian
scoop install main/oh-my-posh
scoop install apps/openjdk17
scoop install extras/posh-git
scoop install apps/postman
scoop install extras/potplayer
scoop install main/ripgrep
scoop install extras/rufus
scoop install diklios/scoop-backup
scoop install apps/scoop-completion
scoop install extras/snipaste
scoop install apps/sqlitestudio
scoop install versions/steam
scoop install main/sudo
scoop install apps/switchhosts
scoop install extras/tabby
scoop install extras/vcredist2022
scoop install extras/ventoy
scoop install apps/vim-nightly
scoop install apps/vncviewer
scoop install main/wget
scoop install apps/wireshark
scoop install versions/xmind8
scoop install main/yarn
scoop install main/yazi
scoop install apps/zeal
scoop install extras/zed
scoop install main/zip
scoop install extras/zotero

