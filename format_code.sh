# This script formats staged C++ and build files. Files that are already committed
# will not be checked. So please run this script before you commit your changes.
# In case you did commit them, you can use "git reset --soft HEAD~1" to undo the
# commit and commit again after formatting it.

set -e
set -o pipefail
trap 'kill $$' ERR

cd $1

ls_staged_files () {
  # Don't throw errors if egrep find no match.
  echo $(git ls-files | egrep $1 || true)
}

# Formatting cpp files using clang-format.
cpp_files=$(ls_staged_files "\.h|\.cc|\.cpp")
if [ "$cpp_files" ]; then
  clang-format -i -style=google $cpp_files
fi

# Formatting build files using buildifier.
build_files=$(ls_staged_files "WORKSPACE|*BUILD|*BUILD.bazel|*\.bzl")
if [ "$build_files" ]; then
  buildifier $build_files
fi

# Formatting Java files.
java_files=$(ls_staged_files "\.java")
if [ "$java_files" ]; then
  java -jar /app/google-java-format-1.7-all-deps.jar --replace  $java_files
fi


if [ $(git diff --name-only | wc -l) -ne 0 ]; then
  echo "Following files are not properly formatted, please undo your commit" \
       "and run format_code.sh."
  echo "Files: "
  git diff --name-only
  exit 1
fi
