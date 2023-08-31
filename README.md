# documentation-deploy

用于文档自动部署，submodule链接到所有文档。

## 添加文档仓库submodule

```bash
git submodule add -b gh-pages <remote-url> <local-path>
```

例如
    
```bash
git submodule add -b gh-pages git@github.com:Peiyang-Aeromodelling-Association/visual_framework.git visual_framework
```

## 拉取所有文档并更新到最新commit

```bash
git submodule foreach git pull --force origin gh-pages:gh-pages
```