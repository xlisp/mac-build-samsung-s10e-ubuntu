## 1 构建镜像

在项目目录运行：

```bash
cd /Users/xlisp/Desktop/ && git clone https://gitlab.com/ubports/porting/community-ports/android10/samsung-galaxy-s10/samsung-exynos9820

cp  https://github.com/xlisp/mac-build-samsung-s10e-ubuntu Dockerfile .

mkdir bd out

cp deviceinfo-beyond0lte deviceinfo # or other deviceinfo-* file


```

```bash

cd /Users/xlisp/Desktop/samsung-exynos9820
docker build -t exynos9820-builder .
```

---

## 2 启动容器并挂载源码

运行容器，把你的项目目录挂载到 `/work`：

```bash
docker run --rm -it \
  -v /Users/xlisp/Desktop/samsung-exynos9820:/work \
  exynos9820-builder
```

进入容器后，路径 `/work` 就对应你本机的 `samsung-exynos9820` 项目。

---

## 3 容器内编译

在容器里：

```bash
cd /work

# 如果 build.sh 脚本里用到 nproc，容器里是有的
# 如果脚本下载了 linux-x86/clang 工具链，直接用
# 否则你可以 export CC=clang 来用容器内的 clang

## bd/downloads/kernel-samsung-exynos9820/net/netfilter/Makefile # 这个编译报错，无法解决，就注释掉了 => make[3]: *** No rule to make target 'net/netfilter/xt_TCPMSS.o', needed by 'net/netfilter/built-in.o'.  Stop.
## 137:### ----- obj-$(CONFIG_NETFILTER_XT_TARGET_TCPMSS) += xt_TCPMSS.o


root@0279e7dd6973:/work# ./build.sh -b bd

root@0279e7dd6973:/work# ./build/prepare-fake-ota.sh out/device_beyond0lte.tar.xz ota

```

编译生成的 `out/` 或 `bd/` 文件夹会直接出现在你 Mac 上的 `/Users/xlisp/Desktop/samsung-exynos9820` 下，因为 volume 已经挂载好了。

---

