1. 若有多個 yaml  檔，docker compose 抓誰
      - 預設抓 docker-compose.yml ，若要抓特定檔需透過 -f 指定
      - docker compose -f hello.yml up

2. docker compose up & down 每次會新增與刪除網卡，導致IP被卡(docker 每次新建網卡IP會遞增 ex: 第一次:172.18.0.1, 第二次:172.19.0.1, 第三次:172.20.0.1 ......)
      - 在 docker-compose.yml 寫死 IP 設定

```ymal
      networks:
            # 建立一張網卡且命名為 idg_network
            my_network:
            driver: bridge
            ipam:
                  driver: default
                  # 設定 IP 相關參數
                  config:
                        - subnet: 172.18.0.0/16
                        gateway: 172.18.0.1
```
