' This is bad code for several reasons, including:
' 1. Types aren't very efficient - just getting something together quickly
' 2. It won't work with the 2d arrays / scalars pulled from Excel cells. It only works with 1D VBA arrays.

' Would also be nice to get iota, match ('deep equality'), grade, count...
' Could probably use count in impl of other functions, and match in testing.

Function where(flags As Variant)
' TODO should take n of the element, not just 1
' (ie flags can be >1)

    Dim output() As Variant
    ReDim output(0 To -1 + WorksheetFunction.Sum(flags))

    Dim i As Long, j As Long
    For i = 0 To UBound(flags)
        If flags(i) Then
            output(j) = i
            j = j + 1
        End If
    Next
    
    where = output
    
End Function

Function take(arr As Variant, indices As Variant)

    Dim output() As Variant
    ReDim output(0 To UBound(indices))
    
    Dim i As Long
    For i = 0 To UBound(indices)
        output(i) = arr(indices(i))
    Next

    take = output

End Function

Sub tests()

    Dim data As Variant
    data = Array(1, 2, 3, 4)
    
    ' where
    ' expect: (0, 2, 3)
    Dim flags As Variant
    flags = Array(1, 0, 1, 1)
    Debug.Assert 2 = UBound(where(flags))
    Debug.Assert 3 = where(flags)(2)

    ' take
    ' expect: (2, 3)
    Dim indices As Variant
    indices = Array(0, 2, 3)
    Debug.Assert 2 = UBound(take(data, indices))
    Debug.Assert 4 = take(data, indices)(2)
    
    ' And the big test...
    Dim output As Variant
    output = take(data, where(flags)) ' this is a nice API!
    Debug.Assert 2 = UBound(output)
    Debug.Assert 4 = output(2)
    
End Sub
