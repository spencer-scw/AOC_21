let depths = open input.txt | lines | into int

def count_increases [depths] {
  let original = $depths | wrap original
  let offset = $depths | prepend nan | wrap offset

  let diffed = $original |
    merge $offset |
    upsert diff {|row| $row.original - $row.offset}

  $diffed.diff |
    reduce --fold 0 {|it, acc| if $it > 0 {$acc + 1} else {$acc}}
}


let original = $depths | prepend [nan nan] | wrap original
let off1 = $depths | prepend nan | append nan | wrap offset1
let off2 = $depths | append [nan nan] | wrap offset2


let sliding_windows = $original |
  merge $off1 |
  merge $off2 |
  upsert sum {|row| $row.original + $row.offset1 + $row.offset2}

count_increases $sliding_windows.sum

