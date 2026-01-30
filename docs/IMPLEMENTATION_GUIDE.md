# Bingo DevOps Skills - 多 Session 并行实现指南

> 本文档包含完整的 Skills 创意和实现提示词，用于在多个 Claude Code Session 中并行开发

## 📋 项目背景

### 项目信息
- **项目名称**: `bingo-devops-skills`
- **项目目标**: 构建 DevOps 相关的开发者辅助工具 Skills 集合
- **参考模板**: `skillsets/github-repo-analyzer/`

### Skill 标准结构
每个 Skill 必须包含：
```
skillsets/
└── skill-name/
    ├── SKILL.md          # 技能定义文件（YAML frontmatter + 内容）
    ├── impl.py           # Python 实现脚本
    ├── test_skill.py     # 测试脚本
    └── README.md         # 使用文档
```

---

## 🚀 多 Session 使用方法

### Step 1: 发送项目总览
在每个新的 Claude Code Session 中，**首先发送以下内容**：

---

### 📦 项目总览（复制给所有 Session）

```
你正在参与 bingo-devops-skills 项目的开发，这是一个 DevOps 开发者工具技能库。

## 项目背景
- 项目名称：bingo-devops-skills
- 目标：构建 DevOps 相关的开发者辅助工具 skills 集合
- 参考示例：skillsets/github-repo-analyzer/

## Skill 标准结构
每个 skill 必须包含：
1. SKILL.md - 技能定义文件（YAML frontmatter + 内容）
2. impl.py - Python 实现脚本
3. test_skill.py - 测试脚本
4. README.md - 使用文档

## 现有参考
请参考 skillsets/github-repo-analyzer/ 的代码风格和结构作为模板。

## 你的任务
你将实现其中一个 skill，请确保：
- 代码风格与现有 skill 一致
- 输出格式清晰、中文友好
- 包含完整的错误处理
- 测试脚本覆盖主要功能

现在准备实现你被分配的 skill。
```

---

### Step 2: 发送对应的 Skill 实现提示词

根据每个 Session 分配的任务，发送对应的实现提示词。

---

## 📝 各 Skill 实现提示词

### Session 1: git-commit-analyzer

```
## Task: 实现 git-commit-analyzer skill

## Skill 功能
分析 Git 提交历史，提供：
- 提交统计（总提交数、作者分布、时间分布）
- 提交模式分析（提交信息长度、提交频率）
- 贡献者排行榜
- 活跃时段热图
- 提交信息质量分析（是否符合约定式提交规范）

## 触发场景
"分析提交历史"、"查看代码贡献统计"、"谁提交最多"

## 技术要点
- 使用 git log 命令获取提交数据
- 使用 subprocess 和 json 解析输出
- git log --pretty=format:'{"hash":"%H","author":"%an","date":"%ad","message":"%s"}' --date=iso

## 输出文件
commit_analysis_report.txt

## SKILL.md 描述
"Use when analyzing Git commit history, viewing contributor statistics, checking commit patterns, or understanding code contribution distribution"

## 创建目录
mkdir -p skillsets/git-commit-analyzer
```

---

### Session 2: code-churn-tracker

```
## Task: 实现 code-churn-tracker skill

## Skill 功能
追踪代码变更率，识别：
- 高变动文件（频繁修改的文件）
- 代码稳定性评分
- 变更热点分析
- 潜在风险区域识别
- 变更历史趋势

## 触发场景
"哪些文件变动最频繁"、"分析代码稳定性"、"追踪代码变更"

## 技术要点
- 使用 git log --name-status --pretty=format: 获取文件变更
- 统计每个文件的修改次数和修改行数
- 计算变动频率和稳定性指数

## 输出文件
code_churn_report.txt

## SKILL.md 描述
"Use when tracking code changes, identifying high-churn files, analyzing code stability, or finding frequently modified code"

## 创建目录
mkdir -p skillsets/code-churn-tracker
```

---

### Session 3: branch-hygiene-checker

```
## Task: 实现 branch-hygiene-checker skill

## Skill 功能
检查分支健康度：
- 僵尸分支检测（长期未活动）
- 已合并分支识别
- 分支命名规范检查
- 分支依赖关系分析
- 清理建议

## 触发场景
"清理旧分支"、"检查分支状态"、"有哪些僵尸分支"

## 技术要点
- 使用 git branch -a 列出所有分支
- 使用 git log 检查分支最后活动时间
- 使用 git branch --merged 检查已合并分支
- 定义命名规范（如 feature/*、bugfix/*、hotfix/*）

## 输出文件
branch_hygiene_report.txt

## SKILL.md 描述
"Use when checking branch status, cleaning up old branches, identifying zombie branches, or analyzing branch naming conventions"

## 创建目录
mkdir -p skillsets/branch-hygiene-checker
```

---

### Session 4: dependency-auditor

```
## Task: 实现 dependency-auditor skill

## Skill 功能
依赖安全审计：
- 过时的依赖包检测
- 安全漏洞扫描
- 许可证合规性检查
- 依赖树分析
- 更新建议

## 触发场景
"检查依赖安全"、"更新依赖建议"、"依赖漏洞扫描"

## 技术要点
- 支持多种包管理器（npm、pip、cargo、composer）
- 使用 npm audit、pip-audit、cargo audit 等命令
- 解析 package.json、requirements.txt、Cargo.toml
- 检查许可证类型

## 输出文件
dependency_audit_report.txt

## SKILL.md 描述
"Use when checking dependency security, scanning for vulnerabilities, auditing licenses, or identifying outdated packages"

## 创建目录
mkdir -p skillsets/dependency-auditor
```

---

### Session 5: code-smell-detector

```
## Task: 实现 code-smell-detector skill

## Skill 功能
代码异味检测：
- 重复代码识别
- 过长函数检测
- 复杂度分析（圈复杂度）
- 命名规范检查
- 死代码检测
- 代码异味评分

## 触发场景
"检查代码质量"、"发现潜在问题"、"代码异味检测"

## 技术要点
- 使用 pylint、flake8、eslint 等工具
- 或实现简单启发式规则（函数长度、参数数量、嵌套层级）
- 支持 Python、JavaScript 等语言

## 输出文件
code_smell_report.txt

## SKILL.md 描述
"Use when detecting code smells, checking code quality, identifying duplicate code, or analyzing code complexity"

## 创建目录
mkdir -p skillsets/code-smell-detector
```

---

### Session 6: test-coverage-analyzer

```
## Task: 实现 test-coverage-analyzer skill

## Skill 功能
测试覆盖率分析：
- 总体覆盖率统计
- 按文件覆盖率分析
- 未覆盖代码行识别
- 覆盖率趋势
- 测试缺口建议

## 触发场景
"测试覆盖率如何"、"哪些代码缺少测试"、"分析测试覆盖"

## 技术要点
- 使用 coverage.py（Python）、jest --coverage（JS）等
- 解析 .coverage 文件或 coverage-report.json
- 生成覆盖率热图报告

## 输出文件
test_coverage_report.txt

## SKILL.md 描述
"Use when analyzing test coverage, identifying untested code, checking coverage gaps, or generating coverage reports"

## 创建目录
mkdir -p skillsets/test-coverage-analyzer
```

---

### Session 7: complexity-mapper

```
## Task: 实现 complexity-mapper skill

## Skill 功能
代码复杂度映射：
- 圈复杂度分析
- 文件复杂度排名
- 复杂度热图
- 重构优先级建议
- 认知复杂度评估

## 触发场景
"分析代码复杂度"、"哪些文件需要重构"、"复杂度热图"

## 技术要点
- 使用 radon、lizard 等复杂度分析工具
- 计算圈复杂度（Cyclomatic Complexity）
- 按模块/文件/函数生成复杂度分布

## 输出文件
complexity_map_report.txt

## SKILL.md 描述
"Use when analyzing code complexity, generating complexity heatmaps, identifying refactoring priorities, or mapping cognitive complexity"

## 创建目录
mkdir -p skillsets/complexity-mapper
```

---

### Session 8: time-tracker-analyzer

```
## Task: 实现 time-tracker-analyzer skill

## Skill 功能
编码时间分析：
- 按时段统计提交频率
- 工作日 vs 周末活动
- 活跃时段识别
- 生产力趋势
- 编码习惯分析

## 触发场景
"分析我的编码时间"、"什么时候最有效率"、"编码习惯分析"

## 技术要点
- 使用 git log --date=format:'%Y-%m-%d %H:%M' 获取时间戳
- 按小时、星期几聚合统计
- 生成热图和时间分布图

## 输出文件
time_tracker_report.txt

## SKILL.md 描述
"Use when analyzing coding time patterns, identifying productive hours, tracking work habits, or visualizing commit time distribution"

## 创建目录
mkdir -p skillsets/time-tracker-analyzer
```

---

### Session 9: task-completion-tracker

```
## Task: 实现 task-completion-tracker skill

## Skill 功能
任务完成追踪：
- 任务完成率统计
- 任务类型分析（feature/bug/refactor）
- 任务周期分析
- 延期任务识别
- 估算准确性分析

## 触发场景
"分析任务完成情况"、"为什么项目延期"、"任务统计"

## 技术要点
- 从提交信息或 issue 追踪任务
- 解析约定式提交（feat:、fix:、refactor:）
- 关联 Git 提交与任务/issue

## 输出文件
task_completion_report.txt

## SKILL.md 描述
"Use when tracking task completion, analyzing project velocity, identifying delayed tasks, or measuring estimation accuracy"

## 创建目录
mkdir -p skillsets/task-completion-tracker
```

---

### Session 10: context-switch-monitor

```
## Task: 实现 context-switch-monitor skill

## Skill 功能
上下文切换监控：
- 文件切换频率分析
- 工作区分散度
- 专注时段识别
- 切换成本评估
- 专注建议

## 触发场景
"分析工作被打断情况"、"上下文切换分析"、"专注度评估"

## 技术要点
- 从 Git 提交文件分析工作区切换
- 统计短时间内在不同文件/模块间的跳跃
- 计算集中度指数

## 输出文件
context_switch_report.txt

## SKILL.md 描述
"Use when monitoring context switches, analyzing work fragmentation, identifying focus periods, or measuring attention fragmentation"

## 创建目录
mkdir -p skillsets/context-switch-monitor
```

---

### Session 11: doc-coverage-checker

```
## Task: 实现 doc-coverage-checker skill

## Skill 功能
文档覆盖率检查：
- 函数/类文档覆盖率
- 模块文档完整性
- 公开 API 文档检查
- 文档质量评分
- 缺失文档列表

## 触发场景
"检查文档完整性"、"哪些函数缺少注释"、"文档覆盖率"

## 技术要点
- 使用 pydocstyle、eslint jsdoc 等工具
- 或解析 AST 检查 docstring 存在
- 识别公开 API（非 _ 开头）的文档状态

## 输出文件
doc_coverage_report.txt

## SKILL.md 描述
"Use when checking documentation coverage, finding undocumented functions, validating docstrings, or analyzing API documentation completeness"

## 创建目录
mkdir -p skillsets/doc-coverage-checker
```

---

### Session 12: knowledge-mapper

```
## Task: 实现 knowledge-mapper skill

## Skill 功能
知识图谱映射：
- 模块依赖关系图
- 文件关联分析
- 专家领域识别（谁修改哪些文件）
- 知识孤岛检测
- 代码所有权分析

## 触发场景
"生成项目知识图谱"、"谁了解这个模块"、"模块依赖分析"

## 技术要点
- 使用 git log --pretty=format:'%an' --name-only 获取作者-文件映射
- 构建文件共现矩阵
- 生成依赖关系图（可输出 Graphviz DOT 格式）

## 输出文件
knowledge_map_report.txt
knowledge_graph.dot（可选）

## SKILL.md 描述
"Use when mapping project knowledge, analyzing module dependencies, identifying code owners, or generating knowledge graphs"

## 创建目录
mkdir -p skillsets/knowledge-mapper
```

---

### Session 13: changelog-generator

```
## Task: 实现 changelog-generator skill

## Skill 功能
变更日志生成：
- 自动解析提交历史
- 按版本组织变更
- 分类变更类型（Added/Changed/Fixed/Removed）
- 遵循 Keep a Changelog 格式
- 生成 Markdown 格式

## 触发场景
"生成 changelog"、"最近有什么改动"、"版本发布日志"

## 技术要点
- 使用 git log 解析约定式提交
- 解析版本标签（git tag）
- 按时间范围和版本分组
- 格式化为 Markdown

## 输出文件
CHANGELOG.md

## SKILL.md 描述
"Use when generating changelogs, creating release notes, summarizing changes between versions, or documenting project history"

## 创建目录
mkdir -p skillsets/changelog-generator
```

---

## 📊 实现优先级

### 高优先级（Phase 1: 代码仓库分析）
1. ✅ `github-repo-analyzer` - 已实现
2. `git-commit-analyzer`
3. `branch-hygiene-checker`
4. `dependency-auditor`
5. `changelog-generator`

### 中优先级（Phase 2: 代码质量 & 知识管理）
6. `code-churn-tracker`
7. `test-coverage-analyzer`
8. `complexity-mapper`
9. `knowledge-mapper`

### 低优先级（Phase 3 & 4: 生产力优化）
10. `code-smell-detector`
11. `time-tracker-analyzer`
12. `task-completion-tracker`
13. `context-switch-monitor`
14. `doc-coverage-checker`

---

## 📁 项目结构

```
bingo-devops-skills/
├── skillsets/                # Skills 定义目录
│   ├── github-repo-analyzer/      ✅ 已实现
│   ├── code-churn-tracker/        ✅ 已实现
│   ├── dependency-auditor/        ✅ 已实现
│   ├── knowledge-mapper/          ⚠️  部分实现
│   ├── task-completion-tracker/   ⚠️  未开始
│   ├── git-commit-analyzer/       🔜 待实现
│   ├── branch-hygiene-checker/    🔜 待实现
│   ├── code-smell-detector/       🔜 待实现
│   ├── test-coverage-analyzer/    🔜 待实现
│   ├── complexity-mapper/         🔜 待实现
│   ├── time-tracker-analyzer/     🔜 待实现
│   ├── context-switch-monitor/    🔜 待实现
│   ├── doc-coverage-checker/      🔜 待实现
│   └── changelog-generator/       🔜 待实现
├── docs/                     # 项目文档
│   ├── skills-overview.md    # Skills 总览
│   └── IMPLEMENTATION_GUIDE.md  # 本文件
├── scripts/                  # 通用脚本
│   ├── install-deps.sh       # 依赖安装
│   └── test-all.sh           # 测试所有 skills
└── README.md                 # 项目说明
```

---

## 🔧 参考模板

### SKILL.md 模板

```yaml
---
name: "skill-name"
description: "Use when [具体的触发条件和症状，以 Use when 开头，第三人称，不总结流程]"
---

# Skill Name

## When to Invoke
Invoke this skill when:
- [触发场景 1]
- [触发场景 2]

## What It Does
1. [功能 1]
2. [功能 2]

## Usage Examples
### Example 1
```
User: "示例用户输入"
```

## Output Format
- [输出格式说明]

## Implementation Notes
- [实现要点]
```

### impl.py 模板要点

```python
import subprocess
import json
from datetime import datetime
from collections import Counter

def fetch_data():
    """获取数据"""
    # 使用 subprocess 调用外部命令
    pass

def generate_report(data):
    """生成报告"""
    report = []
    # 构建报告内容
    return '\n'.join(report)

def save_report(report, output_file):
    """保存报告"""
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(report)

def main():
    print("🔍 正在获取数据...")
    data = fetch_data()

    print("📊 正在分析数据...")
    report = generate_report(data)

    output_file = 'report.txt'
    print("📝 正在生成报告...")
    save_report(report, output_file)
    print(f"✅ 报告已保存到: {output_file}")

if __name__ == '__main__':
    main()
```

### test_skill.py 模板要点

```python
#!/usr/bin/env python3
"""测试脚本 - 验证 skill 是否正常工作"""

import subprocess
import sys
import os

def test_skill():
    """测试 Skill 功能"""
    print("🧪 正在测试 xxx Skill...")

    # 测试 1: 检查文件存在
    skill_path = 'skillsets/xxx/SKILL.md'
    impl_path = 'skillsets/xxx/impl.py'

    # 测试 2: 执行脚本
    # 测试 3: 验证输出

    return True

if __name__ == '__main__':
    success = test_skill()
    sys.exit(0 if success else 1)
```

---

## ✅ 实现检查清单

每个 Skill 实现完成后，确认：

- [ ] 目录结构正确
- [ ] SKILL.md 包含正确的 YAML frontmatter
- [ ] description 以 "Use when..." 开头
- [ ] impl.py 功能完整，有错误处理
- [ ] test_skill.py 测试通过
- [ ] README.md 使用说明清晰
- [ ] 输出格式中文友好
- [ ] 代码风格与 github-repo-analyzer 一致

---

## 📝 创建日期

2025-01-30

## 🔗 相关文档

- [Skills 总览](skills-overview.md)
- [参考模板](../skillsets/github-repo-analyzer/)
