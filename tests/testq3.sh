#!/bin/bash

# Automatically detect question number from script name (testqX.sh)
num=$(basename "$0" | grep -o -E '[0-9]+')
SRC="./src/q${num}.c"

# 1. Remove all comments (single-line // and block /* ... */)
code_no_comments=$(sed -E '
  s://.*$::g;               # remove // comments
  :a; /\/*/{N; s:/\*.*\*/::; ba;}  # remove /* ... */ comments (multi-line)
' "$SRC")

# 2. Check if file (after removing comments) has any code left
if ! echo "$code_no_comments" | grep -q '[^[:space:]]'; then
    echo "❌ q${num}.c is empty or only contains comments"
    exit 0
fi

# 3. Try to compile
gcc "$SRC" -o "q${num}.out" 2> compile.log
if [ $? -ne 0 ]; then
    echo "❌ Compilation failed for q${num}.c"
    cat compile.log
else
    echo "✅ Compilation successful for q${num}.c"
fi

# Cleanup
rm -f "q${num}.out" compile.log
exit 0
