let instructions = open input.txt | lines | split column ' ' | rename direction distance | into int distance

$instructions | reduce -f {horizontal: 0, vertical: 0, aim: 0} {
  |elt, acc| match $elt.direction {
    forward => {
      horizontal: ($acc.horizontal + $elt.distance),
      vertical: ($acc.vertical + $acc.aim * $elt.distance),
      aim: $acc.aim
    },
    down => {
      horizontal: $acc.horizontal,
      vertical: $acc.vertical,
      aim: ($acc.aim + $elt.distance)
    },
    up => {
      horizontal: $acc.horizontal,
      vertical: $acc.vertical,
      aim: ($acc.aim - $elt.distance)
    },
  }
} | ($in.horizontal * $in.vertical)
