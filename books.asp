<!--#include file="conn.asp"-->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Books</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1>Books</h1>
        <a href="index.asp" class="btn btn-secondary mb-3">Back to Home</a>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Book ID</th>
                    <th>Title</th>
                    <th>Author</th>
                    <th>Publication Year</th>
                    <th>Times Borrowed</th>
                </tr>
            </thead>
            <tbody>
                <%
                Dim rsBooks
                Set rsBooks = Server.CreateObject("ADODB.Recordset")
                rsBooks.Open "SELECT b.BookID, b.Title, b.Author, b.PublicationYear, COUNT(br.RecordID) as BorrowCount FROM Books b LEFT JOIN BorrowingRecords br ON b.BookID = br.BookID GROUP BY b.BookID, b.Title, b.Author, b.PublicationYear", conn
                Do While Not rsBooks.EOF
                %>
                    <tr>
                        <td><%=rsBooks("BookID")%></td>
                        <td><%=rsBooks("Title")%></td>
                        <td><%=rsBooks("Author")%></td>
                        <td><%=rsBooks("PublicationYear")%></td>
                        <td><%=rsBooks("BorrowCount")%></td>
                    </tr>
                <%
                    rsBooks.MoveNext
                Loop
                rsBooks.Close
                Set rsBooks = Nothing
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
