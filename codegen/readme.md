1. 执行命令

```

gf gen dao
```

```
modelname=$(gomplate -d config=./config.yaml -i '{{ (ds "config").modelname }}')
gomplate -d config=./config.yaml -f _controller.template -o "${modelname}_controller.go"
gomplate -d config=./config.yaml -f _logic.template -o "${modelname}_logic.go"
gomplate -d config=./config.yaml -f _v2.template -o "${modelname}_v2.go"
```

```
curl 127.0.0.1:8000//manager-api/alertRule/list
```