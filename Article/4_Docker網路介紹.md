# Docker網路介紹

### Docker提供幾種 Network Driver 可以使用:
* host(**常用**): 將主機的網段直接配給所指定的 container。
* bridge(**常用**): 提供一個虛擬網卡，使包含在其底下的 containers 可以互相連線。  
* none: 關閉該 container 的網路功能。
* overlay: 讓不同主機上的 Docker 裡的 containers 可以互相透過網路連通。
* ipvlan: 自行設定 IPv4 與 IPv6。
* macvlan: 自行設定 MAC。
* network plugins: 使用第三方工具。

```bash
# 顯示當前有哪些 network
docker network ls

# result
NETWORK ID          NAME                DRIVER              SCOPE
a1c7b6f80389        bridge              bridge              local
dc2f51e1056f        host                host                local
f28460d3a620        none                null                local
# dokcer 預設有 bridge 、 host 、 none 這三種 network ，且 name 與 driver 相同
```


### Host Driver 介紹:

```bash
docker container run --name webserver -d -p 9090:80 nginx
# --name 自定義 container 名字
# -d(--detach) 讓 container 在背景執行
# -p 9090:80 指定 host 的 9090 port 對應到該 cotainer 的 80 port

````

![img0](https://miro.medium.com/max/720/1*6xUdGsh3ALVtcfvG5Q7VdQ.png)

### Bridge Driver 介紹:

#### 使用 default bridge
```bash
# 啟動兩個 container 分別命名為 alpine1 與 alpine2
# 在啟動 cotainer 時，若不指定網路， docker 都會自動將其 container 分配到 default bridge 下
docker container run -dit --name alpine1 alpine ash
docker container run -dit --name alpine2 alpine ash

# 查看 bridge 的網路資訊(docker 的 default bridge 名字為 bridge) 
# docker network inspect network-name
docker network inspect bridge

# result
# bridge 分配到的 IP 為 172.17.0.1
# 在 bridge 中 alpine1 分配到的 IP 為 172.17.0.2
# 在 bridge 中 alpine2 分配到的 IP 為 172.17.0.3
[
    {
        "Name": "bridge", # docker network 的名字
        "Id": "a1c7b6f8038999f034b8e64ae66885fa8094a020a306ce4f5b5692d7230890b0",
        "Created": "2018-07-09T01:23:03.98371109Z",
        "Scope": "local",
        "Driver": "bridge", # 使用什麼 driver
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": null,
            "Config": [
                {
                    "Subnet": "172.17.0.0/16",
                    "Gateway": "172.17.0.1"
                }
            ]
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        # 該虛擬網卡中各 container 的網路資訊
        "Containers": {
            "16aa4a102b14de3e151cb5e19522925bb4e143034d5b2aac4ce239c79716b703": {
                "Name": "alpine2", # container 的名字
                "EndpointID": "4dc3947583ece828dd4371351501e7d0ba9fa149ac5373ea4ddb9466d333b85d",
                "MacAddress": "02:42:ac:11:00:03",
                "IPv4Address": "172.17.0.3/16", # alpine2 的 IP
                "IPv6Address": ""
            },
            "b75464efd30bf09e118450de2abaeb35549e732bac5805671f1e6e97cd970897": {
                "Name": "alpine1", # container 的名字
                "EndpointID": "ea0138a2c51812f3f142db086e1690f6696e36ff972c826727be30e3c8b8cb41",
                "MacAddress": "02:42:ac:11:00:02",
                "IPv4Address": "172.17.0.2/16", # alpine1 的 IP
                "IPv6Address": ""
            }
        },
        "Options": {
            "com.docker.network.bridge.default_bridge": "true",
            "com.docker.network.bridge.enable_icc": "true",
            "com.docker.network.bridge.enable_ip_masquerade": "true",
            "com.docker.network.bridge.host_binding_ipv4": "0.0.0.0",
            "com.docker.network.bridge.name": "docker0",
            "com.docker.network.driver.mtu": "1500"
        },
        "Labels": {}
    }
]

```

![img1](https://godleon.github.io/blog/images/docker/docker-bridge-network-1.png)

```bash
# 在 alpine1 中，開啟一個可以互動的 ash(linux shell)
docker exec -it alpine1 ash

# 測試由 alpine1 連線至外部
# -c 3 代表只 ping 3 次
ping -c 3 www.google.com

# result
PING www.google.com (216.58.200.228): 56 data bytes
64 bytes from 216.58.200.228: seq=0 ttl=54 time=2.112 ms
64 bytes from 216.58.200.228: seq=1 ttl=54 time=2.166 ms
64 bytes from 216.58.200.228: seq=2 ttl=54 time=2.417 ms

# 測試由 alpine1 連線至 alpine2(IP: 172.17.0.3)
ping -c 3 172.17.0.3
PING 172.17.0.3 (172.17.0.3): 56 data bytes
64 bytes from 172.17.0.3: seq=0 ttl=64 time=0.121 ms
64 bytes from 172.17.0.3: seq=1 ttl=64 time=0.071 ms
64 bytes from 172.17.0.3: seq=2 ttl=64 time=0.068 ms

```

#### 使用自訂的 bridge

```bash
# 建立自己的 network ，並指定 driver 為 bridge ，該 network 命名為 alpine-net
docker network create --driver bridge alpine-net

# 顯示當前有哪些 network
docker network ls

# result
NETWORK ID          NAME                DRIVER              SCOPE
2575acac8e78        alpine-net          bridge              local
a1c7b6f80389        bridge              bridge              local
dc2f51e1056f        host                host                local
f28460d3a620        none                null                local

# 查看 alpine-net 的網路資訊
docker network inspect alpine-net

# result
# alpine-net 分配到的 IP 為 172.18.0.1
[
    {
        "Name": "alpine-net",
        "Id": "2575acac8e781004cb0dc5c5b020c0252a4bc4cdf18dfc661fe3ffcde30fd0b2",
        "Created": "2018-07-09T03:05:05.505539609Z",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": {},
            "Config": [
                {
                    "Subnet": "172.18.0.0/16",
                    "Gateway": "172.18.0.1"
                }
            ]
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {},
        "Options": {},
        "Labels": {}
    }
]

# 分別建立四個 container 並分配 network
# alpine1 為 alpine-net
docker run -dit --name alpine1 --network alpine-net alpine ash

# alpine2 為 alpine-net
docker run -dit --name alpine2 --network alpine-net alpine ash

# alpine3 為 bridge
docker run -dit --name alpine3 alpine ash

# alpine4 為 alpine-net
docker run -dit --name alpine4 --network alpine-net alpine ash

# 額外為 alpine4 增加 bridge
docker network connect bridge alpine4

# 查看 bridge 的網路資訊
docker network inspect bridge

# result
# bridge 分配到的 IP 為 172.17.0.1
# 在 bridge 中 alpine3 分配到的 IP 為 172.17.0.2
# 在 bridge 中 alpine4 分配到的 IP 為 172.17.0.3
[
    {
        "Name": "bridge",
        "Id": "a1c7b6f8038999f034b8e64ae66885fa8094a020a306ce4f5b5692d7230890b0",
        "Created": "2018-07-09T01:23:03.98371109Z",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": null,
            "Config": [
                {
                    "Subnet": "172.17.0.0/16",
                    "Gateway": "172.17.0.1"
                }
            ]
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {
            "3c602d26fcdcc8c0145d4d2d159b20b5b760c1b74393c7b5f7be060f4f8822ac": {
                "Name": "alpine3",
                "EndpointID": "7bd6ae1d8a28a554f57f9937953716cc5f62ea8bd669fc744d3aeffacf05f3c1",
                "MacAddress": "02:42:ac:11:00:02",
                "IPv4Address": "172.17.0.2/16",
                "IPv6Address": ""
            },
            "83133e6103d63513116e0fb791efea64b016424ca73357ba3fed41b7ea92df95": {
                "Name": "alpine4",
                "EndpointID": "2bb63005cf4bcb037d644ab230023e65e8ee9e00cf4d98b3fcf9526c14790492",
                "MacAddress": "02:42:ac:11:00:03",
                "IPv4Address": "172.17.0.3/16",
                "IPv6Address": ""
            }
        },
        "Options": {
            "com.docker.network.bridge.default_bridge": "true",
            "com.docker.network.bridge.enable_icc": "true",
            "com.docker.network.bridge.enable_ip_masquerade": "true",
            "com.docker.network.bridge.host_binding_ipv4": "0.0.0.0",
            "com.docker.network.bridge.name": "docker0",
            "com.docker.network.driver.mtu": "1500"
        },
        "Labels": {}
    }
]


# 查看 alpine-net 的網路資訊
docker network inspect alpine-net

# result
# alpine-net 分配到的 IP 為 172.18.0.1
# 在 alpine-net 中 alpine1 分配到的 IP 為 172.18.0.2
# 在 alpine-net 中 alpine2 分配到的 IP 為 172.18.0.3
# 在 alpine-net 中 alpine4 分配到的 IP 為 172.18.0.4
[
    {
        "Name": "alpine-net",
        "Id": "2575acac8e781004cb0dc5c5b020c0252a4bc4cdf18dfc661fe3ffcde30fd0b2",
        "Created": "2018-07-09T03:05:05.505539609Z",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": {},
            "Config": [
                {
                    "Subnet": "172.18.0.0/16",
                    "Gateway": "172.18.0.1"
                }
            ]
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {
            "010ba5c3e71a723f8c980bb00bb87c97bc41b073163415705006ce5d0071e97c": {
                "Name": "alpine1",
                "EndpointID": "f1357dd263dea947c4cd203fd8031be40fae4840f6994dd5e11d6790a038569c",
                "MacAddress": "02:42:ac:12:00:02",
                "IPv4Address": "172.18.0.2/16",
                "IPv6Address": ""
            },
            "83133e6103d63513116e0fb791efea64b016424ca73357ba3fed41b7ea92df95": {
                "Name": "alpine4",
                "EndpointID": "cf6bb33270eca6d40d4d953cea49302d210bc8ba995f04cdcf138344d5378d2f",
                "MacAddress": "02:42:ac:12:00:04",
                "IPv4Address": "172.18.0.4/16",
                "IPv6Address": ""
            },
            "aecb66274c3b3ec9109ff4eaa582ad4708ed871428d3b4894f9d04330aabcbc4": {
                "Name": "alpine2",
                "EndpointID": "28a237e9fe55f133459140c9e5265470e34baeec43c2c0f6c32d5d539b694403",
                "MacAddress": "02:42:ac:12:00:03",
                "IPv4Address": "172.18.0.3/16",
                "IPv6Address": ""
            }
        },
        "Options": {},
        "Labels": {}
    }
]

```

![img2](https://godleon.github.io/blog/images/docker/docker-bridge-network-custom.png)


```bash
# 在 alpine1 中，開啟一個可以互動的 ash(linux shell)
docker exec -it alpine1 ash

# 測試由 alpine1 連線至外部
ping -c 2 www.google.com

# result
PING www.google.com (216.58.200.228): 56 data bytes
64 bytes from 216.58.200.228: seq=0 ttl=54 time=2.112 ms
64 bytes from 216.58.200.228: seq=1 ttl=54 time=2.166 ms

# 測試由 alpine1 連線至 alpine2(IP: 172.18.0.3)
ping -c 2 172.18.0.3
PING 172.18.0.3 (172.18.0.3): 56 data bytes
64 bytes from 172.18.0.3: seq=0 ttl=64 time=0.121 ms
64 bytes from 172.18.0.3: seq=1 ttl=64 time=0.071 ms

# 測試由 alpine1 連線至 alpine2(IP: 172.18.0.3)
# 由於 alpine-net 為自訂的 network ， docker 可以透過 container name 來做連線
ping -c 2 alpine2
PING alpine2 (172.18.0.3): 56 data bytes
64 bytes from 172.18.0.3: seq=0 ttl=64 time=0.095 ms
64 bytes from 172.18.0.3: seq=1 ttl=64 time=0.076 ms

# 測試由 alpine1 連線至 alpine4(IP: 172.18.0.4)
ping -c 2 alpine4
PING alpine4 (172.18.0.4): 56 data bytes
64 bytes from 172.18.0.4: seq=0 ttl=64 time=0.145 ms
64 bytes from 172.18.0.4: seq=1 ttl=64 time=0.102 ms

# 測試由 alpine1 連線至 alpine3(IP: 172.17.0.2)
# 由於 alpine4 接了兩個 network ，所以 bridge 與 alpine-net 可以透過 alpine4 來讓彼此的 container 互相連通
ping -c 2 172.17.0.2
PING 172.17.0.2 (172.17.0.2): 56 data bytes
64 bytes from 172.17.0.2: seq=0 ttl=64 time=0.145 ms
64 bytes from 172.17.0.2: seq=1 ttl=64 time=0.102 ms

```

reference:
1. https://docs.docker.com/network/
2. https://docs.docker.com/network/network-tutorial-standalone/
3. https://azole.medium.com/docker-container-%E5%9F%BA%E7%A4%8E%E5%85%A5%E9%96%80%E7%AF%87-2-c14d8f852ae4
4. https://godleon.github.io/blog/Docker/docker-network-bridge/
