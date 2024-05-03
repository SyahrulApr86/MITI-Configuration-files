<?php
// add_trusted_domain.php
$configFile = '/var/www/html/config/config.php';
if (file_exists($configFile)) {
    include $configFile;

    // Get external IP from command line argument
    $newIP = $argv[1];

    if (!in_array($newIP, $CONFIG['trusted_domains'])) {
        $CONFIG['trusted_domains'][] = $newIP;
        // Save the new configuration back to config.php
        file_put_contents($configFile, "<?php\n\$CONFIG = " . var_export($CONFIG, true) . ";\n");
        echo "IP $newIP added to trusted domains.\n";
    } else {
        echo "IP $newIP is already in trusted domains.\n";
    }
} else {
    echo "Configuration file not found.\n";
}
