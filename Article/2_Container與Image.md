# Container 與 Image  

- Container:
    - Container 是 Docker 最重要的核心， Docker 透過 Container 技術來建立一個獨立且隔離的空間，在這個空間中可以安裝任何的程式，類似於一臺新的虛擬主機。
    - Container 是 Linux 系統的一個技術(利用 namespace 與 cgroup 來達成隔離與資源限制)，而 Docoker 就是基於該技術，去利用一套快速且方便的方法來建立 Container ，所以執行 Docker 一定要在 Linux 系統下才可以運作。
    - 由於 Container 就是一臺虛擬主機，所以可以在裡頭安裝各式各樣的程式，例如安裝 Ubuntu 、 Tomcat 與 MySQL 在同一個 Container 裡，或是 Ubuntu 、 Tomcat 與 MySQL 分別安裝在不同的 Container 中，透過 Container 的虛擬網路進行相互溝通。
    - 一個 Container 就是一臺虛擬主機，所以當 Container 被刪除了，其內部所有的資料就都會消失。


```bash
# 查看當前有哪些 Container
docker container ls

# 由 image 生成一個 Container 並啟動
docker container run {image name or id}

# 啟動已停止的 Container
docker container start {container name or id}

# 停止 Container
docker container stop {container name or id}

# 重新啟動 Container
docker container restart {container name or id}

# 刪除已停止的 Container
docker container rm {container name or id}
```

![Container](https://www.docker.com/wp-content/uploads/2021/11/docker-containerized-appliction-blue-border_2.png)

- Image:
    - Image 是產生 Container 的來源，以物件導向的觀念來看， Image 就是 Class ， 而 Container 就是 Object。
    - Image 是一個**唯讀**的模板， Image 只能被拿來使用，不能被編輯，若要更動 Image 的內容，只能透過新建一個。

```bash
# 查看當前有哪些 Image
docker image ls

# 由 image 生成一個 Container 並啟動
docker container run {image name or id}

# 刪除 Image
docker image rm {image name or id}
```

![Image](https://miro.medium.com/max/1400/1*NMol4JlirTLiyjfHkuHMGw.png)

![Image and Container - 1](https://miro.medium.com/max/1400/1*l96m5V6LGI1XRM9mM3zk8Q.png)

![Image and Container - 2](https://miro.medium.com/max/1400/1*1z_AR2OsoVoKfbvA3nCx6Q.png)

Reference:
1. https://www.docker.com/resources/what-container/
2. https://azole.medium.com/docker-container-%E5%9F%BA%E7%A4%8E%E5%85%A5%E9%96%80%E7%AF%87-1-3cb8876f2b14
