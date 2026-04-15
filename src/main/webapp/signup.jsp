<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>アカウント作成</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-5">
                <div class="card border-0 shadow-sm">
                    <div class="card-body p-4">
                        <h2 class="text-center mb-4">新規アカウント作成</h2>
                        <form action="RegisterServlet" method="POST">
                            <div class="mb-3">
                                <label class="form-label">希望ユーザー名</label>
                                <input type="text" name="user" class="form-control" required>
                                 <div class="form-text color-gray">例:maruyama ryo</div>
                            </div>
                            <div class="mb-4">
                                <label class="form-label">パスワード</label>
                                <input type="password" name="pass" class="form-control" required>
                               
                            </div>
                            <button type="submit" class="btn btn-success w-100">登録を実行</button>
                        </form>
                        <div class="mt-3 text-center">
                            <a href="index.jsp" class="text-decoration-none">← ログインに戻る</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>