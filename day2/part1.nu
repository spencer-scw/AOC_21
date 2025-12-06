let instructions = open input.txt | lines | split column ' ' | rename direction distance | into int distance

$instructions | reduce -f {horizontal: 0, vertical: 0} {
  |elt, acc| match $elt.direction {
    forward => {
      horizontal: ($acc.horizontal + $elt.distance),
      vertical: $acc.vertical
    },
    down => {
      horizontal: $acc.horizontal,
      vertical: ($acc.vertical + $elt.distance)
    },
    up => {
      horizontal: $acc.horizontal,
      vertical: ($acc.vertical - $elt.distance)
    },
  }
} | values | math product
