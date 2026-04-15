<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>丸山建設 - 社内ポータルログイン</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .login-container { max-width: 400px; margin-top: 100px; }
    </style>
</head>
<body>
    <div class="container login-container">
        <div class="card shadow">
            <div class="card-header bg-primary text-white text-center">
                <h4>社内ポータルログイン</h4>
            </div>
            <div class="card-body">
                <form action="LoginServlet" method="POST">
                    <div class="mb-3">
                        <label class="form-label">ユーザーID</label>
                        <input type="text" name="user" class="form-control" placeholder="ユーザー名を入力" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">パスワード</label>
                        <input type="password" name="pass" class="form-control" placeholder="パスワードを入力" required>
                    </div>
                    <button type="submit" class="btn btn-primary w-100">ログイン</button>
                </form>
            </div>
            <div class="card-footer text-center">
                <small class="text-muted">アカウント作成は<a href="signup.jsp">こちら</a></small>
            </div>
        </div>
    </div>
</body>
</html>