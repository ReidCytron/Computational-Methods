Attribute VB_Name = "CallFunction"
' I used code from this website to visualize my matrices in the Immediate Window
' https://stackoverflow.com/questions/14274949/how-to-print-two-dimensional-array-in-immediate-window-in-vba

Dim X(10, 10) As Variant
Dim Y(10, 10) As Variant
Dim Z(10, 10) As Variant
Sub CreateMatrices()

Dim a1 As Integer
Dim b1 As Integer
Dim a2 As Integer
Dim b2 As Integer

a1 = InputBox("Rows in matrices 1") - 1
b1 = InputBox("Columns in matrices 1") - 1
a2 = InputBox("Rows in matrices 2") - 1
b2 = InputBox("Columns in matrices 2") - 1

For i = 0 To a1
    For j = 0 To b1
        X(i, j) = Int((20 * Rnd()) + 1)
    Next j
Next i

For i = 0 To a2
    For j = 0 To b2
        Y(i, j) = Int((20 * Rnd()) + 1)
    Next j
Next i

Q = InputBox("Which Operation would you like to perform?  Type one of the options below." & vbCrLf & "Multiplication" & vbCrLf & "Division" & vbCrLf & "Subtraction" & vbCrLf & "Addition")

If Q = "Multiplication" Then
    Call Multiplication(a1, b1, a2, b2)

ElseIf Q = "Subtraction" Then
    Call Subtraction(a1, b2)

ElseIf Q = "Addition" Then
    Call Addition(a1, b2)

ElseIf Q = "Division" Then
    Call Division(a1, b1, a2, b2)

Else
    MsgBox ("You did not enter one of the operations.")
    Exit Sub
End If

End Sub
Function Addition(n1 As Integer, m2 As Integer)

For i = 0 To n1
    For j = 0 To m2
            Z(i, j) = X(i, j) + Y(i, j)
    Next j
Next i

Debug.Print "The array is: "
For i = 0 To UBound(X, 1)
    rowString = X(i, 1)
        For j = 1 To UBound(X, 1)
            rowString = rowString & " " & X(i, j)
        Next j
        Debug.Print rowString
Next i

Debug.Print "The array is: "
For i = 0 To UBound(Y, 1)
    rowString = Y(i, 1)
        For j = 1 To UBound(Y, 1)
            rowString = rowString & " " & Y(i, j)
        Next j
        Debug.Print rowString
Next i

Debug.Print "The array is: "
For i = 0 To UBound(Z, 1)
    rowString = Z(i, 1)
        For j = 1 To UBound(Z, 1)
            rowString = rowString & " " & Z(i, j)
        Next j
        Debug.Print rowString
Next i

End Function
Function Division(n1 As Integer, m1 As Integer, n2 As Integer, m2 As Integer)

If m1 <> n2 Then
    MsgBox ("This operation cannot be performed due to the dimensions of the matrices.")
    Exit Function
End If

Dim QQ() As Variant
ReDim QQ(n1, m1)
Dim W() As Variant
ReDim W(i, j)

For i = 0 To n1
    For j = 0 To m1
        X(i, j) = Int((9 * Rnd) + 1)
    Next j
Next i

For i = 0 To n1
    For j = 0 To m1
        QQ(i, j) = Int((9 * Rnd) + 1)
    Next j
Next i

W() = Application.MInverse(QQ)

For i = 0 To n1
    For j = 0 To m2
        Sum = 0
        For k = 0 To m1
                Sum = Sum + X(i, k) * QQ(k, j)
            Z(i, j) = Sum
        Next k
    Next j
Next i

Debug.Print "Array QQ: "
For i = 0 To UBound(QQ, 1)
    rowString = QQ(i, 1)
        For j = 1 To UBound(QQ, 1)
            rowString = rowString & " " & QQ(i, j)
        Next j
        Debug.Print rowString
Next i

Debug.Print "Array Z: "
For i = 0 To UBound(Z, 1)
    rowString = Z(i, 1)
        For j = 1 To UBound(Z, 1)
            rowString = rowString & " " & Z(i, j)
        Next j
        Debug.Print rowString
Next i

End Function
Function Multiplication(n1 As Integer, m1 As Integer, n2 As Integer, m2 As Integer)

If m1 <> n2 Then
    MsgBox ("These matrices cannot be multiplied.")
    Exit Function
End If

For i = 0 To n1
    For j = 0 To m2
        Sum = 0
        For k = 0 To m1
            Sum = Sum + X(i, k) * Y(k, j)
        Z(i, j) = Sum
        Next k
    Next j
Next i

Debug.Print "The array is: "
For i = 0 To UBound(X, 1)
    rowString = X(i, 1)
        For j = 1 To UBound(X, 1)
            rowString = rowString & " " & X(i, j)
        Next j
        Debug.Print rowString
Next i

Debug.Print "The array is: "
For i = 0 To UBound(Y, 1)
    rowString = Y(i, 1)
        For j = 1 To UBound(Y, 1)
            rowString = rowString & " " & Y(i, j)
        Next j
        Debug.Print rowString
Next i

Debug.Print "The array is: "
For i = 0 To UBound(Z, 1)
    rowString = Z(i, 1)
        For j = 1 To UBound(Z, 1)
            rowString = rowString & " " & Z(i, j)
        Next j
        Debug.Print rowString
Next i

End Function
Function Subtraction(n1 As Integer, m2 As Integer)

If n1 <> m1 Or m2 Or n2 Then
    MsgBox ("This opereation cannot be performed due to the dimensions of the matrices.")
    Exit Function
End If

For i = 0 To n1
    For j = 0 To m2
            Z(i, j) = X(i, j) - Y(i, j)
    Next j
Next i

Debug.Print "The array is: "
For i = 0 To UBound(X, 1)
    rowString = X(i, 1)
        For j = 1 To UBound(X, 1)
            rowString = rowString & " " & X(i, j)
        Next j
        Debug.Print rowString
Next i

Debug.Print "The array is: "
For i = 0 To UBound(Y, 1)
    rowString = Y(i, 1)
        For j = 1 To UBound(Y, 1)
            rowString = rowString & " " & Y(i, j)
        Next j
        Debug.Print rowString
Next i

Debug.Print "The array is: "
For i = 0 To UBound(Z, 1)
    rowString = Z(i, 1)
        For j = 1 To UBound(Z, 1)
            rowString = rowString & " " & Z(i, j)
        Next j
        Debug.Print rowString
Next i

End Function


