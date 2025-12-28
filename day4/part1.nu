let input = open input.txt | lines

let sequence = $input | get 0 | split row ','

let boards = $input | skip 2 | split list '' | each {|in| $in | split words | each {|val| $val | into int}}

mut wins = $boards | each { |board|
  let rows = $board
  let cols = (0..4 | each { |i| $board | each { get $i } })
  [...$rows, ...$cols]
}

# sum all the win conditions for a board and see if any won
def "is winner" [] {
  ($in | each {math sum} | find (-5) | length) != 0
}

# $wins | each {is winner}

# for number in $sequence {}

def "mark number" [number: int] {
  $in | each { |board|
    $board | each { |row|
      $row | each { |item|
        if $item == $number {-1} else {$item}
      }
    }
  }
}

mut last_num = 0
for number in $sequence {
  $wins = $wins | mark number ($number | into int)
  if ($wins | each {is winner} | any {}) {
    $last_num = $number | into int
    break
  }
}

let $winning_board = $wins | each {is winner} | enumerate | where item | get index | $in.0

let board_sum = $wins |
  get $winning_board |
  first 5 | flatten |
  each {|it|
    if $it == (-1) {0} else { $it }
  } |
  math sum

$board_sum * $last_num
