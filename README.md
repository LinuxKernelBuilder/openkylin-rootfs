# 介绍

使用 mmdebstrap 工具制作根文件系统，mmdebstrap 是一个工具，允许你选择性地包含或排除某些软件包，这样可以创建更小的、定制化的根文件系统。这个根文件系统可以被 Docker 和 WSL 使用。

# 使用

```bash
bash build.sh
```

支持多加个架构 amd64 arm64 riscv64 架构。
