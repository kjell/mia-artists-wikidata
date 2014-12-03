artists-plus-object-id.txt:
	find ../collection/objects -name "*.json" \
	| xargs cat \
	| jq -r '[.artist, .id] | @csv' \
	| sed 's|http://api.artsmia.org/objects/||' \
  > artist-plus-object-id.txt
