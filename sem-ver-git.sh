#!/bin/sh

branch=$(git branch --show-current)

if [ "$branch" = "master" ]; then
	# Get the latest tag on the master branch
	latest_tag=$(git describe --abbrev=0 --tags)

	if [ -z "$latest_tag" ]; then
		new_tag="1.0.0"
	else
	# Parse the MAJOR, MINOR, and PATCH numbers from the latest tag
		major=$(echo "$latest_tag" | cut -d. -f1)
		minor=$(echo "$latest_tag" | cut -d. -f2)
		patch=$(echo "$latest_tag" | cut -d. -f3)
	
		# Increment the appropriate version number based on the type of change
		commit_message=$(git log -1 --pretty=%B)

		if echo "$commit_message" | grep -q '^feat:'; then
			major=$((major + 1))
			minor=0
			patch=0
		elif echo "$commit_message" | grep -q '^fix:'; then
			minor=$((minor + 1))
			patch=0
		else
			patch=$((patch + 1))
		fi

		# Create the new SemVer tag and push it to the Git repository
		new_tag="$major.$minor.$patch"
	fi

	git tag "$new_tag"
	git push origin "$new_tag"
fi

