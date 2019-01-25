Option Explicit

' This is a sketch of what it may look like for Excel/VBA to have supercharged array processing capabilities.
' 
' Now, this is bad code for several reasons, including:
' 1. It won't work with the 2D arrays / scalars pulled from Excel cells.
' 2. It only works with 1D VBA arrays. So you probably can't use them as UDFs yet, and you'd probably get a lot more power when you can start controlling the rank of application.
'
' Other caveats:
' - no first-class functions in VBA - unsure how we'll do reductions like "+/"
' - VBA has no array penetration like the spreadsheet does (eg 1 + Array(1,2) <> Array(2,3)), so we may need to re-implement some primitives
' - many of these probably have perfectly fine analogues in the Excel world (eg count, sum, at; and range in the dynamic array future) - so query whether some of the fns below are necessary.
'
' Any improvements are most welcome.

Sub tests()

    ' match
    Debug.Assert 1 = match(Array(1, 2, 3), Array(1, 2, 3))
    Debug.Assert 0 = match(Array(1, 2, 3), Array(1, 2))
    Debug.Assert 0 = match(Array(1, 2, 3), Array(2, 2, 3))

    ' range
    Debug.Assert match(range(3), Array(0, 1, 2))

    ' sum
    Debug.Assert 3 = sum(range(3))
    
    ' count
    Debug.Assert 3 = count(range(3))

    ' where
    Debug.Assert 1 = match(Array(0, 2, 2, 3), where(Array(1, 0, 2, 1)))

    ' at
    Dim data As Variant: data = Array(1, 2, 3, 4)
    Dim indices As Variant: indices = Array(0, 2, 2, 3)
    Debug.Assert 1 = match(Array(1, 3, 3, 4), at(data, indices))
    
    ' asc
    Dim data2 As Variant: data2 = Array(2, 1, 4, 3)
    Debug.Assert match(asc(data2), Array(1, 0, 3, 2))
    
    ' reverse
    Debug.Assert 1 = match(Array(3, 4, 1, 2), reverse(data2))
    
    ' Some examples of combined use...
    
    ' "filter"
    Dim output As Variant
    output = at(data, where(Array(1, 0, 2, 1)))
    Debug.Assert 4 = count(output)
    Debug.Assert 3 = output(1)
    
    ' "sort"
    Dim e As Variant
    For Each e In at(data, asc(data))
        Debug.Print (e)
    Next
    
End Sub

Function match(arr1, arr2) As Integer
' TODO arbitrary nesting

    match = 1
    
    If UBound(arr1) <> UBound(arr2) Or LBound(arr1) <> LBound(arr2) Then
        GoTo exit_early
    End If
    
    Dim i As Long
    For i = LBound(arr1) To UBound(arr1)
        If arr1(i) <> arr2(i) Then GoTo exit_early
    Next
    
    Exit Function
    
exit_early: match = 0

End Function
    

Function sum(nums As Variant)
' TODO necessary?
    sum = WorksheetFunction.sum(nums)
End Function
    

Function count(arr As Variant)
    count = 1 + UBound(arr) - LBound(arr)
End Function
    

Function range(up_to_and_excl As Long) As Variant

    Dim arr As Variant
    ReDim arr(0 To -1 + up_to_and_excl)
    
    Dim i As Long
    For i = 0 To -1 + up_to_and_excl
        arr(i) = i
    Next
    
    range = arr

End Function


Function where(counts As Variant)

    Dim output() As Variant
    ReDim output(0 To -1 + sum(counts))

    Dim i As Long, j As Long, count As Long
    For i = 0 To UBound(counts)
        If counts(i) Then
            For count = 0 To -1 + counts(i)
                output(j) = i
                j = j + 1
            Next
        End If
    Next
    
    where = output
    
End Function


Function at(arr As Variant, indices As Variant)
' TODO can we replace with a WorksheetFunction.Index call?

    Dim output() As Variant
    ReDim output(LBound(indices) To UBound(indices))
    
    Dim i As Long
    For i = LBound(indices) To UBound(indices)
        output(i) = arr(indices(i))
    Next

    at = output

End Function


Function asc(arr As Variant)

    Dim output() As Variant
    ReDim output(LBound(arr) To UBound(arr))
    
    Dim i As Long, j As Long, elem As Variant, elem1 As Variant
    For Each elem In arr
        i = 0
        For Each elem1 In arr
            If elem > elem1 Then: i = i + 1
        Next
        output(j) = i
        j = j + 1
    Next
    
    asc = output

End Function


Function reverse(arr As Variant)

    Dim output As Variant
    ReDim output(LBound(arr) To UBound(arr))
    
    Dim i As Long
    For i = LBound(arr) To UBound(arr)
        output(i) = arr(UBound(arr) - i)
    Next
    
    reverse = output

End Function
