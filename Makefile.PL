use inc::Module::Install;
name 'WWW-Shorten-Durl';
all_from 'lib/WWW/Shorten/Durl.pm';

requires 'WWW::Shorten' => '2.05';
tests 't/*.t';
author_tests 'xt';

build_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;
