# Bingo DevOps Skills

> **DevOps 开发者工具技能库** - 提升 DevOps 工作效率的 AI 辅助技能集合

## 项目概述

`bingo-devops-skills` 是一个专为 DevOps 工作流设计的 AI Skills 集合，通过 Claude Code 等 AI 工具，帮助开发者自动化日常任务、分析代码质量、优化工作流程。

## 技能列表

### 已实现 ✅

| Skill | 描述 | 触发词 |
|-------|------|--------|
| `github-repo-analyzer` | 分析 GitHub 仓库，提供清理建议 | "分析我的 GitHub 仓库", "检查 fork 项目" |

### 计划中 🚧

#### 代码仓库相关

| Skill | 描述 | 状态 |
|-------|------|------|
| `git-commit-analyzer` | 分析 Git 提交历史、贡献统计、活跃度 | 待实现 |
| `code-churn-tracker` | 追踪代码变更率、识别高变动文件 | 待实现 |
| `branch-hygiene-checker` | 检查僵尸分支、合并状态、命名规范 | 待实现 |
| `dependency-auditor` | 依赖安全审计、漏洞扫描、许可证检查 | 待实现 |

#### 代码质量相关

| Skill | 描述 | 状态 |
|-------|------|------|
| `code-smell-detector` | 检测代码异味、重复代码、复杂度 | 待实现 |
| `test-coverage-analyzer` | 分析测试覆盖率、识别未测试代码 | 待实现 |
| `complexity-mapper` | 生成代码复杂度热图、重构优先级 | 待实现 |

#### 开发者生产力相关

| Skill | 描述 | 状态 |
|-------|------|------|
| `time-tracker-analyzer` | 分析编码时间分布、专注时段、生产力趋势 | 待实现 |
| `task-completion-tracker` | 追踪任务完成率、阻塞因素、时间估算 | 待实现 |
| `context-switch-monitor` | 监控上下文切换频率、减少干扰建议 | 待实现 |

#### 文档和知识相关

| Skill | 描述 | 状态 |
|-------|------|------|
| `doc-coverage-checker` | 检查代码文档覆盖率、未文档化 API | 待实现 |
| `knowledge-mapper` | 构建代码库知识图谱、专家领域识别 | 待实现 |
| `changelog-generator` | 自动生成基于提交的变更日志 | 待实现 |

## 项目结构

```
bingo-devops-skills/
├── skillsets/                # Skills 定义目录
│   ├── github-repo-analyzer/
│   └── [other-skills]/
├── docs/                     # 项目文档
│   └── skills-overview.md    # 本文件
├── scripts/                  # 通用脚本
│   ├── install-deps.sh       # 依赖安装
│   └── test-all.sh           # 测试所有 skills
└── README.md                 # 项目说明
```

## Skill 标准结构

每个 skill 遵循统一的结构：

```
skill-name/
├── SKILL.md          # 技能定义（YAML frontmatter + 内容）
├── impl.py           # Python 实现脚本
├── test_skill.py     # 测试脚本
└── README.md         # 使用文档
```

## 快速开始

### 使用现有 Skill

```bash
# 分析 GitHub 仓库
python3 skillsets/github-repo-analyzer/impl.py

# 或运行测试
python3 skillsets/github-repo-analyzer/test_skill.py
```

### 创建新 Skill

1. 在 `skillsets/` 下创建新目录
2. 参考 `github-repo-analyzer` 的结构
3. 编写 SKILL.md、impl.py、test_skill.py
4. 运行测试验证功能

## 依赖要求

- **Python**: 3.x
- **GitHub CLI**: `gh` (用于 GitHub 相关技能)
- **Git**: 用于版本控制和代码分析

## 开发路线图

### Phase 1: 代码仓库分析 (高优先级)
- [x] github-repo-analyzer
- [ ] git-commit-analyzer
- [ ] branch-hygiene-checker
- [ ] dependency-auditor

### Phase 2: 代码质量分析
- [ ] code-churn-tracker
- [ ] test-coverage-analyzer
- [ ] complexity-mapper

### Phase 3: 知识管理
- [ ] knowledge-mapper
- [ ] changelog-generator
- [ ] doc-coverage-checker

### Phase 4: 生产力优化
- [ ] code-smell-detector
- [ ] time-tracker-analyzer
- [ ] task-completion-tracker
- [ ] context-switch-monitor

## 贡献指南

欢迎贡献新的 Skills！请确保：

1. 遵循标准 Skill 结构
2. 包含完整的测试脚本
3. 提供 SKILL.md 和 README.md
4. 代码风格与现有 Skills 保持一致

## 许可证

MIT License

## 联系方式

项目地址: [GitHub Repository]

---

*最后更新: 2025-01-30*
