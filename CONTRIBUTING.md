# 贡献指南

感谢您对 bingo-devops-skills 项目的关注！我们欢迎各种形式的贡献。

## 目录

- [行为准则](#行为准则)
- [如何贡献](#如何贡献)
- [开发环境设置](#开发环境设置)
- [添加新 Skill](#添加新-skill)
- [代码风格要求](#代码风格要求)
- [提交流程](#提交流程)
- [测试要求](#测试要求)
- [问题报告](#问题报告)

## 行为准则

- 尊重所有贡献者
- 建设性讨论，专注于解决问题
- 接受不同观点和经验水平
- 优雅地接受建设性批评

## 如何贡献

### 贡献类型

我们欢迎以下类型的贡献：

- 添加新的 DevOps Skill
- 改进现有 Skill 的功能
- 修复 Bug
- 完善文档
- 优化性能
- 报告问题
- 提出改进建议

### 开发环境设置

#### 1. 克隆仓库

```bash
git clone https://github.com/your-username/bingo-devops-skills.git
cd bingo-devops-skills
```

#### 2. 安装依赖

项目主要使用 Python 开发，推荐使用虚拟环境：

```bash
# 创建虚拟环境
python -m venv venv

# 激活虚拟环境
# macOS/Linux:
source venv/bin/activate
# Windows:
venv\Scripts\activate

# 安装基础依赖（如果有 requirements.txt）
pip install -r requirements.txt
```

#### 3. 运行测试

```bash
# 测试所有 skills
bash scripts/test-all.sh

# 或测试单个 skill
python skillsets/github-repo-analyzer/test_skill.py
```

## 添加新 Skill

### Skill 标准结构

每个 Skill 必须包含以下文件：

```
skillsets/
└── skill-name/
    ├── SKILL.md          # YAML frontmatter + 内容
    ├── impl.py           # Python 实现
    ├── test_skill.py     # 测试脚本
    └── README.md         # 使用文档
```

### 步骤 1: 创建目录

```bash
mkdir -p skillsets/your-skill-name
cd skillsets/your-skill-name
```

### 步骤 2: 创建 SKILL.md

SKILL.md 必须以 YAML frontmatter 开头：

```yaml
---
name: "your-skill-name"
description: "Use when [具体的触发条件和症状，以 Use when 开头，第三人称]"
---
```

**description 规范：**
- 必须以 "Use when" 开头
- 使用第三人称
- 不要总结实现流程
- 明确触发条件和症状

**示例：**

```markdown
---
name: "github-repo-analyzer"
description: "Use when user asks to analyze GitHub repositories, check fork status, get repository cleanup recommendations, view repository statistics, or identify unused repos"
---

# GitHub Repository Analyzer

## Overview
[简要描述 Skill 的功能]

## When to Invoke
[触发场景列表]

## What It Does
[功能详情]
```

### 步骤 3: 实现 impl.py

impl.py 应遵循以下规范：

```python
#!/usr/bin/env python3
"""
Skill 简要描述
"""

import subprocess
import json
import sys
from pathlib import Path

def main():
    """主函数"""
    try:
        # 1. 获取数据
        data = fetch_data()

        # 2. 处理数据
        result = process_data(data)

        # 3. 生成报告
        report = generate_report(result)

        # 4. 保存报告
        save_report(report)

        print(f"✅ 报告已生成")
        return 0

    except Exception as e:
        print(f"❌ 错误: {e}")
        return 1

if __name__ == '__main__':
    sys.exit(main())
```

**代码风格要求：**
- 使用 UTF-8 编码
- 中文友好的输出和提示信息（使用 emoji 增强可读性）
- 完整的错误处理
- 函数和类添加 docstring
- 遵循 PEP 8 规范
- 使用类型注解（可选）

### 步骤 4: 编写 test_skill.py

测试脚本应验证：

```python
#!/usr/bin/env python3
"""测试脚本 - 验证 skill 是否正常工作"""

import subprocess
import sys
from pathlib import Path

def test_skill():
    """测试 Skill 功能"""
    print("🧪 正在测试 xxx Skill...")

    # 测试 1: 检查文件存在
    skill_dir = Path(__file__).parent
    required_files = ['SKILL.md', 'impl.py', 'README.md']

    for file in required_files:
        if not (skill_dir / file).exists():
            print(f"❌ 缺少文件: {file}")
            return False

    # 测试 2: 验证 YAML frontmatter
    with open(skill_dir / 'SKILL.md', 'r', encoding='utf-8') as f:
        content = f.read()
        if not content.startswith('---'):
            print("❌ SKILL.md 缺少 YAML frontmatter")
            return False

    # 测试 3: 执行脚本（如果适用）
    # result = subprocess.run(['python', 'impl.py'], capture_output=True)
    # if result.returncode != 0:
    #     print(f"❌ 脚本执行失败: {result.stderr.decode()}")
    #     return False

    print("✅ 所有测试通过")
    return True

if __name__ == '__main__':
    success = test_skill()
    sys.exit(0 if success else 1)
```

### 步骤 5: 编写 README.md

README.md 应包含：

```markdown
# Skill Name

## 功能描述

[简要描述这个 Skill 的功能]

## 使用场景

- 场景 1
- 场景 2

## 使用方法

```bash
cd skillsets/your-skill-name
python impl.py
```

## 输出

[描述输出文件和格式]

## 依赖

- Python 3.7+
- 其他依赖...
```

## 代码风格要求

### Python 代码

- 遵循 [PEP 8](https://peps.python.org/pep-0008/)
- 使用 4 空格缩进
- 行长度不超过 100 字符
- 使用 f-string 格式化字符串
- 添加类型注解（推荐）

### Markdown 文档

- 使用中文标点
- 标题层级清晰
- 代码块指定语言
- 列表使用连字符 `-`

### 命名规范

- 文件名：小写字母，连字符分隔（如 `my-skill-name`）
- Python 变量/函数：蛇形命名（如 `my_function`）
- Python 类：帕斯卡命名（如 `MyClass`）
- 常量：大写下划线（如 `MAX_SIZE`）

## 提交流程

### 1. Fork 仓库

点击右上角 Fork 按钮

### 2. 创建分支

```bash
git checkout -b feature/your-skill-name
# 或
git checkout -b fix/issue-description
```

分支命名规范：
- `feature/skill-name` - 新功能
- `fix/bug-description` - Bug 修复
- `docs/update-description` - 文档更新
- `refactor/component-name` - 重构

### 3. 提交更改

```bash
git add .
git commit -m "feat: add new skill for analyzing xxx"
```

提交信息规范（约定式提交）：
- `feat:` - 新功能
- `fix:` - Bug 修复
- `docs:` - 文档更新
- `style:` - 代码格式（不影响功能）
- `refactor:` - 重构
- `test:` - 测试相关
- `chore:` - 构建/工具相关

### 4. 推送到 Fork

```bash
git push origin feature/your-skill-name
```

### 5. 创建 Pull Request

- 访问原仓库
- 点击 "New Pull Request"
- 填写 PR 描述模板
- 等待审查

## 测试要求

### 测试覆盖

每个新 Skill 必须包含：

1. **文件完整性测试**
   - 验证所有必需文件存在

2. **格式验证测试**
   - 验证 SKILL.md 的 YAML frontmatter
   - 验证 Python 语法正确性

3. **功能测试**
   - 测试主要功能路径
   - 测试错误处理

### 运行测试

```bash
# 测试单个 skill
python skillsets/your-skill/test_skill.py

# 测试所有 skills
bash scripts/test-all.sh
```

### 测试通过标准

- 所有测试脚本返回 0
- 输出格式符合规范
- 错误处理正常工作
- 中文输出正确显示

## 问题报告

### 报告 Bug

使用 GitHub Issues，包含：

- 清晰的标题
- 复现步骤
- 期望行为
- 实际行为
- 环境信息（操作系统、Python 版本等）
- 错误日志（如果适用）

### 功能建议

- 描述建议的功能
- 说明使用场景
- 提供可能的实现思路（可选）

## 审查流程

1. 提交 PR 后，维护者会在 7 天内进行初步审查
2. 可能会请求修改或提供反馈
3. 修改后请求审查更新
4. 审查通过后合并
5. 保持关注 CI/CD 状态

## 获取帮助

如有疑问，可以：

- 查看 [实现指南](docs/IMPLEMENTATION_GUIDE.md)
- 参考 [Skills 总览](docs/skills-overview.md)
- 查看现有 Skill 作为参考
- 提交 Issue 提问

## 许可证

贡献的代码将采用 [MIT License](LICENSE)。

## 致谢

感谢所有贡献者！您的贡献让 DevOps 开发更高效。

---

**最后更新**: 2025-01-30
