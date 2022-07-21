#!/usr/bin/env -S awk -f
NR == 1 { printf "%s", $0; print " Vo2/g  O2"; next }
NF == 0 || done { done = 1; print; next }
NF == 3 {
  table[$1]["v/g"] = $2
  table[$1]["v/vo2"] = $3
  table[$1]["vo2/g"] = $2 / $3
  printf "%-40s", $0
  printf "%.4f\n", table[$1]["vo2/g"]
  next
}
NF == 4 {
  table[$1]["v/g"] = $2
  table[$1]["v/vo2"] = $3
  table[$1]["vo2/g"] = $2 / $3
  table[$1]["avgmass"] = $4
  table[$1]["o2/min"] = $4 * table[$1]["vo2/g"]
  printf "%-40s", $0
  printf "%.4f %.4f\n", table[$1]["vo2/g"], table[$1]["o2/min"]
  next
}
{ print; next }

END {
  print "Mice / Human  =", table["Mouse"]["o2/min"] / table["Human"]["o2/min"]
  print "Humen / Mouse =", table["Human"]["o2/min"] / table["Mouse"]["o2/min"]
}
