' This is bad code, for a couple of reasons:
' 1. Types aren't very efficient - optimised for dev time
' 2. It won't work with the 2d arrays / scalars pulled from Excel cells. It only works with 1D VBA arrays.

Function take(arr As Variant, indices As Variant)

    Dim output() As Variant
    ReDim output(0 To UBound(indices))
    
    Dim i As Long
    For i = 0 To UBound(indices)
        output(i) = arr(indices(i))
    Next

    take = output

End Function

Function where(arr As Variant, flags As Variant)

    Dim output() As Variant
    ReDim output(0 To -1 + WorksheetFunction.Sum(flags))

    Dim i As Long
    For i = 0 To UBound(output)
        If flags(i) Then: output(i) = arr(i)
    Next
    
    where = output
    
End Function

Sub tests()

    Dim data As Variant
    data = Array(1, 2, 3, 4)

    ' take
    Debug.Assert 1 = UBound(take(data, Array(1, 2)))
    Debug.Assert 3 = take(data, Array(1, 2))(1)
    
    ' where
    Dim flags As Variant
    flags = Array(1, 0, 1, 1)
    Debug.Assert 2 = UBound(where(data, flags))
    Debug.Assert 3 = where(data, flags)(2)

End Sub

