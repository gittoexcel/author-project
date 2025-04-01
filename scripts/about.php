<?php
    $host = 'localhost';
    $dbname = 'db_bookinfo';
    $user = 'root';
    $pass = '';

    header('Content-Type: application/json');

    try {
        $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8mb4", $user, $pass);
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        // All books
        $stmt = $pdo->query("SELECT * FROM book");
        $books = $stmt->fetchAll(PDO::FETCH_ASSOC);

        $result = [];

        foreach ($books as $book) {
            $bookId = $book['id'];

            // Text sections
            $sectionsStmt = $pdo->prepare("SELECT type, content FROM book_text_sections WHERE book_id = ?");
            $sectionsStmt->execute([$bookId]);
            $sections = $sectionsStmt->fetchAll(PDO::FETCH_KEY_PAIR);

            // Cover
            $coverStmt = $pdo->prepare("SELECT artist_name, artist_url FROM book_artist WHERE book_id = ?");
            $coverStmt->execute([$bookId]);
            $cover = $coverStmt->fetch(PDO::FETCH_ASSOC);

            // Wallpapers
            $wallpapersStmt = $pdo->prepare("SELECT image_url FROM book_wallpapers WHERE book_id = ?");
            $wallpapersStmt->execute([$bookId]);
            $wallpapers = $wallpapersStmt->fetchAll(PDO::FETCH_COLUMN);

            // Deleted scenes
            $deletedStmt = $pdo->prepare("SELECT scene_url FROM book_deleted WHERE book_id = ?");
            $deletedStmt->execute([$bookId]);
            $deletedScene = $deletedStmt->fetchColumn();

            // JSON object
            $bookJson = [
                'id' => $book['id'],
                'title' => $book['title'],
                'image_url' => $book['image_url'],
                'buttons' => [
                    'download' => $book['download_url'],
                    'read' => $book['read_url'],
                ],
                'related' => [
                    'about' => $sections['about'] ?? null,
                    'thought process' => $sections['thought_process'] ?? null,
                    'cover by' => $cover ?: null,
                    'wallpapers' => $wallpapers,
                    'deleted scenes' => $deletedScene ?: null
                ]
            ];

            $result[] = $bookJson;
        }

        // Output JSON
        header('Content-Type: application/json');
        echo json_encode($result, JSON_PRETTY_PRINT);

    } catch (PDOException $e) {
        echo "Database error: " . $e->getMessage();
}
?>