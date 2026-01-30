# 🚀 Bingo DevOps Skills

> DevOps 开发者辅助工具 Skills 集合 - 提升开发效率的智能工具箱

[![CI/CD](https://github.com/jiangbingo/bingo-devops-skills/actions/workflows/test-all.yml/badge.svg)](https://github.com/jiangbingo/bingo-devops-skills/actions/workflows/test-all.yml)
[![Skills](https://img.shields.io/badge/Skills-14-blue)](#skills-overview)
[![Tests](https://img.shields.io/badge/Tests-Passing-green)](#testing)
[![Python](https://img.shields.io/badge/Python-3.8+-yellow.svg)](https://www.python.org/)
[![License](https://img.shields.io/badge/License-MIT-orange.svg)](LICENSE)

## 📖 简介

**Bingo DevOps Skills** 是一组专为 DevOps 工程师和开发者设计的命令行工具集合。每个 Skill 都专注于解决开发过程中的特定问题，从代码质量分析到项目维护，全方位提升开发效率。

### ✨ 特性

- 🎯 **专注高效**: 每个工具解决一个具体问题
- 🔧 **开箱即用**: 无需复杂配置，直接运行
- 📊 **可视化输出**: 清晰的报告和数据展示
- 🌐 **多语言支持**: Python, JavaScript, Go, Java 等
- 🧪 **完整测试**: 每个技能都有独立的测试套件

## 🎯 Skills 总览

### Phase 1: 代码仓库分析

| Skill | 描述 | 输出 |
|-------|------|------|
| [github-repo-analyzer](skillsets/github-repo-analyzer/) | GitHub 仓库分析 | 仓库清理建议 |
| [git-commit-analyzer](skillsets/git-commit-analyzer/) | Git 提交历史分析 | 提交统计报告 |
| [branch-hygiene-checker](skillsets/branch-hygiene-checker/) | 分支健康度检查 | 分支清理建议 |
| [dependency-auditor](skillsets/dependency-auditor/) | 依赖安全审计 | 安全漏洞报告 |
| [changelog-generator](skillsets/changelog-generator/) | 变更日志生成 | CHANGELOG.md |

### Phase 2: 代码质量 & 知识管理

| Skill | 描述 | 输出 |
|-------|------|------|
| [code-churn-tracker](skillsets/code-churn-tracker/) | 代码变更率追踪 | 变更热点分析 |
| [test-coverage-analyzer](skillsets/test-coverage-analyzer/) | 测试覆盖率分析 | 覆盖率报告 |
| [complexity-mapper](skillsets/complexity-mapper/) | 代码复杂度映射 | 复杂度热图 |
| [knowledge-mapper](skillsets/knowledge-mapper/) | 知识图谱映射 | 依赖关系图 |

### Phase 3: 生产力优化

| Skill | 描述 | 输出 |
|-------|------|------|
| [code-smell-detector](skillsets/code-smell-detector/) | 代码异味检测 | 质量评分报告 |
| [time-tracker-analyzer](skillsets/time-tracker-analyzer/) | 编码时间分析 | 时间分布报告 |
| [task-completion-tracker](skillsets/task-completion-tracker/) | 任务完成追踪 | 任务统计报告 |
| [context-switch-monitor](skillsets/context-switch-monitor/) | 上下文切换监控 | 专注度分析 |
| [doc-coverage-checker](skillsets/doc-coverage-checker/) | 文档覆盖率检查 | 文档完整性报告 |

## 🚀 快速开始

### 安装

```bash
# 克隆仓库
git clone https://github.com/jiangbingo/bingo-devops-skills.git
cd bingo-devops-skills
```

### 使用

每个 Skill 都是独立的 Python 脚本，可以直接运行：

```bash
# 例如：分析 GitHub 仓库
python3 skillsets/github-repo-analyzer/impl.py

# 例如：检测代码异味
python3 skillsets/code-smell-detector/impl.py

# 例如：生成变更日志
python3 skillsets/changelog-generator/impl.py
```

### 测试

#### 安装依赖

```bash
bash scripts/install-deps.sh
```

#### 运行所有测试

```bash
bash scripts/test-all.sh
```

#### 运行单个 Skill 的测试

```bash
python3 skillsets/<skill-name>/test_skill.py
```

### CI/CD

项目配置了 GitHub Actions 自动化测试流程：

- ✅ 自动在多个 Python 版本上运行测试（3.8, 3.9, 3.10, 3.11）
- ✅ 推送和 PR 时自动触发
- ✅ 生成详细的测试报告
- ✅ 测试失败时阻止合并

查看详细的 CI/CD 配置：[CI/CD 指南](docs/CI-CD-GUIDE.md)

## 📁 项目结构

```
bingo-devops-skills/
├── skillsets/                # Skills 定义目录
│   ├── github-repo-analyzer/ # Skill 实现目录
│   │   ├── SKILL.md          # 技能定义
│   │   ├── impl.py           # 实现脚本
│   │   ├── test_skill.py     # 测试脚本
│   │   └── README.md         # 使用文档
│   └── ...                   # 其他 Skills
├── scripts/                  # 通用脚本
│   ├── test-all.sh          # 集成测试
│   └── install-deps.sh      # 依赖安装
├── docs/                     # 项目文档
│   ├── IMPLEMENTATION_GUIDE.md
│   ├── SKILL_TDD_GUIDE.md
│   └── CI-CD-GUIDE.md       # CI/CD 配置指南
├── .github/                  # GitHub 配置
│   └── workflows/
│       └── test-all.yml     # 自动化测试工作流
└── README.md                 # 本文件
```

## 🛠️ 开发指南

### Skill 标准结构

每个 Skill 必须包含：

1. **SKILL.md**: 技能定义文件（YAML frontmatter + 内容）
2. **impl.py**: Python 实现脚本
3. **test_skill.py**: 测试脚本
4. **README.md**: 使用文档

### 创建新 Skill

1. 在 `skillsets/` 下创建新目录
2. 复制参考模板（如 `github-repo-analyzer/`）
3. 修改 SKILL.md 中的 `name` 和 `description`
4. 实现核心功能
5. 编写测试用例
6. 运行集成测试验证

### 代码规范

- 使用 Python 3.7+ 语法
- 遵循 PEP 8 代码风格
- 中文友好的输出格式
- 完整的错误处理
- 清晰的文档注释

## 📊 测试状态

| Skill | 文件结构 | 语法检查 | 格式验证 | 状态 |
|-------|---------|---------|---------|------|
| github-repo-analyzer | ✅ | ✅ | ✅ | ✅ |
| git-commit-analyzer | ✅ | ✅ | ✅ | ✅ |
| branch-hygiene-checker | ✅ | ✅ | ✅ | ✅ |
| dependency-auditor | ✅ | ✅ | ✅ | ✅ |
| changelog-generator | ✅ | ✅ | ✅ | ✅ |
| code-churn-tracker | ✅ | ✅ | ✅ | ✅ |
| test-coverage-analyzer | ✅ | ✅ | ✅ | ✅ |
| complexity-mapper | ✅ | ✅ | ✅ | ✅ |
| knowledge-mapper | ✅ | ✅ | ✅ | ✅ |
| code-smell-detector | ✅ | ✅ | ✅ | ✅ |
| time-tracker-analyzer | ✅ | ✅ | ✅ | ✅ |
| task-completion-tracker | ✅ | ✅ | ✅ | ✅ |
| context-switch-monitor | ✅ | ✅ | ✅ | ✅ |
| doc-coverage-checker | ✅ | ✅ | ✅ | ✅ |

**总计**: 14/14 Skills 通过测试 (100%)

## 🤝 贡献指南

欢迎贡献新的 Skills 或改进现有功能！

1. Fork 本仓库
2. 创建特性分支 (`git checkout -b feature/amazing-skill`)
3. 提交更改 (`git commit -m 'Add amazing skill'`)
4. 推送到分支 (`git push origin feature/amazing-skill`)
5. 创建 Pull Request

### 贡献规范

- 遵循现有代码风格
- 添加完整的测试用例
- 更新相关文档
- 确保所有测试通过

## 📄 许可证

本项目采用 [MIT License](LICENSE) 开源协议。

## 🔗 相关资源

- [实现指南](docs/IMPLEMENTATION_GUIDE.md)
- [TDD 指南](docs/SKILL_TDD_GUIDE.md)
- [CI/CD 指南](docs/CI-CD-GUIDE.md)
- [Skills 总览](docs/skills-overview.md)

## 📮 联系方式

- 项目主页: [https://github.com/jiangbingo/bingo-devops-skills](https://github.com/jiangbingo/bingo-devops-skills)
- 问题反馈: [Issues](https://github.com/jiangbingo/bingo-devops-skills/issues)

---

<p align="center">
  <b>Made with ❤️ for DevOps Engineers</b>
</p>
