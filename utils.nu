#!/usr/bin/env nu

export def bootstrap [day: int] {
  mkdir $"day($day)"
  get input $day | save $"day($day)/input.txt"
  cd $"day($day)"
  touch part1.nu part2.nu test.txt
}

def "get input" [day: int] {
  open aoc-session.yml |
  http get $"($in.base-url)day/($day)/input" --headers ($in | select cookie)
}

export def "run day" [day: int part?: int] {
    cd $"day($day)"
    if $part != null {
      try { nu $"part($part).nu" } catch { |err| $err.msg }
    } else {
      glob $"part*.nu" | sort | each {|f| try { nu $f } catch { |err| $err.msg }}
    }
}

export def "iterate on day" [day: int part: int] {
    let path = $"day($day)"
    watch $path { |op| if $op == "Create" {run day $day $part }}
}
