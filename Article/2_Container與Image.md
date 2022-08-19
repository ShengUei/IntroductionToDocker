# Container 與 Image  

- Container:
    - Container 是 Docker 最重要的核心， Docker 透過 Container 技術來建立一個獨立且隔離的空間，在這個空間中可以安裝任何的程式，類似於一臺新的虛擬主機。
    - Container 是 Linux 系統的一個技術(利用 namespace 與 cgroup 來達成隔離與資源限制)，而 Docoker 就是基於該技術，去利用一套快速且方便的方法來建立 Container ，所以執行 Docker 一定要在 Linux 系統下才可以運作。


![Container](https://www.researchgate.net/profile/Claus-Pahl/publication/333235708/figure/fig1/AS:760874507722754@1558418027301/Docker-container-architecture.ppm)
(source:https://www.researchgate.net/figure/Docker-container-architecture_fig1_333235708)


Reference:
1. https://azole.medium.com/docker-container-%E5%9F%BA%E7%A4%8E%E5%85%A5%E9%96%80%E7%AF%87-1-3cb8876f2b14
