Attribute VB_Name = "Module2"
Sub take2()

    Dim volume As Long
    Dim Cnt As Long
    Dim rowvalue As Double
    Dim total As Double
    Dim ticker As String
    Dim SumCnt As Integer
    Dim RowCount As Long
    
    
    
    
    total = 0
    SumCnt = 2
    RowCount = Range("A1").End(xlDown).Row
    For Cnt = 2 To RowCount
    
        
        rowvalue = Cells(Cnt, 7).Value
        ticker = Cells(Cnt, 1).Value
        
        Cells(1, 9).Value = "Ticker"
        Cells(1, 10).Value = "Total Stock Volume"
        

        If Cnt = 2 Then
            total = total + rowvalue
            Cells(SumCnt, 9).Value = ticker
            Cells(SumCnt, 10).Value = total
            
            
         ' if ticker is the same as the one before it
        ElseIf ticker = Cells(Cnt - 1, 1).Value Then
            rowvalue = Cells(Cnt, 7).Value
            total = total + rowvalue
            ticker = Cells(SumCnt, 1).Value
            Cells(SumCnt, 10).Value = total
            
            ' if ticker is NOT the same as the one before it, starts a new ticker summary
        ElseIf ticker <> Cells(Cnt - 1, 1).Value Then
            
            SumCnt = SumCnt + 1
            total = 0
            total = total + rowvalue
            rowvalue = Cells(Cnt, 7).Value
            Cells(SumCnt, 9).Value = ticker
            Cells(SumCnt, 10).Value = total
            
            
        
        End If
        
    
    Next Cnt



End Sub
