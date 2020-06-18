<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>PHP Status Page</title>
        <meta name="description" contents="Default home page for deployed virtual machines">
    </head>
    <body>
      <div>
        <h2>Client information</h2>
        <p><strong>Browser client:</strong><?php echo $_SERVER['HTTP_USER_AGENT']; ?></p>
      </div>
      <div>
        <h2>Server information</h2>
        <p><strong>PHP info:</strong></p>
        <div>
          <?php phpinfo(); ?>
        </div>
      </div>
      <footer>
          Server name: <?php echo php_uname("n"); ?>
      </footer>
    </body>
</html>