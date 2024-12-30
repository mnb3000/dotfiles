#!/usr/bin/env perl
use strict;
use warnings;
use Term::ANSIColor;
use File::Temp;# qw(tempdir);
use File::Copy;
use Archive::Tar;

# do a clean up if we get a CTRL-C
our $tdir;
$SIG{INT} = sub { if ($tdir) {unlink $tdir; print "\n"; exit 1 }};

sub usage {
	print <<EOF;
Usage: $0 [-e] [-n] [-v] [number[s]] [string[s]] [file_name]
  Test lesspipe.sh against a number of files and report failures
  -v        Print the output of all commands and the test string
  -e        Print the output of failing commands and the test string
  -n        Test commands are printed only, not checked
            With -v print also test numbers and required auxiliary programs
  file_name The script to test against in the current directory [lesspipe.sh]
  The number[s] and string[s] arguments can be used to limit the tests to be
  performed. Number ranges are allowed. Strings can be part of the command
  or the comment attached to the test commands.
  The test commands and test strings are stored at the end of this program
  The '= some string' means, that 'some string' including a newline char
  must be the test result. The '~ match string' means, that 'match string'
  must match a complete line in the output, the 'c string' must match string
  surrounded with Escape sequences.. In the latter case a successful test
  is usually displayed with a colored 'ok'
EOF
	exit;
}

use vars qw(%ENV);

my ($verbose, $errors, $noaction, $fname, @numtest, @strtest);
$fname = 'lesspipe.sh';
my $args = "@ARGV";
$args =~ s/(?:^|\s)(\d+)\s*\-\s*(\d+)(?:$|\s)/ $1-$2 /g;
$args =~ s/,/ /g;
for (split ' ', $args) {
	if (/^\-([ehnrv]+$)/) {
		my $x = $1;
		$verbose = 1, $errors = 1 if $x =~ /v/;
		$errors = 1 if $x =~ /e/;
		$noaction = 1 if $x =~ /n/;
		usage() if $x =~ /h/;
	} elsif (/^(\d*)-(\d+)$/) {
		push @numtest, $_ for ($1 || 1 .. $2);
	} elsif (/^(\d+)$/) {
		push @numtest, $1;
	} elsif (-r $_) {
		$fname = $_;
	} elsif (/^([-\w]+)$/) {
		push @strtest, $1;
	} else {
		usage();
	}
}
$fname = "./$fname" if $fname !~ m|/|;
print "testing $fname\n";
# set the env variables to standard contents to get reproducible results
$ENV{LESS} = '-R';
$ENV{LESSOPEN} = "|-$fname %s";
print "LESSOPEN=\"$ENV{LESSOPEN}\"\n\n" if $noaction;
$ENV{LESSQUIET} =1;
$ENV{LESSCOLORIZER} = 'vimcolor';
$ENV{LANG} = 'en_US.UTF-8';
$ENV{LC_ALL} = 'en_US.UTF-8';
$ENV{TZ} = '';
(my $dir = $0) =~ s|/[^/]*$|:|;
$ENV{PATH} = $dir . $ENV{PATH};

my $duration = time();
my ($retcode, $sumok, $sumignore, $sumnok, $num) = (0, 0, 0, 0, 0);
my ($needed, $comment);
my $tmp = $ENV{TMPDIR} || '/tmp';
$tmp =~ s|/$||;
$tdir = File::Temp->newdir("$tmp/lesspipeXXXX");
mkdir "$tdir/tests";
my $T="$tdir/tests";
copy("tests/archive.tgz","$T/archive.tgz") or die "$!";
copy("tests/compress.tgz","$T/compress.tgz") or die "$!";
copy("tests/filter.tgz","$T/filter.tgz") or die "$!";
copy("tests/special.tgz","$T/special.tgz") or die "$!";
my $cwd = $ENV{PWD};
chdir $T;
my $tar = Archive::Tar->new;
for my $arch (qw(archive compress filter special)) {
	my $next = Archive::Tar->iter("$arch.tgz", 1);
	while( my $f = $next->() ) {
		$f->extract or warn "Extraction failed";
	}
}
symlink 'test_plain', 'symlink';
chdir $cwd;

while (<DATA>) {
	last if /^END\n$/;
	print if /^###/ and ! @numtest and ! @strtest;
	next if /^#|^\s*$/;
	$num = $1 if s/^(\d+)\s+//;
	if (! /^less\s|\|\s*less|^LESS|\|\s*LESS.*less/) {
		print "### skipping invalid line $_";
		next;
	}
	my $cmd = $_;
	chomp $cmd;
	$cmd =~ s/\$T/$tdir/g;
	my $comp = <DATA>;
	my $skip;
	$skip = 1 if @numtest and ! grep {$num == $_} @numtest;
	$skip = 1 if @strtest and ! grep {$cmd =~ /$_/} @strtest;
	$skip = 1 if ! $num;
	next if $skip;
	$comment = $cmd =~ s/\s+#(.*)// ? $1 : '';
	$needed = $comment =~ s/[#,]? needs (.*)// ? $1 : '';
	$needed =~ s/ or /|/g;
	$needed =~ s/ not /!/g;
	$needed =~ s/ and /,/g;
	$needed =~ s/html_converter/w3m|lynx|elinks|html2text/;
	my @needed = split /\s*\|\s*/, $needed;
	if ($noaction) {
		my $needed_str = $needed ? " ($needed)" : '';
		print $verbose ? "$num $cmd $needed_str\n" : "$num $cmd\n";
		next;
	}
	my $ignore = 0;
	$ignore = 1 if @needed;
	for my $andargs (@needed) {
		my $good = 1;
		for (split /\s*,\s*/, $andargs) {
			if (s/^!//) {
				$good = 0 if ! is_not_exec($_);
			} else {
				$good = 0 if is_not_exec($_);
			}
		}
		$ignore = 0 if $good;
	}
	if ($comp =~ /^c/ and $comment !~ /directory/ and $ENV{LESSCOLORIZER}
		and ! grep {$ENV{LESSCOLORIZER} =~ /^$_\b/}
		qw(bat batcat pygmentize source-highlight code2color vimcolor)){
		$ignore = 1;
		$needed = 'a colorizer';
	}
	my $res = $ignore ? '' : ($cmd =~ /|/ ? `$cmd` : `$cmd 2>&1`);

	my $ok = 0;
	my $lines = 0;
	# zsh|bash|ksh style|file not found
	if ($res =~ /command not found: \S+|\S+:\s+command not found|\S+:\s+not found|no such file or directory: .*?[^\/]+\b$/m) {
		$res = "NOT found: " . $res;
		$ok = 1;
	} else {
		if ($ignore) {
			$sumignore++;
		} else {
			$ok = comp($res, $comp);
			if ($ok) {
				$sumok++;
			} else {
				$sumnok++;
			}
		}
	}
	print "result for :$cmd:\n$res" if $ok and $verbose;
	printf "%2d %6s %s %s\n", $num, $ignore ? 'ignore' : $ok ? $ok: 'NOT ok', $comment, $ignore ? "(needs $needed)" : '';
	print "\t   failing command: $cmd\n" if ! $ok and ! $ignore;
	$num = 0;
}

$duration = time() - $duration;
print "$sumok/$sumignore/$sumnok tests passed/ignored/failed in $duration seconds\n" if ! $noaction;
exit $sumnok;

sub is_not_exec {
	my $arg = shift;
	return 0 if ! $arg;
	for my $prog (split ' ', $arg) {
		return 1 if ! grep {-x "$_/$prog"} split /:/, $ENV{PATH};
	}
	return undef;
}

sub comp {
	my ($res, $comp) = @_;
	chomp $comp;
	my $ok = '';
	my $reset = color('reset');
	# ignore unicode start of file
	$res =~ s/^\x{fe}\x{ff}//;
	$res =~ s/^\x{ef}\x{bb}\x{bf}//;
	if ($comp =~ /^= ?/) {
		$comp =~ s/^= ?//;
		# ignore leading and trailing newlines
		$res =~ s/^\n//g;
		$res =~ s/\0//g;
		$res =~ s/\014//g;
		$res =~ s/\r?\n$//g;
		return 'ok' if $res eq $comp;
		for (split /\|/, $comp) {
			return 'ok' if $res eq $_;
		}
		for (split /\|/, $comp) {
			print ":$res:\ndiffers from\n:$_:\n" if $errors;
		}
	} elsif ($comp =~ s/^~ //) {
		return 'ok' if $res =~ /^$comp\r?/m;
		print ":$res:\ndoes not match\n:$comp:\n" if $errors;
	} elsif ($comp =~ s/^c //) {
		$ok = (grep {s/.*(\e\S+)$comp\b.*/$1ok$reset/} split /\n/, $res)[0];
		$ok =~ s/[()-]//g if $ok;
		print ":$res:\ndoes not match\n:$comp:\n" if ! $ok and $errors;
	} else {
		print "unknown test (must start with c ~ or =): $comp\n";
	}
	return $ok;
}
__END__
### archive tests
1 less tests/archive.tgz			# contents of archive with test files
~ .* test_tar
2 less $T/tests/test_tar			# tar contents (from unpacked file)
~ .* tests/textfile
3 less tests/archive.tgz:test_tar		# tar contents (from archive without unpacking)
~ .* tests/textfile
4 less $T/tests/test_tar:tests/textfile	# extract file from tar (unpacked)
= test
5 less tests/archive.tgz:test_tar:tests/textfile # (on the fly)
= test
###    plain tar file names with a : not allowed, use ./tar:name, not tar:name
6 less $T/tests/test:tar			# tar file name with colon git #51
~ .* tests/textfile
7 less $T/tests/test:tar=tests/textfile	# extract file from tar file with colon
= test
8 less $T/tests/test_rpm			# rpm contents, needs rpm2cpio
~ .* ./textfile
9 less tests/archive.tgz:test_rpm		# (on the fly), needs rpm2cpio
~ .* ./textfile
10 less $T/tests/test_rpm:./textfile		# extract file from rpm, needs rpm2cpio
= test
11 less tests/archive.tgz:test_rpm:./textfile	# (on the fly), needs rpm2cpio
= test
12 less $T/tests/test.jar			# jar contents, needs unzip
~ .*/MANIFEST.MF
13 less tests/archive.tgz:test.jar		# (on the fly), needs unzip
~ .*/MANIFEST.MF
14 less $T/tests/test.jar:META-INF/MANIFEST.MF	# # extract file from jar, needs unzip
~ .*: test
15 less tests/archive.tgz:test.jar:META-INF/MANIFEST.MF	# (on the fly), needs unzip
~ .*: test
16 less $T/tests/test_zip			# zip contents, needs unzip
~ .* 10240 .*
17 less tests/archive.tgz:test_zip		# (on the fly), needs unzip
~ .* 10240 .*
18 less $T/tests/test_zip:tests/test.tar	# extract tar archive from zip, needs unzip
~ .* tests/textfile
19 less tests/archive.tgz:test_zip:tests/test.tar	# (on the fly), needs unzip
~ .* tests/textfile
20 less $T/tests/test_zip:tests/test.tar:tests/textfile	# extract file from chained archives git #45, needs unzip
= test
21 less tests/archive.tgz:test_zip:tests/test.tar:tests/textfile	# (on the fly), needs unzip
= test
22 less $T/tests/test_deb					# debian contents
~ .* ./test.txt
23 less tests/archive.tgz:test_deb		# (on the fly)
~ .* ./test.txt
24 less $T/tests/test_deb:./test.txt		# extract file from debian package
= test
25 less tests/archive.tgz:test_deb:./test.txt	# (on the fly)
= test
26 less $T/tests/test_rar			# rar contents, needs unrar|rar|bsdtar
~ .* testok/a b
27 less tests/archive.tgz:test_rar		# (on the fly), needs unrar|rar|bsdtar
~ .* testok/a b
28 less $T/tests/test_rar:testok/a\ b		# extract file from rar, needs unrar|rar|bsdtar
= test
29 less tests/archive.tgz:test_rar:testok/a\ b	# (on the fly), needs unrar|rar|bsdtar
= test
30 less $T/tests/test_cab			# ms cabinet contents, needs cabextract
~ .* cabinet.txt
31 less tests/archive.tgz:test_cab		# (on the fly), needs cabextract
~ .* cabinet.txt
32 less $T/tests/test_cab:a\ text.gz		# extract gzipped file from cab, needs cabextract
= test
33 less tests/archive.tgz:test_cab:a\ text.gz	# (on the fly), needs cabextract
= test
34 less $T/tests/test_7z			# 7z contents, needs 7zz|7zr|7za
~ .* testok/aaa.txt
35 less tests/archive.tgz:test_7z		# (on the fly), needs 7zz|7zr|7za
~ .* testok/aaa.txt
36 less $T/tests/test_7z:testok/a\|b.txt	# extract file from 7z, needs 7zz|7zr|7za
= test
37 less tests/archive.tgz:test_7z:testok/a\|b.txt	# (on the fly), needs 7zz|7zr|7za
= test
38 less $T/tests/test_iso			# iso9660 contents, needs bsdtar|isoinfo
~ .* ISO.TXT|/ISO.TXT;1
39 less tests/archive.tgz:test_iso		# (on the fly), needs bsdtar|isoinfo
~ .* ISO.TXT|/ISO.TXT;1
40 less $T/tests/test_iso:ISO.TXT		# extract file from iso9660, needs bsdtar
= test
41 less tests/archive.tgz:test_iso:ISO.TXT	# (on the fly), needs bsdtar
= test
42 less $T/tests/test_iso:/ISO.TXT\;1		# extract file from iso9660, needs isoinfo, not bsdtar
= test
43 less tests/archive.tgz:test_iso:/ISO.TXT\;1	# (on the fly), needs isoinfo, not bsdtar
= test
44 less $T/tests/test_ar			# ar archive contents
~ .* a=b/?
45 less tests/archive.tgz:test_ar		# (on the fly)
~ .* a=b/?
46 less $T/tests/test_ar:a=b			# extract file from ar
= test
47 less tests/archive.tgz:test_ar:a=b	# (on the fly)
= test
48 less $T/tests/test_cpio:textfile	# extract from cpio needs cpio
= test
49 less tests/archive.tgz:test_cpio:textfile	# (on the fly) needs cpio
= test
### uncompress tests not covered in archive tests
50 less tests/compress.tgz:test.tar.bz2:tests/textfile	# extract from bzip2
= test
51 less tests/compress.tgz:test.tar.lzip:tests/textfile	# extract from lzip, needs lzip
= test
52 less tests/compress.tgz:test.tar.lzma:tests/textfile	# extract from lzma, needs lzma
= test
53 less tests/compress.tgz:test.tar.xz:tests/textfile	# extract from xz, needs xz
= test
###    call dd also for brotli to keep the script structure clean git #19 (revert)
54 less tests/compress.tgz:test.bro:tests/textfile		# extract from brotli, needs brotli
= test
55 less tests/compress.tgz:test.tar.zst:tests/textfile	# extract from zstandard git #13,20,36,44, needs zstd
= test
56 less tests/compress.tgz:test.tar.lz4:tests/textfile	# extract from lz4 git #14, needs lz4
= test
### filter tests, produce readable output
57 less tests/filter.tgz:test_utf16	# UTF-16 Unicode needs iconv
= test
58 less tests/filter.tgz:test_latin1	# ISO-8859-1 encoded file  needs iconv
= äöü
###    no output if file not modified (watch growing files) git #4,25 (revert)
59 less $T/tests/test_plain			# plain text, no output from lesspipe.sh
= test=a
60 less tests/filter.tgz:test_html		# html text, needs html_converter
~ \s*test
61 less tests/filter.tgz:test_html::	# html unmodified text
~ </head>
62 less tests/filter.tgz:test_pdf		# pdf, needs pdftotext|pdftohtml,html_converter|pdfinfo
= test
63 less tests/filter.tgz:test_ps		# postscript, needs ps2ascii
~ .* test\r?
64 less tests/filter.tgz:test.class	# java class file, needs procyon
~ public class test
65 less tests/filter.tgz:test_docx		# docx (neu) git #24,26,27,37, needs pandoc|docx2txt|libreoffice
= test
66 less tests/filter.tgz:test_pptx		# pptx (neu), needs pptx2md,mdcat|pptx2md,pandoc|libreoffice,html_converter
~ processing slide 1...|.*test.*
67 less tests/filter.tgz:test_xlsx		# xlsx (neu), needs in2csv|xlscat|excel2csv|libreoffice
~ ^test$
68 less tests/filter.tgz:test_odt		# odt, needs pandoc|odt2txt|libreoffice
= test
69 less tests/filter.tgz:test_odp		# odp, needs libreoffice,html_converter
~ \s*test
70 less tests/filter.tgz:test_ods		# ods, needs xlscat|libreoffice,html_converter
~ test
71 less tests/filter.tgz:test_doc		# doc (old), needs wvText|catdoc|libreoffice
~  *test
72 less tests/filter.tgz:test_ppt:ms-powerpoint	# ppt (old), catppt not always working, needs libreoffice,html_converter
~ .*1. test|\s*test
73 less tests/filter.tgz:test_xls		# xls (old), needs in2csv|xls2csv|libreoffice,html_converter
~ ^test$|^"test"$
74 less tests/filter.tgz:test_ooffice1	# openoffice1 (very old), needs sxw2txt|libreoffice
= test
75 less tests/filter.tgz:test_nroff	# man pages etc (nroff), needs groff|mandoc
~ .* Commands
76 less tests/filter.tgz:test_rtf		# rtf, needs unrtf|libreoffice
~ test
77 less tests/filter.tgz:test_dvi		# dvi, needs dvi2tty
~ test
78 less tests/filter.tgz:test_so		# shared library (.so)
~ .* T test
79 less tests/filter.tgz:test.pod		# pod text, needs pod2text|perldoc
~     test
80 less tests/filter.tgz:test.pod:		# unmodified pod text, needs pod2text|perldoc
~ test
81 less tests/filter.tgz:test_nc4		# netcdf, needs h5dump|ncdump
~ data:|\s*DATA .
82 less tests/filter.tgz:test_nc5		# hierarchical data format, needs h5dump|ncdump
~ data:|\s*DATA .
83 less tests/filter.tgz:test_matlab	# matlab git #18, needs matdump
~ r
84 less tests/filter.tgz:matlab.mat	# matlab, not recognized by file, needs matdump
~ r
85 less tests/filter.tgz:test_djvu		# djvu, needs djvutxt
= test 
86 less tests/filter.tgz:test.pem		# SSL related files git #15
~ .* 2038 GMT
87 less tests/filter.tgz:test.bplist	# Apple binary property list, needs plistutil
~ <dict>
###    no test case for decoding gpg/pgp encrypted files git #12
88 less tests/filter.tgz:test_mp3		# mp3 without mp3 extension, needs exiftool, not mediainfo
~ Title .* test
89 less tests/filter.tgz:test_mp3:mp3	# mp3, needs id3v2
~ Title  : test .*
90 less tests/filter.tgz:test_data		# binary data
= test
### colorizing tests (ok should be displayed colored, for MacOSX see git #48)
91 less $T/tests				# directory
c test.jar
92 less tests/archive.tgz			# contents of tar colorized with archive_color
c test_cab
93 less $T/tests/test.c			# C language (vimcolor)
c void
94 LESSCOLORIZER=source-highlight less $T/tests/test.c	# C language (source-highlight) git #3, needs source-highlight
c void
95 less tests/filter.tgz:test.c		# C language from file within archive
c void
96 LESSCOLORIZER='pygmentize -O style=vim' less $T/tests/test.c # allow setting pygmentize style option git #5, needs pygmentize
c void
97 cat $T/tests/test.c|less - :c		# even colorize piped files
c void
98 less tests/filter.tgz:test_html:html	# html colorized text
c head
99 less tests/filter.tgz:test.pod:pod	# unmodified pod text, colorized, needs pod2text|perldoc
c =head1
100 less tests/filter.tgz:test_plain:sh	# plain text, force color (shellscript)
c test
101 less tests/filter.tgz:index.rst		# reStructuredText, needs mdcat
c # test
102 less tests/filter.tgz:test.json		# json, epub and ipynb also covered git #62 (fails if no syntax/json.vim), needs pandoc
c false
103 LESSCOLORIZER=code2color less tests/filter.tgz:t.eclass		# ebuild and eclass file git #9,38,39
c test
104 less tests/filter.tgz:Makefile		# bsd Makefile not (file 5.28) / is (5.39) correctly recognized git #10
c PORTNAME
105 diff -u $T/tests/t.eclass $T/tests/test.c|less - :diff # unified diff piped through less works git #11
c test=a
### github issues (solved and unsolved) and other test cases
106 LESSCOLORIZER=code2color less tests/special.tgz:a-r-R.pl	# colorize works within archives
c sub
107 LESSCOLORIZER=pygmentize less tests/filter.tgz:test_dtb	# device tree blob, needs dtc
c test
108 less $T/tests/a-r-R.pl		# do not call vimcolor with -l extension git #77
c sub
109 less $T/tests/special.tgz:.gitconfig	# colorize known dotfiles git #154
c name
110 LESS= less $T/tests/a-r-R.pl		# name contains -r or -R git #78
= sub test {}
111 less $T/tests/test_zip:non-existent-file	# nonexisting file in a zip archive git #1
~ 
112 LESS= less tests/dir.zip	# do not colorize listing git #140
~ .* dir/
113 less $T/tests/test\ \;\'\"\[\(\{ok		# file name with chars such as ", ' ...
= test
114 less tests/special.tgz:test\ \;\'\"\[\(\{ok	# archive having a file with chars from [ ;"'] etc. in the name
= test
115 less $T/tests/test\[a\]\(b\)\{c\}.zip	# file name with parens, brackets, braces git #69
~ .*test\[a\]\(b\)\{c\}
116 less $T/tests/test\[a\]\(b\)\{c\}.zip:'test\[a\]\(b\)\{c\}'	# contained file with parens etc.
= test
117 less $T/tests/test\[a\]\(b\)\{c\}.zip	# file name with parens, brackets, braces (on the fly)
~ .*test\[a\]\(b\)\{c\}
118 less $T/tests/test\[a\]\(b\)\{c\}.zip:'test\[a\]\(b\)\{c\}'	# contained file with parens etc. (on the fly)
= test
119 less $T/tests/special.tgz=aaa::b::c::d	# file name with colon (use alternate separator)
= test
120 less $T/tests/symlink			# symbolic link to file name with special chars
= test=a
121 cat $T/tests/test_zip|less			# can use pipes with LESSOPEN =|-... git #2
~ .*10240.*
122 cat $T/tests/test_zip|less - :tests/test.tar	# extract files from piped file
~ .* tests/textfile
123 cat $T/tests/test_zip|less - :tests/test.tar:tests/textfile	# extract files from piped archive
~ test
124 cat $T/tests/test_plain|LESSCOLORIZER=code2color less	# display piped text files
~ test=a
125 cat $T/tests/test_plain|less - :plain	# display piped plain text files
~ test=a
126 less +F $T/tests/test_plain			# watch growing files with +F git #4
~ test=a
127 less $T/tests/test_plain :			# even watch growing files without +F
~ test=a
128 less $T/tests/test.jar			# support for jar files git #8,22
~ .* META-INF/
###    colorize markdown files (mdcat) on MacOSX and iTerm2 (see git #48)
