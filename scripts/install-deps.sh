#!/bin/bash
#
# 依赖安装脚本 - 安装项目所需的所有依赖
# 用途: CI/CD 流程或本地环境设置
#

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 打印带颜色的消息
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[OK]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

# 检查命令是否存在
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# 主函数
main() {
    echo ""
    echo "=========================================="
    echo "  Bingo DevOps Skills - 依赖安装"
    echo "=========================================="
    echo ""

    # 检查 Python
    print_info "检查 Python 环境..."
    if command_exists python3; then
        PYTHON_VERSION=$(python3 --version)
        print_success "Python 已安装: $PYTHON_VERSION"
    else
        print_error "Python 3 未安装"
        print_info "请安装 Python 3.8 或更高版本"
        exit 1
    fi
    echo ""

    # 检查 pip
    print_info "检查 pip..."
    if command_exists pip3; then
        print_success "pip3 已安装"
    else
        print_error "pip3 未安装"
        exit 1
    fi
    echo ""

    # 升级 pip
    print_info "升级 pip 到最新版本..."
    python3 -m pip install --upgrade pip >/dev/null 2>&1
    print_success "pip 已升级"
    echo ""

    # 安装测试依赖
    print_info "安装测试依赖..."
    pip3 install pytest pytest-cov pytest-html >/dev/null 2>&1
    print_success "测试依赖已安装"
    echo ""

    # 检查 Git
    print_info "检查 Git..."
    if command_exists git; then
        GIT_VERSION=$(git --version)
        print_success "Git 已安装: $GIT_VERSION"
    else
        print_warning "Git 未安装（某些 skills 可能需要 Git）"
    fi
    echo ""

    # 检查 gh CLI（可选）
    print_info "检查 GitHub CLI..."
    if command_exists gh; then
        GH_VERSION=$(gh --version)
        print_success "GitHub CLI 已安装: $GH_VERSION"
    else
        print_warning "GitHub CLI 未安装（github-repo-analyzer skill 需要）"
        print_info "安装命令: brew install gh (macOS) 或 conda install gh -c conda-forge"
    fi
    echo ""

    # 检查其他可选工具
    print_info "检查其他可选工具..."

    # bc（用于计算）
    if command_exists bc; then
        print_success "bc 已安装"
    else
        print_warning "bc 未安装（某些脚本可能需要）"
    fi
    echo ""

    # 项目特定的依赖检查
    print_info "检查项目特定依赖..."

    # 检查是否有 requirements.txt
    if [ -f "requirements.txt" ]; then
        print_info "安装 requirements.txt 中的依赖..."
        pip3 install -r requirements.txt >/dev/null 2>&1
        print_success "requirements.txt 依赖已安装"
    else
        print_info "没有找到 requirements.txt"
    fi
    echo ""

    # 验证安装
    print_info "验证安装..."
    python3 -c "import sys; print(f'Python 版本: {sys.version}')" >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        print_success "Python 环境验证通过"
    else
        print_error "Python 环境验证失败"
        exit 1
    fi
    echo ""

    # 完成
    echo "=========================================="
    print_success "依赖安装完成！"
    echo "=========================================="
    echo ""
    print_info "已安装的组件:"
    echo "  - Python 3"
    echo "  - pip"
    echo "  - pytest"
    echo "  - pytest-cov"
    echo "  - pytest-html"
    echo ""
    print_info "可选组件（如需要请手动安装）:"
    echo "  - GitHub CLI (gh)"
    echo "  - bc (计算器)"
    echo ""
}

# 执行主函数
main
