"Perlito6" Perl 5 compiler
==========================

    This is Perlito5, a compiler that implements a subset of Perl 5.
    
Build using make
----------------

    make
        - builds perlito5.js (which runs in node.js)

    make test
        - tests perlito5.js using node.js

    make build-5browser
        - builds html/perlito5.js (which runs in the browser)

-- See [Makefile](Makefile) for more options


Running the tests using "node.js"
---------------------------------

    # this command will compile "perlito5.js"
    perl perlito5.pl -I./src5/lib -Cjs src5/util/perlito5.pl > perlito5.js

    # this will run a single test script
    node perlito5.js -Isrc5/lib t5/01-perlito/01-sanity.t

    # this will run all tests
    prove -r -e 'node perlito5.js -I./src5/lib' t5


Compile the compiler to Javascript into perlito5.js
---------------------------------------------------

-- using perl and perlito5.pl:

    perl perlito5.pl -I./src5/lib -Cjs src5/util/perlito5.pl > perlito5.js

-- using node.js and perlito5.js:

    node perlito5.js -I./src5/lib -Cjs src5/util/perlito5.pl > perlito5-new.js

Compile the compiler to Perl5 using perl
----------------------------------------

    perl perlito5.pl -I./src5/lib -Cperl5 src5/util/perlito5.pl > perlito5-new.pl

Compile perlito5-in-browser using perl
--------------------------------------

    perl util-js/make-perlito5-js.sh


Running the tests using "perl"
------------------------------

    # this will run all tests
    prove -r -e 'perl perlito5.pl -I./src5/lib ' t5


Bootstrap with perl
-------------------

    time perl perlito5.pl -Isrc5/lib -Cperl5 src5/util/perlito5.pl > perlito5-new.pl && diff perlito5-new.pl perlito5.pl ; cp perlito5-new.pl perlito5.pl

Bootstrap with node.js
----------------------

    time node perlito5.js -Isrc5/lib -Cjs src5/util/perlito5.pl > perlito5-new.js && diff perlito5-new.js perlito5.js ; cp perlito5-new.js perlito5.js


Minifying the javascript output
-------------------------------

    The "jsmin" compressor gives 20% compression:
    
      http://crockford.com/javascript/jsmin
    
    $ sudo port install jsmin   # osx
    $ jsmin < perlito5.js > mini-perlito5.js
    $ nice prove -r -e 'node mini-perlito5.js -I./src5/lib' t5
    ...
    All tests successful.



Perlito5 TODO list
==================

CPAN distribution
-----------------

- create Markdown files for github documentation;
- example: http://www.unexpected-vortices.com/sw/rippledoc/quick-markdown-example.html
- in CPAN, convert all the documentation to POD using one of these:

    $ perl -e ' use Markdown::To::POD "markdown_to_pod"; my @text = <>; my $pod = markdown_to_pod(join "", @text); print $pod; ' README

    $ perl -e ' use Markdown::Pod;my $m2p = Markdown::Pod->new; my @text = <>; my $pod = $m2p->markdown_to_pod(markdown => join "", @text); print $pod; ' README


Command-line options
--------------------

-- implement -i switch and ARGVOUT

-- shebang processing:

    #!/usr/bin/perl -pi.orig
    s/foo/bar/;


Libraries
---------

-- these should go into namespace Perlito5X::*

-- Test (implemented as Perlito5::Test)

-- Data::Dumper (implemented as Perlito5X::Dumper)

-- create perlito5-specific libs for:
    feature.pm
    Config.pm
    overload.pm
    bytes.pm
    integer.pm
    lib.pm
    Carp.pm
    Tie::Array
    Tie::Hash
    Tie::Scalar
    Symbol

    alternately, check $^H for strictness - such that perl's own strict.pm just works
    and ${^WARNING_BITS} for warnings


Parser
------

-- test that "use" checks the return value of modules (the "1;" thing)

-- parse example in http://www.perlmonks.org/?node_id=663393

    $ perl perlito5.pl -I src5/lib --bootstrapping -Cperl5 -e ' whatever  / 25 ; # / ; die "this dies!"; '
        whatever(m! 25 ; # !);
        die('this dies!')
    $ perl -MO=Deparse -e ' whatever  / 25 ; # / ; die "this dies!"; '
        'whatever' / 25;
    $ perl -e ' print whatever  / 25 ; # / ; die "this dies!"; '
        this dies! at -e line 1.

-- tailcalls
    same-subroutine tailcalls could execute a "redo" in the current subroutine.

-- "'" meaning "::"
    $'m  # $::m
    $m'  # String found where operator expected

    package X'Y  # X::Y
    package X'   # Invalid version format (non-numeric data)

-- attributes
    http://perldoc.perl.org/attributes.html
    missing MODIFY_CODE_ATTRIBUTES handlers

-- create __DATA__
    %Perlito5::DATA_SECTION contains the __DATA__ for each package

-- compile-time eval() is not bound to the "program" environment, but to the "compiler" environment instead
    see README-perlito5-js near "Compile-time / Run-time interleaving"

    my $v;
    BEGIN { $v = "123" }
    use Module $v;  # $v is not accessible at compile-time

-- work in progress: "-C_globals" compiler switch to test BEGIN time serialization

    $ perl perlito5.pl -I src5/lib --bootstrapping -C_globals -e ' my ($x, $y); { $x }; my $z; @aaa = @X::xxx + $bbb; BEGIN { $aaa = [ 1 .. 5 ]; $bbb = { 5, $aaa }; $ccc = sub { my %x; 123 } } $/; my $s; BEGIN { $s = 3 } BEGIN { *ccc2 = \$ccc; } '

    TODO - identify aliases: [[[ BEGIN { *ccc2 = \$ccc; } ]]] dumps:
          $main::ccc2 = $main::ccc;
        instead of:
          *main::ccc2 = \$main::ccc;

    TODO - lexicals and closures are not dumped

-- parse the regexes
    Note: implemented in Perlito5::Grammar::Regex5
    create an AST for regexes

-- prototypes (signatures)
    http://perldoc.perl.org/perlsub.html#Prototypes

    check that undeclared barewords give the right error
    *foo = sub () { ... }   # does prototype work here?
    check signature in sort()
    fix the prototype for 'stat(*)' (see t/test.pl in the perl test suite)

    '&@' - See Try::Tiny

-- block vs. hash

    $ perl -e ' print {  1, 2 } '
    HASH(0x7fdf3b005450)
    $ perl -e ' print {  1, 2; } '
    syntax error at -e line 1, near "; }"
    Execution of -e aborted due to compilation errors.
    $ perl -e ' sub x { { 1, 2}; }  print x() '
    HASH(0x7fb033805450)
    $ perl -e ' sub x { {; 1, 2} }  print x() , "\n" '
    12
    $ perl -e ' sub x { { 1, 2} }  print x() , "\n" '
    HASH(0x7fad8b805450)
    $ perl -e ' sub x { { 1, 2;} }  print x() , "\n" '
    syntax error at -e line 1, near ";}"
    syntax error at -e line 1, near "} }"
    Execution of -e aborted due to compilation errors.
    $ perl -e ' sub x { { 1 } }  print x() , "\n" '
    1
    $ perl -e ' sub x { { 1, } }  print x() , "\n" '
    HASH(0x7f8b13805450)
    $ perl -e ' sub x { { 1; } }  print x() , "\n" '
    1

-- "namespace" parsing
    tests: t5/01-perlito/26-syntax-namespace.t

    $ perl -e ' { package X; sub print { CORE::print(">$_[1]<\n") } } my $x = bless {}, "X"; print $x "xxx" '
    Not a GLOB reference at -e line 1.

    $ perl -e ' { package X; sub printx { CORE::print(">$_[1]<\n") } } my $x = bless {}, "X"; printx $x "xxx" '
    >xxx<

    $ perl -MO=Deparse -e ' print X:: "xxx" '
    print X 'xxx';

    $ perl -e ' use strict; my $x = X::; print $x '
    X

    $ perl -e ' use strict; my $x = X; print $x '
    Bareword "X" not allowed while "strict subs" in use

    $ perl perlito5.pl -MO=Deparse -e ' ::X::x::y '
    join("", ::{'main::X::'} x main::y);

    $ perl -MO=Deparse -e ' ::X '
    '???';

    $ perl -MO=Deparse -e ' sub X {} ::X '
    sub X { }
    X;

    $ perl -e ' $::X::::X = 3; print $main::X::::X '        # 3
    $ perl -e ' $::X::::X = 3; print $main::main::X::::X '  # 3
    $ perl -e ' $::X::::X = 3; print $main::X::main::X '    # empty
    $ perl -e ' $::X::::X = 3; print $main::X::X '          # empty
    $ perl -e ' $::X::::X = 3; print $::::X::::X '          # empty

-- CORE:: namespace can be used with operators:

    $ perl -MO=Deparse -e ' $x CORE::and $v '
    $v if $x;

    $ perl -MO=Deparse -e ' @v = CORE::qw/ a b c / '
    @v = ('a', 'b', 'c');

    $ perl -MO=Deparse -e ' $x CORE::+ $v '
    CORE:: is not a keyword


-- strict and warnings: create options like 'subs', 'refs'

-- things that work in perlito5, but which are errors in 'perl'

    $ perl -e ' $c (f) '
    syntax error at -e line 1, near "$c ("

    $ perl -e ' my @things= map {  no warnings; 123 } @list; '
    "no" not allowed in expression

    string interpolation with nested quotes of the same type:

        $ perl -e ' " $x{"x"} " '
        String found where operator expected at -e line 1, near "x"} ""


Add tests for fixed bugs
------------------------

    unit tests:

    local() vs. next/redo/last

    our()

    aliasing inside for-loop

    aliasing of subroutine parameters

    prototypes

    ---
    sigils in blocks

    Allowed:

    $ perl -e ' ${ for (1,2,3) {} } '
    $ perl -e ' @{ for (1,2,3) {} } '
    $ perl -e ' %{ for (1,2,3) {} } '
    $ perl -e ' *{ for (1,2,3) {} } '
    $ perl -e ' $#{ for (1,2,3) {} } '
    
    $ perl -e ' $; = 3; print ${ ; } '
    3
    $ perl -e ' $} = 3; print ${ } } '
    3

    Not allowed:

    $ perl -e ' \{ for (1,2,3) {} } '
    syntax error at -e line 1, near "{ for "
    Execution of -e aborted due to compilation errors.
    
    $ perl -e ' $a{ for (1,2,3) {} } '
    syntax error at -e line 1, near "{ for "

    $ perl -e ' print ${ } '
    syntax error at -e line 1, near "${ "
    Execution of -e aborted due to compilation errors.

    ---
    syntax error in hashref subscript - parses 's' as s///:
    ${x->{s}}
    $x->{s}

    $ perl  -e ' use Data::Dumper;  ${ x ->{s} } = 4;  print Dumper \%x '
    #  { 's' => \4 }

    ---
    wrong precedence in keys()

    if (keys %hh != 2) { print "not" }
    parses as: keys(%hh != 2)

    ---
    quotes vs. hash lookups:

        $ perl -e '  q}} '
        # ok

        $ perl -e ' $x{ q}} } '
        Unmatched right curly bracket at -e line 1, at end of line

        $ perl -e ' $x{ q]] } '
        # ok

    ---
    syntax error in ${@} in string
    "${@}";
    ${"};

    syntax error in autoquote: $x{s}
    parses as: $x { s/// }

    ---
    prototypes can change during compilation

    $ perl -e ' my @x; sub z0 ($$@) { zz(99, @_) } sub zz ($$$@) { print "@_\n" } @x=(9,4,6); zz(8,5,@x); z0(8,5,@x); '
    8 5 3           # zz prototype is '$$$@'
    99 8 5 9 4 6    # zz prototype was '@' when z0 was compiled


    ---
    resolve "filehandle" methods

    $ perl -e ' package X; open(X, ">", "x"); X->print(1234) '
    $ cat x
    1234
    $ nodejs perlito5.js -Isrc5/lib -Cjs -e ' package X; open(X, ">", "x"); X->print(1234) '


    ---
    variable declarations in expressions

    our $Verbose ||= 0;
    our (%Cache);
    my $args = @_ or @_ = @$exports;


    ---
    add additional variants of "for"

    # "our" with localization
    $ perl -e ' use strict; our $x = 123; for our $x (1,2,3) { 2 } print "$x\n" '
    123

    # variable in scope with localization
    $ perl -e ' use strict; my $x = 123; for $x (1,2,3) { 2 } print "$x\n" '123
    123


    ---
    add "print", "printf", "say" special parsing - note this is related to indirect object notation

    indirect object notation
    http://lwn.net/Articles/451486/
    http://www.modernperlbooks.com/mt/2009/08/the-problems-with-indirect-object-notation.html
    http://shadow.cat/blog/matt-s-trout/indirect-but-still-fatal/
    http://perlbuzz.com/mechanix/2008/02/the-perils-of-perl-5s-indirect.html

    method Module $param;
    new Class( arg => $value );
    new Class::($args);
    say $config->{output} "This is a diagnostic message!";  # indirect call
    say {$config->{output}} "This is a diagnostic message!"; # say to filehandle

    use Class;
    sub Class {
    warn 'Called Class sub not Class package';
    'Class'
    }
    my $q = Class->new; # calls the Class sub above
    my $s = new Class; # throws a 'Bareword found where operator expected' error
    my $t = Class::->new # this works
    my $u = new Class::; # this also works (even with sub main in the current package)

    sbertrang++ noted this is also valid:
    print( STDERR "123" )


    ---
    add tests for signatures: "empty" _ $ ;$

    ---
    add test for "sub _" should be in package "main"
    $ perl -MO=Deparse -e ' package X; sub _ { 123 } '
    package X;
    sub main::_ {
        123;
    }

    ---
    add test for defined-or vs. m//  (2012/9/25 Конрад Боровски <notifications@github.com>)
    Note: fixed; see test t5/01-perlito/25-syntax-defined-or.t

    $ perl perlito5.pl -Isrc5/lib -Cast-perl5 -e ' shift // 2 '
    Number or Bareword found where operator expected

    $ perl perlito5.pl -Isrc5/lib -Cast-perl5 -e ' shift / 2 '
    Can't find string terminator '/' anywhere before EOF

    ---
    add test for filetest operators special case:
    ' -f($file).".bak" ' should be equivalent to -f "$file.bak"
    parses as -(f($file)).".bak"
    but: ' -f ($file).".bak" '
    parses correctly
    This seems to be because there is a rule that \w followed by '(' is a function call;
    this needs more testing: ' ... and(2) '
    Test: redefine 'and', 'not' and check what works.

    '  $s111++ + $s222 '
    parses as  (+$s222)++

    '  $step++ < $steps '
    Can't find string terminator '>' anywhere before EOF

-- from moritz, Schwern and others at
    http://stackoverflow.com/questions/161872/hidden-features-of-perl

    - you can use letters as delimiters

    $ perl -Mstrict  -wle 'print q bJet another perl hacker.b'
    Jet another perl hacker.

    Likewise you can write regular expressions:

    m xabcx
    # same as m/abc/



Perl6 backend
-------------

-- Running the tests using perl6:

    # TODO - this is not implemented yet
    . util-perl6/setup-perlito5-perl6.sh
    find t5/01-perlito/*.t | perl -ne ' print "*** $_"; chomp; print ` perl perlito5.pl -I./src5/lib -Cperl6 $_ > tmp.p6 && perl6 tmp.p6  ` '



-- keep comments

-- context: wantarray, return-comma
        sub x { return 7, 8 }
    vs. sub x { return (7, 8) }

    use an "out-of-band" parameter to set the call context, like:
    $v = x( :scalar )   # 8
    $v = x( :list   )   # 2

-- <> is lines()

-- 0..$#num to @num.keys

-- choose @*ARGS or @_ in shift() and pop()

-- typeglob assignment

-- "given" statement not implemented

-- refactoring sub arguments
    my $x = $_[0];
    my ($x, $y, @rest) = @_;    # check if @_ is unused elsewhere in the sub

-- placeholder
    my ($a, $, $c) = 1..3;
    ($a, *, $c) = 1..3;

-- __PACKAGE__

-- specialized refactoring for packages that introduce syntax
    Try::Tiny
    List::MoreUtils
    Moose

-- no strict

-- bless

-- tests



Perl5 backend
-------------

-- "given" statement not implemented
-- "default" statement not implemented

-- ${^NAME} needs curly-escaping

-- ${^GLOBAL_PHASE} is not writeable
    workaround in set_global_phase()

- fix regex delimiters, or escape the regexes



Compile-time execution environment
----------------------------------

-- work in progress

-- special backend option "_comp" dumps the compile-time execution environment:

    $ perl perlito5.pl -Isrc5/lib -I. -It -C_comp -e '  (0, undef, undef, @_)[1, 2] ; { 123 } sub x { 456; { 3 } }'
    {
        'block' => [
            {
                'block' => [],
            },
            {
                'block' => [
                    {
                        'block' => [],
                    },
                ],
                'name' => 'main::x',
                'type' => 'sub',
            },
        ],
    }

    $ perl perlito5.pl -Isrc5/lib -I. -It -C_comp -e ' local (undef, undef, @_) ; { 123 } sub x { 456; { my $x = 3 } } local $y; INIT { 123 } BEGIN { $Perlito5::SCOPE->{block}[-1]{xxx} = 3 }'
        change the environment using a BEGIN block


Nice to Have
------------

-- keep comments in AST

-- debugging symbols
-- line numbers in error messages

-- caller()
-- "when"

-- run more of the "perl" test suite

-- proper "use strict" and "use warnings"
-- use the same error messages and warnings as 'perl'

    $ perl -e ' my @x = $x %x '
    Operator or semicolon missing before %x at -e line 1.
    Ambiguous use of % resolved as operator % at -e line 1.
    Illegal modulus zero at -e line 1.

-- no warnings 'redefine';

-- __LINE__, __FILE__

-- INIT{}, END{}
   look at the implementation in perlito6-in-Go

-- source code - remove Perl 6 code such as "token"
   (fixed: This is only loaded if the grammar compiler is needed)

-- *{ $name }{CODE}->();

-- local(*{$caller."::a"}) = \my $a;
-- *{$pkg . "::foo"} = \&bar;

-- local $SIG{__WARN__};

-- bug https://github.com/fglock/Perlito/issues/10
    "Perlito 5 JS has syntax errors"

    Tried

    YUI Compressor online
    and
    Google Closure Compiler
    http://closure-compiler.appspot.com/home

    Both failed with syntax errors.


Oddities
--------

-- from moritz, Schwern and others at
    http://stackoverflow.com/questions/161872/hidden-features-of-perl

    - you can give subs numeric names if you use symbolic references

    $ perl -lwe '*4 = sub { print "yes" }; 4->()'
    yes

-- return value of continue-block

    $ perl -e ' sub x {  { 456 } continue { 789 } } print "@{[ x() ]}\n" '
    456 789

Deprecate
---------

-- Interpreter backend
   this is not being maintained; the code is still in src5/lib/Perlito5/Eval.pm just in case

   alternately, use the interpreter to compute constant foldings

