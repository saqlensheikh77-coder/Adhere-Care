# Lightweight robust zero-dependency HTTP static server for PWA & Audio support
$port = 5050
$baseDir = "C:\Users\ASUS\.gemini\antigravity\scratch\medication-adherence-pwa"
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$port/")

try {
    $listener.Start()
    Write-Output "HTTP server started at http://localhost:$port/"
} catch {
    Write-Output "Error starting listener: $_"
    exit
}

$mimeTypes = @{
    ".html" = "text/html; charset=utf-8"
    ".css"  = "text/css; charset=utf-8"
    ".js"   = "application/javascript; charset=utf-8"
    ".json" = "application/json; charset=utf-8"
    ".svg"  = "image/svg+xml"
    ".png"  = "image/png"
    ".ico"  = "image/x-icon"
    ".wav"  = "audio/wav"
    ".mp3"  = "audio/mpeg"
}

try {
    while ($listener.IsListening) {
        $context = $listener.GetContext()
        $req = $context.Request
        $res = $context.Response

        try {
            $relPath = $req.Url.LocalPath.TrimStart('/')
            if ([string]::IsNullOrEmpty($relPath)) { $relPath = "index.html" }
            $filePath = Join-Path $baseDir $relPath

            $res.Headers.Add("Access-Control-Allow-Origin", "*")
            $res.Headers.Add("Service-Worker-Allowed", "/")
            $res.Headers.Add("Accept-Ranges", "bytes")

            if (Test-Path $filePath -PathType Leaf) {
                $ext = [System.IO.Path]::GetExtension($filePath).ToLower()
                $contentType = if ($mimeTypes.ContainsKey($ext)) { $mimeTypes[$ext] } else { "application/octet-stream" }
                $res.ContentType = $contentType

                $fileBytes = [System.IO.File]::ReadAllBytes($filePath)
                $res.StatusCode = 200
                $res.ContentLength64 = $fileBytes.Length

                if ($req.HttpMethod -ne "HEAD") {
                    $res.OutputStream.Write($fileBytes, 0, $fileBytes.Length)
                }
            } else {
                $res.StatusCode = 404
                $errBytes = [System.Text.Encoding]::UTF8.GetBytes("404 Not Found")
                $res.ContentLength64 = $errBytes.Length
                if ($req.HttpMethod -ne "HEAD") {
                    $res.OutputStream.Write($errBytes, 0, $errBytes.Length)
                }
            }
        } catch {
            # Ignore client aborts or stream errors
        } finally {
            try { $res.OutputStream.Close() } catch {}
            try { $res.Close() } catch {}
        }
    }
} finally {
    try { $listener.Stop() } catch {}
    try { $listener.Close() } catch {}
}
