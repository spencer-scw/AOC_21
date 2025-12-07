let input = open test.txt | lines

let sequence = $input | get 0 | split row ','

let boards = $input | skip 2 | split list '' | each {|in| $in | split words | each {|val| $val | into int}}

mut wins = $boards | each { |board|
  [
    ...($board)
    ...(0..4 | each {|index| $board | get $index})
  ]
}

# sum all the win conditions for a board and see if any won
def "is winner" [] {
  ($in | each {math sum} | find 0 | length) != 0
}

$wins | each {is winner}
