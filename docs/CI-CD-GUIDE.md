# CI/CD 自动化测试配置指南

## 概述

本项目配置了完整的 CI/CD 自动化测试流程，使用 GitHub Actions 在每次推送和拉取请求时自动运行所有 skills 的测试。

## 文件结构

```
.github/
└── workflows/
    └── test-all.yml          # GitHub Actions 工作流配置

scripts/
├── test-all.sh              # 统一测试脚本
└── install-deps.sh          # 依赖安装脚本
```

## 功能特性

### GitHub Actions 工作流 (`.github/workflows/test-all.yml`)

- **触发条件**:
  - 推送到任何分支
  - 创建或更新拉取请求
  - 手动触发（workflow_dispatch）

- **测试矩阵**:
  - Python 3.8
  - Python 3.9
  - Python 3.10
  - Python 3.11

- **执行流程**:
  1. 检出代码
  2. 设置 Python 环境
  3. 安装依赖
  4. 运行所有测试
  5. 生成测试报告
  6. 上传测试结果
  7. 检查测试状态

### 统一测试脚本 (`scripts/test-all.sh`)

- 自动发现所有 skill 目录
- 逐个运行每个 skill 的 `test_skill.py`
- 收集并汇总测试结果
- 生成详细的测试日志
- 返回适当的退出码

### 依赖安装脚本 (`scripts/install-deps.sh`)

- 检查并安装 Python 环境
- 安装测试依赖（pytest, pytest-cov, pytest-html）
- 检查可选工具（Git, GitHub CLI）
- 验证安装结果

## 本地使用

### 1. 安装依赖

```bash
bash scripts/install-deps.sh
```

### 2. 运行所有测试

```bash
bash scripts/test-all.sh
```

### 3. 查看测试结果

测试完成后，结果会保存在 `test-results/` 目录：

```
test-results/
├── summary.txt              # 测试摘要
├── time-tracker-analyzer.log
├── branch-hygiene-checker.log
└── ...                      # 各 skill 的测试日志
```

## GitHub Actions 自动化

### 自动触发

当您推送代码或创建 PR 时，GitHub Actions 会自动：

1. 在 4 个 Python 版本上运行测试
2. 生成测试报告
3. 上传测试结果作为 artifacts
4. 在 PR 中显示测试状态

### 查看测试结果

1. 进入 GitHub 仓库
2. 点击 "Actions" 标签
3. 选择最新的工作流运行
4. 查看详细的测试日志和结果

### 下载测试结果

测试运行完成后，可以从 Actions 页面下载测试结果 artifacts，保留期为 30 天。

## 测试脚本规范

每个 skill 应包含一个 `test_skill.py` 文件，遵循以下规范：

### 基本结构

```python
#!/usr/bin/env python3
"""
测试脚本 - 验证 [skill-name] Skill 是否正常工作
"""

import subprocess
import sys
from pathlib import Path

def test_skill():
    """测试 Skill 功能"""
    print("🧪 正在测试 [skill-name] Skill...")
    print()

    # 测试步骤
    # 1. 检查文件存在性
    # 2. 验证 Python 语法
    # 3. 执行功能测试
    # 4. 验证输出

    # 返回 True（成功）或 False（失败）
    return True

if __name__ == '__main__':
    success = test_skill()
    sys.exit(0 if success else 1)
```

### 要求

- 返回 0 表示测试通过
- 返回非 0 表示测试失败
- 提供清晰的测试输出
- 包含必要的错误处理

## 故障排查

### 测试失败

1. 查看具体 skill 的日志：`test-results/<skill-name>.log`
2. 在本地手动运行失败的测试：`python skillsets/<skill-name>/test_skill.py`
3. 检查依赖是否完整：`bash scripts/install-deps.sh`

### GitHub Actions 失败

1. 检查 Actions 日志中的错误信息
2. 确认所有 Python 版本的测试结果
3. 验证测试脚本在本地是否通过

### 依赖问题

```bash
# 重新安装依赖
bash scripts/install-deps.sh

# 手动安装特定依赖
pip3 install <package-name>
```

## 扩展和自定义

### 添加新的 Python 版本

编辑 `.github/workflows/test-all.yml`：

```yaml
matrix:
  python-version: ['3.8', '3.9', '3.10', '3.11', '3.12']
```

### 修改测试触发条件

编辑 `.github/workflows/test-all.yml`：

```yaml
on:
  push:
    branches: ['main', 'develop']  # 只在特定分支触发
  pull_request:
    branches: ['main']
```

### 添加新的测试步骤

在 `scripts/test-all.sh` 中的 `test_skill()` 函数中添加自定义逻辑。

## 最佳实践

1. **保持测试独立**: 每个 skill 的测试应该独立运行，不依赖其他 skills
2. **快速反馈**: 测试应该快速完成，避免长时间的等待
3. **清晰输出**: 使用清晰的输出格式，便于调试
4. **错误处理**: 包含适当的错误处理和超时机制
5. **定期更新**: 定期更新依赖和测试脚本

## 相关文档

- [GitHub Actions 文档](https://docs.github.com/en/actions)
- [pytest 文档](https://docs.pytest.org/)
- [项目主 README](../README.md)

## 支持

如有问题或建议，请提交 Issue 或 PR。
