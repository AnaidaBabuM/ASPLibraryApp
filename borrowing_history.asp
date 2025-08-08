<!--#include file="conn.asp"-->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Borrowing History</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1>Borrowing History</h1>
        <a href="index.asp" class="btn btn-secondary mb-3">Back to Home</a>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Record ID</th>
                    <th>Book Title</th>
                    <th>Borrower Name</th>
                    <th>Borrow Date</th>
                    <th>Return Date</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <%
                Dim rsHistory
                Set rsHistory = Server.CreateObject("ADODB.Recordset")
                rsHistory.Open "SELECT br.RecordID, b.Title, bo.Name, br.BorrowDate, br.ReturnDate FROM BorrowingRecords br INNER JOIN Books b ON br.BookID = b.BookID INNER JOIN Borrowers bo ON br.BorrowerID = bo.BorrowerID", conn
                Do While Not rsHistory.EOF
                    Dim status
                    If IsNull(rsHistory("ReturnDate")) Then
                        status = "Not Returned"
                    Else
                        status = "Returned"
                    End If
                %>
                    <tr>
                        <td><%=rsHistory("RecordID")%></td>
                        <td><%=rsHistory("Title")%></td>
                        <td><%=rsHistory("Name")%></td>
                        <td><%=rsHistory("BorrowDate")%></td>
                        <td><%=rsHistory("ReturnDate")%></td>
                        <td><%=status%></td>
                    </tr>
                <%
                    rsHistory.MoveNext
                Loop
                rsHistory.Close
                Set rsHistory = Nothing
                %>
            </tbody>
        </table>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<%
Call CloseConnection()
%>
