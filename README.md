## Overview

The `script-RCB.com-XXX*` are template CSH scripts for TS runs which contain dummy variables that need to be replaced according to the desired parameters. This is done by a Bash script, `loop.sh`. The table below summarizes these variable strings and what they represent.

| Variable | Description |
|----------|----------|
|   N_FILE  |   Two-digit integer representing Nitrogen abundance for the filename (ex. 88 for 8.8)  |
|   O_FILE  |   Same as above, for Oxygen  |
|   NABUND  |   Actual abundance in decimal form, with one decimal place  |
|   OABUND  |   Same as above, for Oxygen  |
|   CRAT, ORAT  |   C12/C13, O16/O18 ratios (decimal value)  |
|   C12FRAC, O16FRAC etc.  |   Overall fractions of the respective isotopes  | 
|   DLAM  |   Lambda step value  |
|   TVEL  |   Turbulence velocity - models are created only for 1.0 km/s, but this can be modified in TS (?)  |
|   LOGG  |   log(g) value - can only be 0.5 and 1.0 (restricted by models), and GH 2009 uses 0.5   |

A few of these are new, while most of them are renamed versions of the old variables in order to make them more easy to understand. 

The other major change I have done is to use a Bash script to do these substitutions - at least on my machine, the CSH substituting script was extremely slow for what it actually does. This Bash version is instant. It also includes computation of the isotope fractions on the fly using `awk`, instead of relying on a look-up table. This means that arbitrary isotopic ratios can be provided and it computes the fractions on the fly without any other user input. This might have to be modified in the future to include O17 abundances - as of now that is 0.

I have also modified the paths and some cd commands to match my directory structure.