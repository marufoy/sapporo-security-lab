<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>管理者用ポータル</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-dark bg-dark shadow">
        <div class="container-fluid">
            <span class="navbar-brand mb-0 h1">管理者ポータル - 実務メニュー</span>
            <a href="index.jsp" class="btn btn-outline-danger btn-sm">ログアウト</a>
        </div>
    </nav>

    <div class="container mt-5">
        <div class="row g-4">
            <div class="col-md-6">
                <div class="card h-100 shadow-sm">
                    <div class="card-body">
                        <h5 class="card-title text-primary">社員情報 照会システム</h5>
                        <p class="card-text text-muted small">名前から社員の所属情報を検索できます。</p>
                        <form action="SearchServlet" method="GET" class="input-group">
                            <input type="text" name="keyword" class="form-control" placeholder="社員名の一部を入力...">
                            <button type="submit" class="btn btn-primary">検索</button>
                        </form>
                    </div>
                </div>
            </div>

            <div class="col-md-6">
                <div class="card h-100 shadow-sm border-warning">
                    <div class="card-body">
                        <h5 class="card-title text-warning">資料アップロード</h5>
                        <p class="card-text text-muted small">プロフィール画像や経歴書(PDF)を提出してください。</p>
                        
                        <div class="alert alert-secondary p-2 small mb-3">
                            <i class="bi bi-file-earmark-pdf"></i> 
                            <a href="uploads/test.zip" class="text-decoration-none fw-bold" id="download-link">
                                【最新】2026年度Java研修_補足資料.zip
                            </a>
                            <span class="ms-2 text-muted">(解凍パスワード: <span class="badge bg-dark">java2026</span>)</span>
                        </div>
                        <form action="UploadServlet" method="POST" enctype="multipart/form-data">
                            <div class="mb-2">
                                <input type="file" name="uploadFile" class="form-control form-control-sm">
                            </div>
                            <button type="submit" class="btn btn-warning btn-sm w-100 text-dark fw-bold">アップロード実行</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>