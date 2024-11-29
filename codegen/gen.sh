#!/bin/bash

# Step 1: Check configuration files
read -p "请核对代码配置文件 xx,xxx，（y/n）: " check_config
if [ "$check_config" != "y" ]; then
    echo "请先核对配置文件。"
    exit 1
fi

# Step 2: Generate DAO code
read -p "是否生成dao代码，（y/n）: " generate_dao
if [ "$generate_dao" == "y" ]; then
    echo "生成DAO代码..."
    # 在这里添加生成DAO代码的命令
else
    echo "跳过生成DAO代码。"
fi

# Step 3: Generate controller and logic code
read -p "是否生成 controller 和 logic 代码，（y/n）: " generate_controller_logic
if [ "$generate_controller_logic" == "y" ]; then
    echo "生成controller和logic代码..."
    mkdir -p backup/internal/controller/saas/
    mkdir -p backup/internal/logic
    mkdir -p backup/api
    # 在这里添加生成controller和logic代码的命令
else
    echo "跳过生成controller和logic代码。"
fi

# Step 4: Manual routing
echo "请手动在路由添加对应的路由，感谢使用。"

exit 0