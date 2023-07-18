# 介绍

使用 Multistrap 工具制作根文件系统，Multistrap是一个工具，可以用来构建一个完整的、可启动的、根文件系统。这个根文件系统可以被 Docker 和 WSL 使用。


# 使用

yangtze.multistrap 是配置文件。

```bash
bash build.sh
sudo tar -cf yangtze-rootfs.tar -C /yangtze-rootfs .
```

# 声明

参考 deepin-docker 制作
[deepin-docker](https://github.com/BLumia/deepin-docker)
