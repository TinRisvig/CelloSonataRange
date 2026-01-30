VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Ark1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Function SPNtoMIDI(note As String) As Variant
    Dim baseNote As String
    Dim accidental As String
    Dim octave As Integer
    Dim noteNumber As Integer
    Dim noteMap As Object
    Set noteMap = CreateObject("Scripting.Dictionary")
    
    noteMap.Add "C", 0
    noteMap.Add "D", 2
    noteMap.Add "E", 4
    noteMap.Add "F", 5
    noteMap.Add "G", 7
    noteMap.Add "A", 9
    noteMap.Add "B", 11

    note = UCase(Trim(note))
    
    If Len(note) < 2 Then
        SPNtoMIDI = CVErr(xlErrValue)
        Exit Function
    End If

    baseNote = Left(note, 1)
    Dim i As Integer: i = 2
    accidental = ""
    
    Do While Mid(note, i, 1) = "#" Or Mid(note, i, 1) = "B"
        accidental = accidental & Mid(note, i, 1)
        i = i + 1
    Loop

    If Not noteMap.Exists(baseNote) Then
        SPNtoMIDI = CVErr(xlErrValue)
        Exit Function
    End If

    On Error GoTo InvalidNote
    octave = CInt(Mid(note, i))
    On Error GoTo 0

    noteNumber = noteMap(baseNote)
    
    Dim j As Integer
    For j = 1 To Len(accidental)
        If Mid(accidental, j, 1) = "#" Then
            noteNumber = noteNumber + 1
        ElseIf Mid(accidental, j, 1) = "B" Then
            noteNumber = noteNumber - 1
        End If
    Next j

    SPNtoMIDI = (octave + 1) * 12 + noteNumber
    Exit Function

InvalidNote:
    SPNtoMIDI = CVErr(xlErrValue)
End Function

Private Sub Worksheet_Change(ByVal Target As Range)
    ' Code doesn't run when rows and columns are selected/inserted. Improves performance.
    If Target.Cells.CountLarge > 100 Then GoTo ExitHandler
    
    On Error GoTo ExitHandler
    Dim cell As Range

    Application.EnableEvents = False

    For Each cell In Target
        If cell.Row > 1 Then

            ' SPNtoMIDI: Converts SPN values of columns I, J, O, P, U, V, AA, AB to MIDI-numbers
            Select Case cell.Column
                Case 9, 10, 15, 16, 21, 22, 27, 28 ' The columns in question
                    If Len(CStr(cell.Value2)) > 0 Then
                        ' Print the resulting MIDI-number 2 columns further ahead:
                        cell.Offset(0, 2).Value = SPNtoMIDI(CStr(cell.Value2))
                    Else
                        ' Clear the corresponding MIDI-cell when SPN value is removed:
                        cell.Offset(0, 2).ClearContents
                    End If
            End Select


            ' Find the lowest note across the work (minMIDI_work) based on a comparison of per-movement minimum MIDI values in colums K, Q, W, AC
            ' Print minSPN_work in column AF and minMIDI_work in column AH
            Dim minVal As Variant, minCol As Long
            Dim checkColsMin As Variant: checkColsMin = Array(11, 17, 23, 29) ' columns K, Q, W, AC
            Dim satsMin As Collection: Set satsMin = New Collection
            Dim colIndex As Long, sNr As Long
            Dim v As Variant

            minVal = Empty: minCol = 0

            For colIndex = 0 To UBound(checkColsMin)
                sNr = colIndex + 1
                v = Cells(cell.Row, checkColsMin(colIndex)).Value2
                If Not IsError(v) Then
                    If Len(CStr(v)) > 0 And IsNumeric(v) Then
                        If IsEmpty(minVal) Then
                            minVal = CDbl(v)
                            minCol = checkColsMin(colIndex)
                            Set satsMin = New Collection
                            satsMin.Add sNr
                        ElseIf CDbl(v) < minVal Then
                            minVal = CDbl(v)
                            minCol = checkColsMin(colIndex)
                            Set satsMin = New Collection
                            satsMin.Add sNr
                        ElseIf CDbl(v) = minVal Then
                            satsMin.Add sNr
                        End If
                    End If
                End If
            Next colIndex

            If Not IsEmpty(minVal) And minCol > 2 Then
                Cells(cell.Row, 32).Value = Cells(cell.Row, minCol - 2).Value ' AF
                Cells(cell.Row, 34).Value = minVal                            ' AH
            Else
                Cells(cell.Row, 32).ClearContents
                Cells(cell.Row, 34).ClearContents
            End If

            ' Find the highest note across the work (maxMIDI_work) based on a comparison of per-movement maximum MIDI values in colums L, R, X, AD
            ' Print maxSPN_work in column AG and maxMIDI_work in column AI
            Dim maxVal As Variant, maxCol As Long
            Dim checkColsMax As Variant: checkColsMax = Array(12, 18, 24, 30) ' L, R, X, AD
            Dim satsMax As Collection: Set satsMax = New Collection

            maxVal = Empty: maxCol = 0

            For colIndex = 0 To UBound(checkColsMax)
                sNr = colIndex + 1
                v = Cells(cell.Row, checkColsMax(colIndex)).Value2
                If Not IsError(v) Then
                    If Len(CStr(v)) > 0 And IsNumeric(v) Then
                        If IsEmpty(maxVal) Then
                            maxVal = CDbl(v)
                            maxCol = checkColsMax(colIndex)
                            Set satsMax = New Collection
                            satsMax.Add sNr
                        ElseIf CDbl(v) > maxVal Then
                            maxVal = CDbl(v)
                            maxCol = checkColsMax(colIndex)
                            Set satsMax = New Collection
                            satsMax.Add sNr
                        ElseIf CDbl(v) = maxVal Then
                            satsMax.Add sNr
                        End If
                    End If
                End If
            Next colIndex

            If Not IsEmpty(maxVal) And maxCol > 2 Then
                Cells(cell.Row, 33).Value = Cells(cell.Row, maxCol - 2).Value ' AG
                Cells(cell.Row, 35).Value = maxVal                            ' AI
            Else
                Cells(cell.Row, 33).ClearContents
                Cells(cell.Row, 35).ClearContents
            End If
            

        End If
    Next cell

ExitHandler:
    Application.EnableEvents = True
End Sub
