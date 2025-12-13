# Dataset: Mapping the Pitch Range of Cello Parts in 55 Sonatas (1725-1938)

## Description
This dataset contains pitch extremes and pitch range (ambitus) for the cello parts of 55 cello sonatas based on score analysis. Each row represents one work. Data includes per-movement and total values for lowest pitch, highest pitch and ambitus; metadata from International Music Score Library Project (IMSLP) such as composer, year, and accompaniment instrument, as well as a permalink to the score file on IMSLP and a mention of treble clef transposition if applicable.

## Columns
* year: Year of composition
* composer: Composer name
* title: Work title
* accompaniment: Instrument accompanying the cello
* movements: Number of movements in the work
* permalink: Link to the specific score file used in the analysis
* trebleclef: Specifies whether treble clefs are interpreted at written pitch ("Loco") or down an octave ("8vb"). Empty cell if no treble clefs occur
* minSPN\_X / maxSPN\_X: Lowest/highest pitch in Scientific Pitch Notation for movement X
* minMIDI\_X / maxMIDI\_X: Lowest/highest pitch in MIDI note numbers for movement X
* ambitus\_X: Ambitus for movement X. Calculated by subtracting minMIDI\_X from maxMIDI\_X
* minMIDI\_work / maxMIDI\_work / ambitus\_work: Values for entire work

## Units and conventions
* Ambitus is expressed in semitones

* Pitch representation follows international conventions:
  * Scientific Pitch Notation (SPN): Middle C = C4
  * MIDI note numbers: Middle C = MIDI 60

## Methodological notes
* Harmonics are included only if pitch is notated explicitly in the score.
* In the score analysis, treble clefs were interpreted either at written pitch or down an octave based on musical context, cello idiomaticity and comparison with performance recordings.

## License
CC BY 4.0 (https://creativecommons.org/licenses/by/4.0/)

## Contact
Tin Vinkler Risvig

Email: trisvi23@student.aau.dk  or  tinrisvig@gmail.com
