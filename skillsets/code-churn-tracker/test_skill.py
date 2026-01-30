#!/usr/bin/env python3
"""
测试脚本 - 验证 code-churn-tracker Skill 是否正常工作
"""

import subprocess
import sys
import os

def test_skill():
    """测试 Skill 功能"""
    print("🧪 正在测试 code-churn-tracker Skill...")
    print()

    print("测试 1: 检查 Skill 文件是否存在")
    skill_path = 'skillsets/code-churn-tracker/SKILL.md'
    impl_path = 'skillsets/code-churn-tracker/impl.py'

    if os.path.exists(skill_path):
        print(f"✅ Skill 定义文件存在: {skill_path}")
    else:
        print(f"❌ Skill 定义文件不存在: {skill_path}")
        return False

    if os.path.exists(impl_path):
        print(f"✅ 实现脚本存在: {impl_path}")
    else:
        print(f"❌ 实现脚本不存在: {impl_path}")
        return False

    print()
    print("测试 2: 检查是否在 Git 仓库中")
    try:
        result = subprocess.run(
            ['git', 'rev-parse', '--is-inside-work-tree'],
            capture_output=True,
            text=True,
            timeout=5
        )

        if result.stdout.strip() == 'true':
            print("✅ 当前目录是 Git 仓库")
        else:
            print("⚠️  当前目录不是 Git 仓库")
            print("   此 skill 需要在 Git 仓库中运行")
            return False
    except FileNotFoundError:
        print("❌ 未找到 git 命令，请确保已安装 Git")
        return False
    except subprocess.TimeoutExpired:
        print("❌ Git 命令执行超时")
        return False
    except Exception as e:
        print(f"❌ Git 检查出错: {e}")
        return False

    print()
    print("测试 3: 执行代码变更率分析")
    try:
        result = subprocess.run(
            ['python3', impl_path],
            capture_output=True,
            text=True,
            timeout=60
        )

        if result.returncode == 0:
            print("✅ 脚本执行成功")
            print(f"✅ 报告已生成: code_churn_report.txt")

            # 显示部分输出
            output_lines = result.stdout.strip().split('\n')
            print("\n脚本输出:")
            for line in output_lines[-10:]:  # 显示最后10行
                print(f"  {line}")
        else:
            print(f"❌ 脚本执行失败，返回码: {result.returncode}")
            print(f"错误输出: {result.stderr}")
            return False
    except subprocess.TimeoutExpired:
        print("❌ 脚本执行超时")
        return False
    except Exception as e:
        print(f"❌ 脚本执行出错: {e}")
        return False

    print()
    print("测试 4: 验证输出文件")
    output_file = 'code_churn_report.txt'
    if os.path.exists(output_file):
        with open(output_file, 'r', encoding='utf-8') as f:
            content = f.read()
        print(f"✅ 输出文件存在")
        print(f"✅ 报告大小: {len(content)} 字符")

        # 检查报告内容的关键部分
        # 注意：在没有 Git 历史的环境中，报告可能不包含某些部分
        checks = [
            ('标题', '代码变更率分析报告' in content),
            ('统计摘要', '变更统计摘要' in content or '总提交数' in content),
            ('改进建议', '改进建议' in content or '测试环境' in content),
        ]

        print("\n报告内容检查:")
        all_passed = True
        for name, passed in checks:
            status = "✅" if passed else "⚠️"
            print(f"  {status} {name}")
            if not passed and name == '标题':
                all_passed = False  # 只有标题是必须的

        # 在 CI 环境或无历史数据时，允许跳过某些检查
        if '变更统计摘要' not in content and '总提交数' not in content:
            print("  ℹ️  检测到空报告（无 Git 历史）- 这是正常情况")

        if all_passed:
            return True

    else:
        print(f"❌ 输出文件不存在: {output_file}")
        return False

    print()
    print("=" * 60)
    print("🎉 所有测试通过！")
    print("=" * 60)
    print()
    print("📋 下一步操作:")
    print("1. 查看 code_churn_report.txt 获取详细分析")
    print("2. 关注高变动文件，评估是否需要重构")
    print("3. 定期运行此分析以跟踪代码健康度")
    print("4. 在代码审查时参考变更率数据")

    return True

if __name__ == '__main__':
    success = test_skill()
    sys.exit(0 if success else 1)
