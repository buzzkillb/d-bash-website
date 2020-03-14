#!/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
jq '.[] | .txid' -r /var/www/html/fslist.json > /var/www/html/txid.txt
jq '.[] | .pubkey' -r /var/www/html/fslist.json > /var/www/html/pubkey.txt

echo '<html lang="en" >
<head>
  <meta charset="UTF-8">
  <title>[D] FortunaStake Collateral CoinAge | Denarius</title>
    <meta name="twitter:card" content="summary">
    <meta name="twitter:url" content="https://pos.watch/coinage.html">
    <meta name="twitter:title" content="[D] FortunaStake Collateral CoinAge">
    <meta name="twitter:description" content="Denarius FortunaStake Collateral CoinAge">
    <meta name="twitter:image" content="https://i.imgur.com/lCvgFft.png?1">
    <link rel="stylesheet" href="./style.css">
</head>

<body>

<nav class="menu">
  <ul>
    <li><a href="/">Home</a></li>
    <li class="sub-menu"><a href="#">Menu</a>

      <ul>
          <li><a href="/">pos.watch home</a></li>
          <li><a href="https://denarii.cloud">Chaindata</a></li>
          <li><a href="https://denarius.pro">Live Stats</a></li>
      </ul>

    </li>
    <li><a href="https://discord.gg/JQEmXwb">Denarius Discord</a></li>
  </ul>
</nav><!--/menu-->

  <h1><span class="blue">[</span>D<span class="blue">]</span> <span class="yellow">FortunaStake Collateral CoinAge</pan></h1>

<table class="container">
        <thead>
                <tr>
                        <th><h1>pubkey</h1></th>
                        <th><h1>CoinAge (Days)</h1></th>
                        <th><h1>Staker (67%)</h1></th>
                        <th><h1>FS (33%)</h1></th>
                        <th><h1>Total D</h1></th>
                </tr>
        </thead>'

paste /var/www/html/txid.txt /var/www/html/pubkey.txt | while IFS="$(printf '\t')" read -r f1 f2
do
#  printf 'f1: %s\n' "$f1"
#  printf 'f2: %s\n' "$f2"
  echo '        <tbody>
                <tr>'
  echo "<td><a href="https://www.coinexplorer.net/D/address/$f2" target="_blank">$f2</a></td>"
#  echo "<td>$f1</td>"
  cmd="$(/snap/bin/denarius.daemon gettransaction $f1 | jq '.time')"
  currentdate="$(date +%s)"
  dif="$(($currentdate - $cmd | bc))"
  days=`echo "scale=1; $dif/60/60/24" | bc`
  echo "<td>$days</td>"
  totalbuildup=`echo "scale=2; $days*300/365" | bc`
  staker=`echo "scale=2; $totalbuildup * 0.67" | bc`
  echo "<td>$staker</td>"
  hodler=`echo "scale=2; $totalbuildup * 0.33" | bc`
  echo "<td>$hodler</td>"
  echo "<td>$totalbuildup</td>"
  echo '                </tr>
        </tbody>'

done
echo '</body>
</html>'
