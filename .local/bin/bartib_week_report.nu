#!/usr/bin/nu

def get_week_mon [x: datetime] {
  let day_of_week = ($x | format date "%u") | into int | into duration -u day
  $x - $day_of_week + 1day
}

def bartib_report [x: datetime] {
    bartib report -d ( $x | format date "%Y-%m-%d") 
      | sed -e 's/\x1b\[[0-9;]*m//g'
      | lines 
      | parse --regex '^(?P<project>\w+)\.*\s?(?P<summ>.+)$'
      | each {|a| 
        upsert summ ($a.summ 
          | str replace 'h' 'hr' 
          | str replace 'm' 'min' 
          | str replace 's' 'sec' 
          | str replace '<1min' '0min' 
          | into duration 
        )
      }
      | reduce -f {} {|it, acc| $acc
        | upsert Date $x
        | upsert $it.project $it.summ 
      }

}

def main [x?: datetime, --human (-h), --csv (-c)] {
  let mon = if ($x != null) {
    get_week_mon $x
  } else {
    get_week_mon (date now)
  }
  let report = 0..6 | each {
    let dur = $in | into duration -u day
    let on = ($mon + $dur)
    bartib_report $on
  }
  let refined = $report
    | columns
    | each {|it|
      {name: $it, order: (
        if $it == "Date" { -1 } 
        else if $it == "Total" { 1 } 
        else { 0 } ) }
    }
    | sort-by order
    | get name
    | reduce -f $report { |it,acc| 
      $acc
        | each { |r| 
          if ($r | get -i $it | default null) != null { $r | reject $it } else { $r }
          | insert $it ($r | get -i $it | default null) }
    } 
  if $human {
    let formatted = $refined
      | each { |it| $it | upsert Date ( $it | get Date | format date "%Y-%m-%d %a" ) }
      if $csv {
        $formatted | to csv
      } else {
        $formatted
      }
  } else {
    if $csv {
      $refined | to csv
    } else {
      $refined
    }
  }
}
