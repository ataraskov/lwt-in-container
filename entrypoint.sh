#!/bin/sh
set -e

cat > /var/www/html/connect.inc.php <<EOF
<?php
\$server = "${DB_HOST:-localhost}";
\$userid = "${DB_USER:-lwt}";
\$passwd = "${DB_PASSWORD:-}";
\$dbname = "${DB_DATABASE:-learning_with_texts}";
?>
EOF

exec apache2-foreground
