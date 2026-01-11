# Dataset: Mapping the Pitch Range of Cello Parts in 55 Sonatas (1725-1938)

## Description
This dataset contains pitch extremes and pitch range (ambitus) for the cello part of 55 cello sonatas based on score analysis. Data includes per-movement and total values for lowest pitch, highest pitch and ambitus, and score metadata such as composer, year, and accompaniment instrument, as well as a permalink to the score file on IMSLP and a specification of the treble clef octave used in the analysis of the score if applicable.

In `wideformat_data_cellosonatas.csv` (wide format), each row represents one work, providing a compact overview of the data. 

In `longformat_data_cellosonatas.csv` (long format), the wide dataset has been transformed into a long format with five rows per sonata: Four rows corresponding to each of the movements of the sonata (with empty cells if the work consists of less than four movements), and a fifth row for the pitch extremes and range across the sonata in total. The long format improves the usability of the dataset for statistical modeling and visualization.

## Column index:
* year: Year of composition
* composer: Composer name
* title: Work title (with sonata number in parentheses if part of a published collection of sonatas)
* accompaniment: Instrument accompanying the cello; either "piano" or "continuo"
* movements: Total number of movements in the work
* permalink: Link to the specific score file used in the analysis
* trebleclef: Specifies whether treble clefs in the piece are read at written pitch ("Loco") or down an octave ("8vb"). "None" if no treble clefs occur in the cello part
* tempo: The tempo indication for each movement as given in the score. "N/A" if none is given
* minSPN / maxSPN: Lowest/highest pitch in Scientific Pitch Notation
* minMIDI / maxMIDI: Lowest/highest pitch in MIDI note numbers
* ambitus: Pitch range in semitones. Equal to the difference between minMIDI and maxMIDI

Specific to wide format:
* "\_X" and "\_work" suffixes indicate whether the variable in question applies to a specific movement number X or to the work in its entirety. Example: "minSPN\_1" column contains the lowest pitch (SPN) of the first movement of each work

Specific to long format:
* scope: Similarly to "\_X" and "\_work", the scope index indicates whether values in each row apply to only a specific movement of the sonata (scope values 1-4 corresponding to the movement number) or to the work in total (scope value 5)

## Units and conventions
* Ambitus is expressed in semitones 

* Pitch representation follows international conventions:
  * Scientific Pitch Notation (SPN): Middle C = C4
  * MIDI note numbers: Middle C = MIDI 60

## Methodological notes
* In the score analysis, treble clefs were interpreted either at written pitch or down an octave based on musical context, cello idiomaticity and comparison with performance recordings.
* Pitch measurements include the resulting pitches of any notated natural or artificial harmonics.

## Encoding
The CSV files are UTF-8 encoded and use semicolons as delimiter

## License
CC BY 4.0 (https://creativecommons.org/licenses/by/4.0/)

## Contact
Tin Vinkler Risvig

Email: <trisvi23@student.aau.dk>  or  <tinrisvig@gmail.com>
