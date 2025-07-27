#!/bin/bash
# Quick test script for zs functionality

set -e

echo "Testing zs installation and functionality..."
echo ""

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

# Test counter
TESTS_PASSED=0
TESTS_FAILED=0

# Test function
test_case() {
  local name="$1"
  local command="$2"
  
  echo -n "Testing: $name... "
  if eval "$command" &>/dev/null; then
    echo -e "${GREEN}✓${NC}"
    ((TESTS_PASSED++))
  else
    echo -e "${RED}✗${NC}"
    ((TESTS_FAILED++))
  fi
}

# Create test directory
TEST_DIR=$(mktemp -d)
cd "$TEST_DIR"

# Test 1: Script syntax
test_case "Bash syntax validation" "bash -n $OLDPWD/src/zs"

# Test 2: Help command
export ZS_CONFIG_DIR="$OLDPWD"
test_case "Help command" "$OLDPWD/src/zs help | grep -q 'Zed Smart Setup'"

# Test 3: Version command
test_case "Version command" "$OLDPWD/src/zs version | grep -q 'version'"

# Test 4: Rails project detection
mkdir -p rails-test && cd rails-test
echo 'source "https://rubygems.org"' > Gemfile
test_case "Rails project detection" "ZS_CONFIG_DIR=$OLDPWD $OLDPWD/src/zs"
cd ..

# Test 5: React project detection
mkdir -p react-test && cd react-test
echo '{"dependencies":{"react":"^18.0.0"}}' > package.json
test_case "React project detection" "ZS_CONFIG_DIR=$OLDPWD $OLDPWD/src/zs"
cd ..

# Test 6: Python project detection
mkdir -p python-test && cd python-test
echo "flask==2.0.0" > requirements.txt
test_case "Python project detection" "ZS_CONFIG_DIR=$OLDPWD $OLDPWD/src/zs"
cd ..

# Cleanup
cd "$OLDPWD"
rm -rf "$TEST_DIR"

# Results
echo ""
echo "Test Results:"
echo -e "${GREEN}Passed: $TESTS_PASSED${NC}"
if [[ $TESTS_FAILED -gt 0 ]]; then
  echo -e "${RED}Failed: $TESTS_FAILED${NC}"
  exit 1
else
  echo -e "${GREEN}All tests passed!${NC}"
fi