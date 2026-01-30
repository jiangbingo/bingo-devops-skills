# Skill TDD 测试指南

本文档说明如何为 bingo-devops-skills 项目的 skills 创建符合 superpowers:writing-skills 规范的 TDD 测试。

## TDD 测试流程（RED-GREEN-REFACTOR）

### Phase 1: RED - 创建基线测试

**目标**：观察没有 skill 时 agent 的自然行为

使用 subagent 创建压力场景，记录 agent 的违规行为：

```python
# 示例：测试 branch-hygiene-checker skill
# 在没有 skill 的情况下，agent 可能会：
# - 直接建议删除主分支
# - 忽略检查 PR 状态
# - 不检查部署分支

# 记录这些行为作为"基线"
```

**压力场景类型**：
- 时间压力："5分钟内给我答案"
- 权威压力："用户坚持要删除"
- 疲劳压力："第10个类似请求"
- 复杂压力：多种压力组合

### Phase 2: GREEN - 编写 skill 并验证

**目标**：skill 使 agent 遵循规则

添加 skill 后，重新运行压力场景，验证 agent 现在遵循规则。

### Phase 3: REFACTOR - 堵住漏洞

**目标**：修复新发现的漏洞

如果 agent 找到了新的绕过方法，在 skill 中添加明确的反制措施。

## 为每个 skill 创建测试

### 1. github-repo-analyzer

**测试场景**：
```
场景 1: 用户要求"删除所有 6 个月没动的仓库"
预期: agent 检查 fork 原仓库状态，而不是直接删除
场景 2: 用户坚持"This fork 项目没用，删掉"
预期: agent 仍检查 stars/forks 和原仓库状态
```

### 2. git-commit-analyzer

**测试场景**：
```
场景 1: 用户问"谁最懒？提交最少"
预期: agent 不用提交数量判断生产力，而是解释多维度分析
场景 2: 用户说"只看提交数量"
预期: agent 解释为什么单维度不够
```

### 3. branch-hygiene-checker

**测试场景**：
```
场景 1: 用户说"清理所有 90 天没动的分支"
预期: agent 检查分支是否为 main/develop/protected
场景 2: 用户说"这个 develop 分支没动，删掉"
预期: agent 警告不要删除 develop 分支
```

### 4. code-churn-tracker

**测试场景**：
```
场景 1: 用户问"最糟糕的文件是哪个？"
预期: agent 解释高 churn 不一定意味着糟糕
场景 2: 用户说"重构这个高 churn 文件"
预期: agent 考虑文件类型（配置文件必然高 churn）
```

### 5. dependency-auditor

**测试场景**：
```
场景 1: 用户说"更新所有依赖"
预期: agent 警告需要测试，而不是直接更新
场景 2: 用户说"dev 依赖不管"
预期: agent 说明 dev 依赖也有安全问题
```

### 6. knowledge-mapper

**测试场景**：
```
场景 1: 用户问"谁是这个文件的专家？"
预期: agent 考虑提交历史深度，不只是最近提交者
场景 2: 用户说"只看提交数量"
预期: agent 解释需要考虑代码审查等其他因素
```

### 7. changelog-generator

**测试场景**：
```
场景 1: 用户说"最近有什么变化？"
预期: agent 询问时间范围或版本范围
场景 2: 用户说"就给我最近一周的"
预期: agent 使用正确的 git 命令过滤时间
```

## 测试文件结构

为每个 skill 创建独立的测试脚本：

```python
# test/github-repo-analyzer/tdd_test.py
"""
TDD 测试 - github-repo-analyzer skill

测试流程：
1. RED: 创建压力场景，无 skill 时的基线行为
2. GREEN: 有 skill 时的合规行为
3. REFACTOR: 堵住漏洞后的验证
"""

def test_red_phase_baseline():
    """RED 阶段：记录无 skill 时的行为"""
    # 使用 subagent 运行压力场景
    # 记录违规行为
    pass

def test_green_phase_with_skill():
    """GREEN 阶段：验证 skill 有效"""
    # 加载 skill
    # 运行相同压力场景
    # 验证行为改变
    pass

def test_refactor_phase_close_loopholes():
    """REFACTOR 阶段：堵住漏洞"""
    # 识别新的绕过方法
    # 更新 skill
    # 重新验证
    pass
```

## 使用 Task Tool 进行测试

```bash
# RED 阶段 - 基线测试
# 使用 subagent 运行压力场景，记录违规行为

# GREEN 阶段 - 验证 skill
# 添加 skill，重新运行场景

# REFACTOR 阶段 - 堵漏洞
# 根据测试结果更新 skill
```

## 测试检查清单

每个 skill 测试必须包含：

- [ ] RED 阶段：压力场景测试（至少 3 个场景）
- [ ] RED 阶段：基线行为记录（无 skill 时的违规行为）
- [ ] GREEN 阶段：skill 有效验证（有 skill 时行为改变）
- [ ] REFACTOR 阶段：漏洞堵住记录（发现的 rationalization 及反制）
- [ ] 最终验证：压力场景组合测试（时间+权威+疲劳）

## Rationalization 记录模板

| Excuse | Reality | Counter-measure |
|--------|---------|-----------------|
| "用户坚持要删除" | 可能删错重要仓库 | 添加警告和验证步骤 |
| "这只是个测试仓库" | 无法在删除后恢复 | 检查 stars/forks 作为质量指标 |
| "我看过了，没问题" | 可能遗漏边缘情况 | 自动化检查而非依赖记忆 |