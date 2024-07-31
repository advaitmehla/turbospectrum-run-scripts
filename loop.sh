# !/bin/bash

dir="HD137613"
# if dir doesn't exist, create it
if [ ! -d "$dir" ]; then
  mkdir "$dir"
fi
list=$(ls script-RCB.com-XXX*)
nlist="85 94"  # N abundance
olist="88"
cratlist="20"  # C12/C13 ratio
oratlist="0.5" # O16/O18 ratio

tvel="7.0"
dlam="0.01"
logg="0.5"     # can only be 0.5 or 1.0


for file in $list; do
  echo "Processing file: $file"
  for o_file in $olist; do
    for orat in $oratlist; do
      for crat in $cratlist; do
        for n_file in $nlist; do
          # effectively convert the number to a string with a decimal point, i.e. 88 -> 8.8 etc.
          Nabund=$(echo "$n_file" | awk '{print substr($1,1,1)"."substr($1,2,1)}')
          Oabund=$(echo "$o_file" | awk '{print substr($1,1,1)"."substr($1,2,1)}')

          # Calculate oxygen isotope fractions directly with awk
          O16frac=$(awk "BEGIN {printf \"%.4f\", $orat / (1 + $orat)}")
          O18frac=$(awk "BEGIN {printf \"%.4f\", 1 / (1 + $orat)}")

          # Calculate carbon isotope fractions directly with awk
          C12frac=$(awk "BEGIN {printf \"%.4f\", $crat / (1 + $crat)}")
          C13frac=$(awk "BEGIN {printf \"%.4f\", 1 / (1 + $crat)}")

          temp=$(echo "$file" | cut -d _ -f 2)
          outputfile="script-RCB.com_O1618-${orat}_C1213-${crat}_N-${n_file}_O-${o_file}_${temp}"

          # Process and replace variables directly with awk in one step
          awk -v orat="$orat" -v crat="$crat" -v n_file="$n_file" -v Nabund="$Nabund" -v C12frac="$C12frac" -v C13frac="$C13frac" -v O16frac="$O16frac" -v O18frac="$O18frac" -v dlam="$dlam"  -v tvel="$tvel" -v logg="$logg" -v o_file="$o_file" -v Oabund="$Oabund" '{
              gsub("ORAT", orat); gsub("CRAT", crat); gsub("N_FILE", n_file); gsub("NABUND", Nabund);
              gsub("C12FRAC", C12frac); gsub("C13FRAC", C13frac); gsub("O16FRAC", O16frac); gsub("O18FRAC", O18frac);
              gsub("DLAM", dlam); gsub("TVEL", tvel); gsub("LOGG", logg); gsub("OABUND", Oabund); gsub("O_FILE", o_file);
              print
          }' "$file" > "$dir/$outputfile"

          chmod +x "$dir/$outputfile"
          rm -f o
        done
      done
    done
  done
done