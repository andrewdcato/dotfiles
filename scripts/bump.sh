#!/usr/bin/env bash
function bump {
	output=$(npm version ${release} --no-git-tag-version)
	version=${output:1}
	search='("version":[[:space:]]*").+(")'
	replace="\1${version}\2"

	sed -i ".tmp" -E "s/${search}/${replace}/g" "$1"
	rm "$1.tmp"
}

function help {
	echo "Usage: $(basename $0) [<newversion> | major | minor | patch | premajor | preminor | prepatch | prerelease]"
}

if [ -z "$1" ] || [ "$1" = "help" ]; then
	help
	exit
fi

release=$1

if [ -d ".git" ]; then
	changes=$(git status --porcelain)

	if [ -z "${changes}" ]; then
		bump "package.json"
		git add package*.json
		git commit -m "chore: bump app version to ${version}"
	else
		echo "Please commit staged files prior to bumping"
	fi
else
	bump "package.json"
fi
