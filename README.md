# Dataset: Mapping the Pitch Range of Cello Parts in 55 Sonatas (1725-1938)

## Description
This dataset contains pitch extremes and pitch range (ambitus) for the cello part of 55 cello sonatas based on score analysis. Data includes per-movement and total values for lowest pitch, highest pitch and ambitus, and score metadata such as composer, year, and accompaniment instrument, as well as a permalink to the score file on IMSLP and a specification of the treble clef octave reading used in the analysis of the score.

In `wideformat_data_cellosonatas.csv` (wide format), each row represents one work, providing a compact overview of the data. 

In `longformat_data_cellosonatas.csv` (long format), the wide dataset has been transformed into a long format with five rows per sonata: Four rows corresponding to each of the movements of the sonata (with empty cells if the work consists of less than four movements), and a fifth row for the pitch extremes and range across the sonata in total. The long format facilitates statistical modelling and visualization.

For reproducibility, the VBA script used for automated SPN to MIDI conversion is included as `SPNtoMIDI.cls`. See *SPN to MIDI conversion* below for usage instructions.

## Column index:
* **year**: Year of composition
* **composer**: Composer name
* **title**: Work title (with sonata number in parentheses if part of a published collection)
* **accompaniment**: Accompanying instrument; either "piano" or "continuo"
* **movements**: Total number of movements in the work
* **permalink**: Link to the specific score file used in the analysis
* **trebleclef**: Specifies whether treble clefs in the piece are read at written pitch ("Loco") or down an octave ("8vb"). "None" if the cello part contains no treble clefs
* **tempo**: Tempo indication per movement ("N/A" if not provided in the score)
* **minSPN** / **maxSPN**: Lowest/highest pitch in Scientific Pitch Notation
* **minMIDI** / **maxMIDI**: Lowest/highest pitch in MIDI note numbers
* **ambitus**: Pitch range in semitones ( = maxMIDI - minMIDI )

Wide format:
* "\_X" and "\_work" suffixes indicate whether a variable refers to movement number X or the work as a whole. Example: "minSPN\_1" column contains the lowest pitch (SPN) of the first movement of each work

Long format:
* scope indicates whether a row refers to a specific movement (1-4) or the work total (5).

## Units and pitch notation
* Ambitus is expressed in semitones.

* Pitch notation:
  * Scientific Pitch Notation (SPN): Middle C = C4
  * MIDI note numbers: Middle C = MIDI 60

## Methodological notes
* In the score analysis, treble clefs were read either at written pitch or down an octave based on musical context, cello idiomaticity and comparison with performance recordings.
* Pitch measurements include the sounding result of notated natural and artificial harmonics.

## SPN to MIDI conversion
To automate the conversion of pitches to MIDI note numbers, a VBA script was used (`SPNtoMIDI.cls`). To activate the script, import `SPNtoMIDI.cls` into a macro-enabled Excel workbook (.xlsm) and transfer the code manually from the class module to the worksheet module. In a wide format dataset (one work per row), the lowest pitch (minSPN) of each movement is entered into columns I, O, U, AA, and the highest pitch (maxSPN) into columns J, P, V, AB. The VBA script automatically converts all SPN notes in these columns to MIDI numbers (printed in the columns offset by +2) and computes the lowest and highest pitches for the work as a whole (columns AF, AG, AH, AI).

## Ambitus
Standard subtraction is used to calculate the ambitus of a movement or a work in semitones:

Ambitus = maxMIDI - minMIDI

E.g., typing `=L2-K2` into a cell of the worksheet will calculate the ambitus of the first movement of the work in row 2.

## Encoding
The CSV files are UTF-8 encoded and use semicolons as delimiter.

## Provenance
The VBA script was drafted with assistance from generative AI (Microsoft Copilot).

## License
CC BY 4.0 (https://creativecommons.org/licenses/by/4.0/)

## Contact
Tin Vinkler Risvig

Email: <trisvi23@student.aau.dk>  or  <tinrisvig@gmail.com>
