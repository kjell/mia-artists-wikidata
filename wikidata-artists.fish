cat ~/tmp/collection/artist-plus-object-id.txt \
  | csvcut -c1 \
  | sort \
  | uniq \
  | grep -v '""' \
  | grep -v 'Artist Unknown' \
| while read artist
  echo $artist >&2
  set escapedArtist (echo $artist | sed 's/ /%20/g')
  curl --silent 'https://www.wikidata.org/w/api.php?action=wbsearchentities&format=json&language=en&search='$escapedArtist \
  | jq --arg artist $artist '{key: $artist, value: {artist: $artist, wikidata: .search[0]}}'
end | jq -s 'from_entries'
