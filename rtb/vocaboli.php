<?php
require_once __DIR__ . '/.lib_php/Stream.php';

function preg($r, $s) {
  preg_match_all($r, $s, $a = []);
  return $a;
}

function findoutliers_file($file) {
  return stream(
    preg('/.*?[^}]\$\^{G}\$.*?/', file_get_contents($file))[0],
    _filter(fn ($a) => !str_contains($a, 'La presenza di un termine all’interno del glossario viene indicata applicando una')),
    _map(fn ($a) => ['file' => $file, 'context' => $a]),
  );
}

function findvocaboli_file($file) {
  return preg('/\\\\emph{(.*?)}\$\^{G}\$/', file_get_contents($file))[1];
};

function applicative_list($functions, $args) {
  return array_reduce(
    array_map(fn ($f) => array_map(fn ($a) => $f($a), $args), $functions),
    fn ($a, $b) => array_merge($a, $b),
    []
  );
}

function findoutliers($files) {
  return stream(
    applicative_list(['findoutliers_file'], $files),
    _filter(fn ($a) => count($a) > 0),
    _map(fn ($a) => $a[0]),
  );
}

function findvocaboli($files) {
  return stream(
    applicative_list(['findvocaboli_file'], $files),
    _filter(fn ($a) => count($a) > 0),
    _reduce(fn ($a, $b) => array_merge($a, $b), []),
    _map('ucfirst'),
    _sort(),
    _unique(),
  );
}


array_shift($argv);
$a = $argv;

if (count($a = findoutliers($argv)) > 0) {
  die(stream(
    $a,
    _map(fn ($a) => "\n" . $a['file'] . ":\n" . $a['context'] . "\n\n"),
    _implode("\n"),
  ));
}

$a = findvocaboli($argv);


print_r($a);
