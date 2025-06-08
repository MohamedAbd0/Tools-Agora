#!/bin/bash

# Agora Token Generator - Local Development Script
# This script helps with building and serving the Flutter web app locally

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if we're in the right directory
if [ ! -f "pubspec.yaml" ]; then
    print_error "pubspec.yaml not found. Please run this script from the example directory."
    exit 1
fi

# Function to check Flutter installation
check_flutter() {
    print_status "Checking Flutter installation..."
    if ! command -v flutter &> /dev/null; then
        print_error "Flutter is not installed or not in PATH"
        print_status "Please install Flutter: https://flutter.dev/docs/get-started/install"
        exit 1
    fi
    
    flutter --version
    print_success "Flutter is installed"
}

# Function to enable web support
enable_web() {
    print_status "Enabling Flutter web support..."
    flutter config --enable-web
    print_success "Web support enabled"
}

# Function to get dependencies
get_dependencies() {
    print_status "Getting dependencies for main package..."
    cd ..
    flutter pub get
    cd example
    
    print_status "Getting dependencies for example..."
    flutter pub get
    print_success "Dependencies installed"
}

# Function to build for GitHub Pages
build_github_pages() {
    print_status "Building for GitHub Pages..."
    flutter build web \
        --release \
        --web-renderer html \
        --base-href "/Tools-Agora/" \
        --dart-define=FLUTTER_WEB_USE_SKIA=false
    
    print_success "Build completed! Files are in build/web/"
    print_status "You can now deploy the contents of build/web/ to GitHub Pages"
}

# Function to build for local development
build_local() {
    print_status "Building for local development..."
    flutter build web \
        --release \
        --web-renderer html
    
    print_success "Local build completed! Files are in build/web/"
}

# Function to run development server
run_dev() {
    print_status "Starting development server..."
    print_warning "This will start the Flutter development server."
    print_status "The app will be available at: http://localhost:8080"
    print_status "Press Ctrl+C to stop the server"
    
    flutter run -d chrome --web-port=8080
}

# Function to serve built files
serve_built() {
    print_status "Serving built files..."
    
    if command -v python3 &> /dev/null; then
        cd build/web
        print_status "Starting Python HTTP server on port 8080..."
        print_status "Visit: http://localhost:8080"
        python3 -m http.server 8080
    elif command -v python &> /dev/null; then
        cd build/web
        print_status "Starting Python HTTP server on port 8080..."
        print_status "Visit: http://localhost:8080"
        python -m SimpleHTTPServer 8080
    else
        print_error "Python not found. Please install Python or use 'flutter run -d chrome'"
        exit 1
    fi
}

# Function to run tests
run_tests() {
    print_status "Running tests..."
    flutter test
    print_success "Tests completed"
}

# Function to analyze code
analyze_code() {
    print_status "Analyzing code..."
    flutter analyze
    print_success "Code analysis completed"
}

# Function to show help
show_help() {
    echo "Agora Token Generator - Development Script"
    echo ""
    echo "Usage: $0 [COMMAND]"
    echo ""
    echo "Commands:"
    echo "  setup           Setup development environment"
    echo "  dev             Start development server"
    echo "  build           Build for local development"
    echo "  build-gh        Build for GitHub Pages deployment"
    echo "  serve           Serve built files locally"
    echo "  test            Run tests"
    echo "  analyze         Analyze code"
    echo "  clean           Clean build files"
    echo "  help            Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 setup         # Setup everything for development"
    echo "  $0 dev           # Start development server"
    echo "  $0 build-gh      # Build for GitHub Pages"
}

# Function to clean build files
clean_build() {
    print_status "Cleaning build files..."
    flutter clean
    rm -rf build/
    print_success "Build files cleaned"
}

# Function to setup development environment
setup_dev() {
    print_status "Setting up development environment..."
    check_flutter
    enable_web
    get_dependencies
    analyze_code
    print_success "Development environment setup completed!"
    print_status "Run '$0 dev' to start the development server"
}

# Main script logic
case "${1:-help}" in
    "setup")
        setup_dev
        ;;
    "dev")
        check_flutter
        get_dependencies
        run_dev
        ;;
    "build")
        check_flutter
        get_dependencies
        build_local
        ;;
    "build-gh")
        check_flutter
        get_dependencies
        build_github_pages
        ;;
    "serve")
        if [ ! -d "build/web" ]; then
            print_error "No build found. Run '$0 build' first."
            exit 1
        fi
        serve_built
        ;;
    "test")
        check_flutter
        get_dependencies
        run_tests
        ;;
    "analyze")
        check_flutter
        get_dependencies
        analyze_code
        ;;
    "clean")
        clean_build
        ;;
    "help"|*)
        show_help
        ;;
esac
