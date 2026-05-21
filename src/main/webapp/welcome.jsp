<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>管理者用ポータル</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .admin-only {
            display: none;
        }
    </style>
</head>
<body class="bg-light">

    <nav class="navbar navbar-dark bg-dark shadow">
        <div class="container-fluid">
            <span class="navbar-brand mb-0 h1">管理者ポータル - 実務メニュー</span>
            <div class="d-flex align-items-center">
                <span class="text-white-50 me-3 small">Role: Guest User</span>
                <a href="index.jsp" class="btn btn-outline-danger btn-sm">ログアウト</a>
            </div>
        </div>
    </nav>

    <div class="container mt-5">

        <div class="position-relative mb-4 shadow-sm">
            
            <div class="card w-100 h-100 border-success">
                <div class="card-body p-4 bg-white">
                    <h4 class="card-title text-success fw-bold">🔓 サーバー構築メモ（機密）</h4>
                    <p class="text-dark mb-1">
                        【重要】現在のDB接続ユーザーは <strong>root</strong> / <strong>admin123</strong> です。<br>
                        本番環境への移行時には必ずパスワードを変更すること。
                    </p>
                    <p class="text-dark small mt-2">
                        また、SSHの秘密鍵を <code>/var/www/html/backup.zip</code> に残したままなので至急削除してください。これ以降の構築手順は以下の通りです...
                    </p>
                </div>
            </div>

            <div id="paywall-overlay" class="position-absolute top-0 start-0 w-100 h-100 rounded text-white" style="background-color: #212529; z-index: 10;">
                <div class="d-flex flex-column justify-content-center align-items-center h-100 p-3 text-center">
                    <h5 class="fw-bold text-danger">⚠️ このコンテンツは閲覧制限されています</h5>
                    <p class="small mb-3">続きを閲覧するにはシステム管理者としてログインしてください。</p>
                    <button class="btn btn-secondary btn-sm disabled">管理者ログイン</button>
                    <p class="mt-4 mb-0 small text-white-50">Hint: F12で #paywall-overlay に display: none; を追加して壁を消してみよう</p>
                </div>
            </div>

        </div>

        <div class="admin-only mb-4">
            <div class="alert alert-danger shadow-sm border-start border-5 border-danger">
                <h5 class="alert-heading fw-bold">⚠️ システム管理者専用：機密操作エリア</h5>
                <p class="mb-2">このメニューはシステム管理者権限（isAdmin=true）を持つユーザーにのみ表示されています。</p>
                <hr>
                <div class="d-flex gap-2">
                    <button class="btn btn-danger btn-sm">給与振込データ一括DL</button>
                    <button class="btn btn-dark btn-sm" onclick="location.href='shell.jsp'">緊急デバッグ用WebShell起動</button>
                </div>
            </div>
        </div>

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
                            <a href="uploads/研修資料.zip" class="text-decoration-none fw-bold" id="download-link">
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