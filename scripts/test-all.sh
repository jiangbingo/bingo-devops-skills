#!/bin/bash
#
# 统一测试脚本 - 运行所有 skills 的测试
# 用途: CI/CD 流程或本地测试所有技能
#

set -e  # 遇到错误立即退出

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 计数器
TOTAL_TESTS=0
PASSED_TESTS=0
FAILED_TESTS=0
SKIPPED_TESTS=0

# 测试结果数组
declare -a PASSED_SKILLS
declare -a FAILED_SKILLS
declare -a SKIPPED_SKILLS

# 创建测试结果目录
TEST_RESULTS_DIR="test-results"
mkdir -p "$TEST_RESULTS_DIR"

# 测试摘要文件
SUMMARY_FILE="$TEST_RESULTS_DIR/summary.txt"
echo "测试执行摘要 - $(date)" > "$SUMMARY_FILE"
echo "=================================" >> "$SUMMARY_FILE"
echo "" >> "$SUMMARY_FILE"

# 打印带颜色的消息
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[PASS]${NC} $1"
}

print_error() {
    echo -e "${RED}[FAIL]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

# 打印标题
print_header() {
    echo ""
    echo "=========================================="
    echo "  Bingo DevOps Skills - 自动化测试套件"
    echo "=========================================="
    echo ""
    print_info "开始时间: $(date)"
    print_info "Python 版本: $(python --version)"
    print_info "工作目录: $(pwd)"
    echo ""
}

# 测试单个 skill
test_skill() {
    local skill_dir="$1"
    local skill_name=$(basename "$skill_dir")
    local test_script="$skill_dir/test_skill.py"

    TOTAL_TESTS=$((TOTAL_TESTS + 1))

    print_info "正在测试: $skill_name"

    # 检查测试脚本是否存在
    if [ ! -f "$test_script" ]; then
        print_warning "$skill_name - 没有测试脚本，跳过"
        SKIPPED_TESTS=$((SKIPPED_TESTS + 1))
        SKIPPED_SKILLS+=("$skill_name")
        echo "[$skill_name] SKIPPED - No test script" >> "$SUMMARY_FILE"
        return 0
    fi

    # 创建测试日志文件
    local test_log="$TEST_RESULTS_DIR/${skill_name}.log"

    # 运行测试
    if python "$test_script" > "$test_log" 2>&1; then
        print_success "$skill_name - 测试通过"
        PASSED_TESTS=$((PASSED_TESTS + 1))
        PASSED_SKILLS+=("$skill_name")
        echo "[$skill_name] PASSED" >> "$SUMMARY_FILE"
        return 0
    else
        print_error "$skill_name - 测试失败"
        FAILED_TESTS=$((FAILED_TESTS + 1))
        FAILED_SKILLS+=("$skill_name")
        echo "[$skill_name] FAILED" >> "$SUMMARY_FILE"
        echo "错误日志:" >> "$SUMMARY_FILE"
        tail -20 "$test_log" >> "$SUMMARY_FILE"
        echo "" >> "$SUMMARY_FILE"
        return 1
    fi
}

# 打印测试摘要
print_summary() {
    echo ""
    echo "=========================================="
    echo "  测试执行摘要"
    echo "=========================================="
    echo ""
    print_info "结束时间: $(date)"
    echo ""
    echo "统计信息:"
    echo "  总计测试: $TOTAL_TESTS"
    print_success "  通过测试: $PASSED_TESTS"
    if [ $FAILED_TESTS -gt 0 ]; then
        print_error "  失败测试: $FAILED_TESTS"
    else
        echo "  失败测试: $FAILED_TESTS"
    fi
    if [ $SKIPPED_TESTS -gt 0 ]; then
        print_warning "  跳过测试: $SKIPPED_TESTS"
    else
        echo "  跳过测试: $SKIPPED_TESTS"
    fi
    echo ""

    # 显示通过的 skills
    if [ ${#PASSED_SKILLS[@]} -gt 0 ]; then
        print_success "通过的 Skills:"
        for skill in "${PASSED_SKILLS[@]}"; do
            echo "  ✓ $skill"
        done
        echo ""
    fi

    # 显示失败的 skills
    if [ ${#FAILED_SKILLS[@]} -gt 0 ]; then
        print_error "失败的 Skills:"
        for skill in "${FAILED_SKILLS[@]}"; do
            echo "  ✗ $skill"
        done
        echo ""
        print_info "查看详细日志: $TEST_RESULTS_DIR/<skill_name>.log"
        echo ""
    fi

    # 显示跳过的 skills
    if [ ${#SKIPPED_SKILLS[@]} -gt 0 ]; then
        print_warning "跳过的 Skills:"
        for skill in "${SKIPPED_SKILLS[@]}"; do
            echo "  ○ $skill"
        done
        echo ""
    fi

    echo "测试结果保存在: $TEST_RESULTS_DIR/"
    echo "摘要文件: $SUMMARY_FILE"
    echo ""
}

# 主测试流程
main() {
    print_header

    # 查找所有 skill 目录
    print_info "扫描 skills 目录..."
    SKILL_DIRS=()
    while IFS= read -r -d '' dir; do
        # 检查是否包含 test_skill.py
        if [ -f "$dir/test_skill.py" ] || [ -d "$dir" ]; then
            SKILL_DIRS+=("$dir")
        fi
    done < <(find skillsets -mindepth 1 -maxdepth 1 -type d -print0)

    # 按名称排序
    IFS=$'\n' SKILL_DIRS=($(sort <<<"${SKILL_DIRS[*]}"))
    unset IFS

    print_info "找到 ${#SKILL_DIRS[@]} 个 skill 目录"
    echo ""

    # 遍历并测试每个 skill
    for skill_dir in "${SKILL_DIRS[@]}"; do
        test_skill "$skill_dir"
    done

    # 打印摘要
    print_summary

    # 返回适当的退出码
    if [ $FAILED_TESTS -gt 0 ]; then
        print_error "有 $FAILED_TESTS 个测试失败"
        exit 1
    elif [ $TOTAL_TESTS -eq 0 ]; then
        print_warning "没有找到任何测试"
        exit 0
    else
        print_success "所有测试通过!"
        exit 0
    fi
}

# 执行主函数
main
