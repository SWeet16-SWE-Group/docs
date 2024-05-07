<?php

require_once __DIR__ . '/.lib_php/utils.php';
require_once __DIR__ . '/.lib_php/Stream.php';

const stile = [
  '\r' => '',                          // carriage return
  '\t' => '  ',                        // tab in 2 spazi
  '(\S) +' => '\1 ',                   // compressione di tanti spazi in uno esclusa indentazione iniziale
  ' *\n' => '\n',                      // testo bianco a fine riga
  ' *}' => '}',                        // rimozione spazi tra : e }
  '}(\w)' => '} \1',                   // spazio dopo :}
  '(\S) +([;:,.])' => '\1\2',          // rimozione spazi prima di [:,.;]
  '([a-zA-Z]),([a-zA-Z])' => '\1, \2', // aggiunta spazio dopo ,
];


function stilizzazione($file) {
  return file_put_contents($file, preg_replace(array_keys(stile), stile, file_get_contents($file)));
}


// stilizzazione($argv[1]);


function merge_items($text) {
  $a = array_merge(
    //preg('/\\\\item/', $text, PREG_OFFSET_CAPTURE)[0],
    preg('/\\\\begin{itemize}/', $text, PREG_OFFSET_CAPTURE)[0],
    preg('/\\\\begin{enumerate}/', $text, PREG_OFFSET_CAPTURE)[0],
    preg('/\\\\end{itemize}/', $text, PREG_OFFSET_CAPTURE)[0],
    preg('/\\\\end{enumerate}/', $text, PREG_OFFSET_CAPTURE)[0],
    // preg('/\\\\item\s*\\\\begin{/', $text, PREG_OFFSET_CAPTURE)[0],
  );
  usort($a, fn ($a, $b) => $a[1] < $b[1] ? -1 : 1);

  $stack = [];
  $i = 0;
  foreach ($a as &$b) {
    if (str_contains($b[0], 'begin')) {
      if ($i == 0) {
        $stack[] = [$b];
      }
      //$b[] = $i;
      $i += 1;
    }
    if (str_contains($b[0], 'end')) {
      $i = max([0, $i - 1]);
      if ($i == 0) {
        $stack[array_key_last($stack)][] = $b;
      }
      //$b[] = $i;
    }
  }

  //$linearize = null;
  //$linearize = fn ($a) => '[' . stream($a, _map($linearize), _implode(', ')) . ']';
  //$linearize = fn ($a) => '[' . stream($a, _map($linearize), _implode(', ')) . ']';

  //print_r(stream($a, _map(fn ($a) => '[' .  stream($a, _implode(', ')) . ']')));
  //print_r(stream($stack, _map($linearize)));

  $text = array_reduce($stack, function ($text, $a) {
    $o = $a[0][1];
    $l = $a[1][1] - $o;
    return substr_replace($text, str_replace("\n", ' ', substr($text, $o, $l)), $o, $l);
  }, $text);

  $a_capo = fn ($s, $t) => str_replace($s, "\n" . $s, $t);
  $text = $a_capo('\\item', $text);
  $text = $a_capo('\\begin{itemize}', $text);
  $text = $a_capo('\\begin{enumerate}', $text);
  $text = $a_capo('\\end{itemize}', $text);
  $text = $a_capo('\\end{enumerate}', $text);

  $text = str_replace(':}', '}:', $text);
  $text = str_replace("\t", '  ', $text);
  $text = preg_replace("/ *\n/", "\n", $text);
  //$text = str_replace("\n\n", "\n", $text);

  print_r($text);
  return $text;
}

function correggi_file($file) {
  file_put_contents($file, merge_items(file_get_contents($file)));
}

correggi_file($argv[1]);
