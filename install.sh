#!/usr/bin/env bash
# Copy the workflow template into a repo. Existing files are never overwritten.
#
# Usage: ./install.sh [--commit] <target-repo>
#   --commit   don't add the files to .gitignore (track them in git instead)

set -euo pipefail

usage() {
	echo "usage: $0 [--commit] <target-repo>" >&2
	exit 2
}

commit=false
target=""
for arg in "$@"; do
	case "$arg" in
	--commit) commit=true ;;
	-h | --help) usage ;;
	-*) echo "unknown option: $arg" >&2; usage ;;
	*)
		[[ -n "$target" ]] && usage
		target="$arg"
		;;
	esac
done
[[ -n "$target" ]] || usage

if [[ ! -d "$target" ]]; then
	echo "error: $target is not a directory" >&2
	exit 1
fi

template="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/template"
target="$(cd "$target" && pwd)"

copied=0
skipped=0
while IFS= read -r -d '' src; do
	rel="${src#"$template"/}"
	dst="$target/$rel"
	if [[ -e "$dst" ]]; then
		echo "skip    $rel (already exists)"
		skipped=$((skipped + 1))
	else
		mkdir -p "$(dirname "$dst")"
		cp "$src" "$dst"
		echo "create  $rel"
		copied=$((copied + 1))
	fi
done < <(find "$template" -type f -print0 | sort -z)

if [[ "$commit" == false ]]; then
	gitignore="$target/.gitignore"
	entries=("AGENTS.md" "CLAUDE.md" "docs/knowledge/" ".claude/")
	missing=()
	for e in "${entries[@]}"; do
		if [[ ! -f "$gitignore" ]] || ! grep -qxF "$e" "$gitignore"; then
			missing+=("$e")
		fi
	done
	if ((${#missing[@]} > 0)); then
		# Make sure the existing file ends with a newline before appending.
		if [[ -s "$gitignore" && -n "$(tail -c1 "$gitignore")" ]]; then
			echo >>"$gitignore"
		fi
		{
			echo
			echo "# AI assistant knowledge base and skills (local only)"
			printf '%s\n' "${missing[@]}"
		} >>"$gitignore"
		echo "update  .gitignore (${missing[*]})"
	fi
fi

echo
echo "Done: $copied created, $skipped skipped."
echo
echo "Next steps:"
echo "  1. Fill in the TODO placeholders in AGENTS.md (project summary, conventions, commands)."
echo "  2. Open Claude Code in the repo and run: /kickoff <topic>"
