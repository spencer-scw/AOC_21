let depths = open input.txt | lines | into int

let original = $depths | wrap original
let offset = $depths | prepend nan | wrap offset

let diffed = $original |
  merge $offset |
  upsert diff {|row| $row.original - $row.offset}

$diffed.diff |
  reduce --fold 0 {|it, acc| if $it > 0 {$acc + 1} else {$acc}}

