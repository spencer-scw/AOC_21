let depths = open input.txt |
  lines |
  split column '' -c |
  values

let modes = $depths |
  par-each {|depth| $depth | into int | math mode} |
  flatten

let gamma = $modes |
  str join |
  into int --radix 2  

let epsilon = $modes |
  into bool |
  each {|val| not $val} |
  into int |
  str join |
  into int --radix 2  

$gamma * $epsilon

