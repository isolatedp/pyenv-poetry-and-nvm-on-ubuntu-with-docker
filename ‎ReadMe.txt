2024/11/25
Kevin Cheng

* Docker Compose 說明
  1. Pyenv Poetry and NVM on Ubuntu 
  2. 設定 Ubuntu 系統語言與時區，語言指定為 en_US.UTF-8 時區指定為 Asia/Taipei
  3. 獨立 Docker 網路容器指定固定 IP ，如需對宿主機與網路內部開放連接埠，則需改動 docker-compose.yaml。若無獨立網路，請參考下方
    網路管理說明。
  4. Poetry 設定 
    (1) 虛擬環境建立於專案資料夾下
    (2) 將所有需要的檔案複製到虛擬環境中。
  5. 運行指令 docker compose up -d 

* 基底 image 版本、Python 與 Nodejs 版本選用原則
  1. 版本選擇皆以當前(文件撰寫日期)最新的長期規劃版本
  2. Linux 系統為 Ubuntu 依當前 LTS 版本採用 ubuntu 24.04.1 (Noble Numbat)
  3. 綜上所述，基底 image 採用 ubuntu:24.04
  4. Python 依官網說明 bugfix 無所謂長期規劃版本，改採用最新穩定版(bugfix) Python 3.13
  5. Nodejs 依當前 LTS 版本採用 Nodejs v22

* 參考資料與 image 來源
  1. ubuntu: https://releases.ubuntu.com/
  2. docker hub: docker-image: https://hub.docker.com/layers/library/ubuntu/24.04/images/sha256-f470988096c4d77efac9740a1b6700823681af518a17fad30111430b95dfbffa?context=explore
  3. python: https://devguide.python.org/versions/#versions
  4. nodejs: https://nodejs.org/en

* Docker 網路管理
  1. 檢視所有自訂 Docker 網路
    docker network ls --filter type=custom
  2. 建立專案網路，並命名為 dockerNet
    docker network create --driver bridge --subnet "172.18.0.0/16" --gateway "172.18.0.1" dockerNet
  3. 檢視指定網路下，IP 指派給容器的狀況
    docker network inspect dockerNet
  4. 移除指定 Docker 網路
    docker network rm dockerNet
