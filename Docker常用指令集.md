#### 執行 container
docker run -d -p [主機port]:[container port] -v [主機資料夾]:[container 資料夾] --name [自己想命名的 container 名稱] [image name]:[image tage]

-d: 表示該 container 於背景執行。

-p: 指定 host port 對應到哪個 container port

-v: 指定 host 資料夾 對應到哪個 container 資料夾

--name: 自定義該 container 的成稱。



#### 進入 container 的 bash
docker exec -it [container id or name] /bin/bash (*/bin/bash 依照 container 裡頭的 linux 不同而不同)

-it: 分別表不同意義，但一般都會一起使用，t 表示開啟一個 terminal，i 表示可以互動。



#### 查看 container 的資訊
docker container inspect [container id or name]



#### 查看 image 的資訊
docker image inspect [image id or name]



#### network
docker network list #查看全部的網卡

docker network inspect [network name or id] #查看指定網卡的詳細資訊

docker network create -d [driver] networkName #建立新的網卡，d表示指定 driver(預設為: bridge)

docker network rm [network name or id] #刪除指定的網卡



#### 查看 volume 的資訊
docker volume inspect [volume name]

