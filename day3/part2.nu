let input_rows = open input.txt | lines

def "str get" [index] {
  $in | str substring $index..$index
}

def "calc mode at" [index, --antimode] {
  let mode = $in |
    each {|row| $row | str get $index} |
    into int |
    math mode |
    math max

  if $antimode {
    $mode | into bool | not $in | into int
  } else {
    $mode
  }
}

def "calc rating" [--antimode] {
  mut rating_rows = $in
  mut index = 0

  while ($rating_rows | length) > 1 {
    let rating_mode = $rating_rows | calc mode at $index --antimode=$antimode | into string
    $rating_rows = ($rating_rows | where ($it | str get $index) == $rating_mode )
    $index += 1
  }
  $rating_rows | str join | into int --radix 2
}

let O2_rating = $input_rows | calc rating
let CO2_rating = $input_rows | calc rating --antimode

$O2_rating * $CO2_rating
