# Do not edit this file - Generated by Perlito 7.0
use v5;
use utf8;
use strict;
use warnings;
no warnings ('redefine', 'once', 'void', 'uninitialized', 'misc', 'recursion');
use Perlito::Perl5::Runtime;
use Perlito::Perl5::Prelude;
our $MATCH = Perlito::Match->new();
{
package GLOBAL;
    sub new { shift; bless { @_ }, "GLOBAL" }

    # use v6 
;
    {
    package Perlito::Clojure::LexicalBlock;
        sub new { shift; bless { @_ }, "Perlito::Clojure::LexicalBlock" }
        sub block { $_[0]->{block} };
        sub emit_clojure {
            my $self = $_[0];
            if (!(($self->{block}))) {
                return scalar ('nil')
            };
            ((my  $str) = '');
            ((my  $has_my_decl) = 0);
            ((my  $my_decl) = '');
            for my $decl ( @{$self->{block}} ) {
                if ((Main::isa($decl, 'Decl') && (($decl->decl() eq 'my')))) {
                    ($has_my_decl = 1);
                    ($my_decl = ($my_decl . chr(40) . ($decl->var())->emit_clojure() . ' ' . chr(40) . 'sv-undef' . chr(41) . chr(41)))
                };
                if (((Main::isa($decl, 'Bind') && Main::isa(($decl->parameters()), 'Decl')) && ((($decl->parameters())->decl() eq 'my')))) {
                    ($has_my_decl = 1);
                    ($my_decl = ($my_decl . chr(40) . (($decl->parameters())->var())->emit_clojure() . ' ' . chr(40) . 'sv-undef' . chr(41) . chr(41)))
                }
            };
            if ($has_my_decl) {
                ($str = ($str . chr(40) . 'let ' . chr(40) . $my_decl . chr(41) . ' '))
            }
            else {
                ($str = ($str . chr(40) . 'do '))
            };
            for my $decl ( @{$self->{block}} ) {
                if ((!(((Main::isa($decl, 'Decl') && (($decl->decl() eq 'my'))))))) {
                    ($str = ($str . ($decl)->emit_clojure()))
                }
            };
            return scalar (($str . chr(41)))
        }
    }

;
    {
    package CompUnit;
        sub new { shift; bless { @_ }, "CompUnit" }
        sub name { $_[0]->{name} };
        sub attributes { $_[0]->{attributes} };
        sub methods { $_[0]->{methods} };
        sub body { $_[0]->{body} };
        sub emit_clojure {
            my $self = $_[0];
            ((my  $class_name) = Main::to_lisp_namespace($self->{name}));
            ((my  $str) = (chr(59) . chr(59) . ' class ' . $self->{name} . (chr(10))));
            ($str = ($str . chr(40) . 'defpackage ' . $class_name . (chr(10)) . '  ' . chr(40) . ':use common-lisp mp-Main' . chr(41) . chr(41) . (chr(10)) . chr(59) . chr(59) . ' ' . chr(40) . 'in-package ' . $class_name . chr(41) . (chr(10))));
            ((my  $has_my_decl) = 0);
            ((my  $my_decl) = '');
            for my $decl ( @{$self->{body}} ) {
                if ((Main::isa($decl, 'Decl') && (($decl->decl() eq 'my')))) {
                    ($has_my_decl = 1);
                    ($my_decl = ($my_decl . chr(40) . ($decl->var())->emit_clojure() . ' ' . chr(40) . 'sv-undef' . chr(41) . chr(41)))
                };
                if (((Main::isa($decl, 'Bind') && Main::isa(($decl->parameters()), 'Decl')) && ((($decl->parameters())->decl() eq 'my')))) {
                    ($has_my_decl = 1);
                    ($my_decl = ($my_decl . chr(40) . (($decl->parameters())->var())->emit_clojure() . ' ' . chr(40) . 'sv-undef' . chr(41) . chr(41)))
                }
            };
            if ($has_my_decl) {
                ($str = ($str . chr(40) . 'let ' . chr(40) . $my_decl . chr(41) . (chr(10))))
            };
            ($str = ($str . chr(40) . 'if ' . chr(40) . 'not ' . chr(40) . 'ignore-errors ' . chr(40) . 'find-class ' . chr(39) . $class_name . chr(41) . chr(41) . chr(41) . chr(10) . '  ' . chr(40) . 'defclass ' . $class_name . ' ' . chr(40) . chr(41) . ' ' . chr(40) . chr(41) . chr(41) . chr(41) . chr(10) . chr(10) . chr(40) . 'let ' . chr(40) . 'x' . chr(41) . ' ' . chr(10) . '  ' . chr(40) . 'setq x ' . chr(40) . 'make-instance ' . chr(39) . $class_name . chr(41) . chr(41) . chr(10) . '  ' . chr(40) . 'defun proto-' . $class_name . ' ' . chr(40) . chr(41) . ' x' . chr(41) . chr(41) . chr(10)));
            ((my  $dumper) = '');
            for my $decl ( @{$self->{body}} ) {
                if ((Main::isa($decl, 'Decl') && (($decl->decl() eq 'has')))) {
                    ((my  $accessor_name) = ($decl->var())->name());
                    ($dumper = ($dumper . chr(40) . 'let ' . chr(40) . chr(40) . 'm ' . chr(40) . 'make-instance ' . chr(39) . 'mp-Pair' . chr(41) . chr(41) . chr(41) . ' ' . chr(40) . 'setf ' . chr(40) . 'sv-key m' . chr(41) . ' ' . chr(34) . Main::lisp_escape_string($accessor_name) . chr(34) . chr(41) . ' ' . chr(40) . 'setf ' . chr(40) . 'sv-value m' . chr(41) . ' ' . chr(40) . Main::to_lisp_identifier($accessor_name) . ' self' . chr(41) . chr(41) . ' m' . chr(41) . ' '));
                    ($str = ($str . chr(59) . chr(59) . ' has ' . chr(36) . '.' . $accessor_name . chr(10) . chr(40) . 'let ' . chr(40) . chr(40) . 'new-slots ' . chr(40) . 'list ' . chr(40) . 'list :name ' . chr(39) . Main::to_lisp_identifier($accessor_name) . chr(10) . '  :readers ' . chr(39) . chr(40) . Main::to_lisp_identifier($accessor_name) . chr(41) . chr(10) . '  :writers ' . chr(39) . chr(40) . chr(40) . 'setf ' . Main::to_lisp_identifier($accessor_name) . chr(41) . chr(41) . chr(10) . '  :initform ' . chr(39) . chr(40) . 'sv-undef' . chr(41) . chr(10) . '  :initfunction ' . chr(40) . 'constantly ' . chr(40) . 'sv-undef' . chr(41) . chr(41) . chr(41) . chr(41) . chr(41) . chr(41) . chr(10) . chr(40) . 'dolist ' . chr(40) . 'slot-defn ' . chr(40) . 'sb-mop:class-direct-slots ' . chr(40) . 'find-class ' . chr(39) . $class_name . chr(41) . chr(41) . chr(41) . chr(10) . chr(40) . 'push ' . chr(40) . 'list :name ' . chr(40) . 'sb-mop:slot-definition-name slot-defn' . chr(41) . chr(10) . '  :readers ' . chr(40) . 'sb-mop:slot-definition-readers slot-defn' . chr(41) . chr(10) . '  :writers ' . chr(40) . 'sb-mop:slot-definition-writers slot-defn' . chr(41) . chr(10) . '  :initform ' . chr(40) . 'sb-mop:slot-definition-initform slot-defn' . chr(41) . chr(10) . '  :initfunction ' . chr(40) . 'sb-mop:slot-definition-initfunction slot-defn' . chr(41) . chr(41) . chr(10) . 'new-slots' . chr(41) . chr(41) . chr(10) . chr(40) . 'sb-mop:ensure-class ' . chr(39) . $class_name . ' :direct-slots new-slots' . chr(41) . chr(41) . chr(10) . chr(10)))
                };
                if (Main::isa($decl, 'Method')) {
                    ((my  $sig) = $decl->sig());
                    ((my  $invocant) = $sig->invocant());
                    ((my  $pos) = $sig->positional());
                    ((my  $str_specific) = (chr(40) . $invocant->emit_clojure() . ' ' . $class_name . chr(41)));
                    ((my  $str_optionals) = '');
                    for my $field ( @{($pos)} ) {
                        ($str_optionals = ($str_optionals . ' ' . $field->emit_clojure()))
                    };
                    if (($str_optionals)) {
                        ($str_specific = ($str_specific . ' ' . chr(38) . 'optional' . $str_optionals))
                    };
                    ((my  $block) = Perlito::Clojure::LexicalBlock->new(('block' => $decl->block())));
                    ($str = ($str . chr(59) . chr(59) . ' method ' . $decl->name() . chr(10) . chr(40) . 'if ' . chr(40) . 'not ' . chr(40) . 'ignore-errors ' . chr(40) . 'find-method ' . chr(39) . Main::to_lisp_identifier($decl->name()) . ' ' . chr(40) . chr(41) . ' ' . chr(40) . chr(41) . chr(41) . chr(41) . chr(41) . chr(10) . '  ' . chr(40) . 'defmulti ' . Main::to_lisp_identifier($decl->name()) . ' class' . chr(41) . chr(10) . chr(40) . 'defmethod ' . Main::to_lisp_identifier($decl->name()) . ' ' . chr(91) . $str_specific . chr(93) . chr(10) . '  ' . chr(40) . 'block mp6-function' . chr(10) . '    ' . $block->emit_clojure() . chr(41) . chr(41) . chr(10) . chr(10)))
                };
                if (Main::isa($decl, 'Sub')) {
                    ($str = ($str . chr(40) . 'in-package ' . $class_name . chr(41) . (chr(10)) . '  ' . ($decl)->emit_clojure() . (chr(10)) . chr(40) . 'in-package mp-Main' . chr(41) . (chr(10))))
                }
            };
            if (($self->{name} ne 'Pair')) {
                ($str = ($str . chr(40) . 'defmethod sv-perl ' . chr(40) . chr(40) . 'self ' . $class_name . chr(41) . chr(41) . (chr(10)) . '  ' . chr(40) . 'mp-Main::sv-lisp_dump_object ' . chr(34) . '::' . Main::lisp_escape_string($self->{name}) . chr(34) . ' ' . chr(40) . 'list ' . $dumper . chr(41) . chr(41) . chr(41) . (chr(10)) . (chr(10))))
            };
            for my $decl ( @{$self->{body}} ) {
                if ((((!(((Main::isa($decl, 'Decl') && (((($decl->decl() eq 'has')) || (($decl->decl() eq 'my')))))))) && (!((Main::isa($decl, 'Method'))))) && (!((Main::isa($decl, 'Sub')))))) {
                    ($str = ($str . ($decl)->emit_clojure() . (chr(10))))
                }
            };
            if ($has_my_decl) {
                ($str = ($str . chr(41)))
            };
            ($str = ($str . (chr(10)) . (chr(10))))
        }
    }

;
    {
    package Val::Int;
        sub new { shift; bless { @_ }, "Val::Int" }
        sub int { $_[0]->{int} };
        sub emit_clojure {
            my $self = $_[0];
            $self->{int}
        }
    }

;
    {
    package Val::Bit;
        sub new { shift; bless { @_ }, "Val::Bit" }
        sub bit { $_[0]->{bit} };
        sub emit_clojure {
            my $self = $_[0];
            $self->{bit}
        }
    }

;
    {
    package Val::Num;
        sub new { shift; bless { @_ }, "Val::Num" }
        sub num { $_[0]->{num} };
        sub emit_clojure {
            my $self = $_[0];
            $self->{num}
        }
    }

;
    {
    package Val::Buf;
        sub new { shift; bless { @_ }, "Val::Buf" }
        sub buf { $_[0]->{buf} };
        sub emit_clojure {
            my $self = $_[0];
            (chr(34) . Main::lisp_escape_string($self->{buf}) . chr(34))
        }
    }

;
    {
    package Val::Undef;
        sub new { shift; bless { @_ }, "Val::Undef" }
        sub emit_clojure {
            my $self = $_[0];
            chr(40) . 'sv-undef' . chr(41)
        }
    }

;
    {
    package Val::Object;
        sub new { shift; bless { @_ }, "Val::Object" }
        sub class { $_[0]->{class} };
        sub fields { $_[0]->{fields} };
        sub emit_clojure {
            my $self = $_[0];
            ('bless' . chr(40) . Main::perl($self->{fields}, ) . ', ' . Main::perl($self->{class}, ) . chr(41))
        }
    }

;
    {
    package Lit::Array;
        sub new { shift; bless { @_ }, "Lit::Array" }
        sub array1 { $_[0]->{array1} };
        sub emit_clojure {
            my $self = $_[0];
            ((my  $ast) = $self->expand_interpolation());
            return scalar ($ast->emit_clojure())
        }
    }

;
    {
    package Lit::Hash;
        sub new { shift; bless { @_ }, "Lit::Hash" }
        sub hash1 { $_[0]->{hash1} };
        sub emit_clojure {
            my $self = $_[0];
            ((my  $ast) = $self->expand_interpolation());
            return scalar ($ast->emit_clojure())
        }
    }

;
    {
    package Lit::Code;
        sub new { shift; bless { @_ }, "Lit::Code" }
        1
    }

;
    {
    package Lit::Object;
        sub new { shift; bless { @_ }, "Lit::Object" }
        sub class { $_[0]->{class} };
        sub fields { $_[0]->{fields} };
        sub emit_clojure {
            my $self = $_[0];
            if ($self->{fields}) {
                ((my  $fields) = $self->{fields});
                ((my  $str) = '');
                for my $field ( @{($fields)} ) {
                    ($str = ($str . chr(40) . 'setf ' . chr(40) . Main::to_lisp_identifier(($field->[0])->buf()) . ' m' . chr(41) . ' ' . ($field->[1])->emit_clojure() . chr(41)))
                };
                (chr(40) . 'let ' . chr(40) . chr(40) . 'm ' . chr(40) . 'make-instance ' . chr(39) . Main::to_lisp_namespace($self->{class}) . chr(41) . chr(41) . chr(41) . ' ' . $str . ' m' . chr(41))
            }
            else {
                return scalar ((chr(40) . 'make-instance ' . chr(39) . Main::to_lisp_namespace($self->{class}) . chr(41)))
            }
        }
    }

;
    {
    package Index;
        sub new { shift; bless { @_ }, "Index" }
        sub obj { $_[0]->{obj} };
        sub index_exp { $_[0]->{index_exp} };
        sub emit_clojure {
            my $self = $_[0];
            return scalar ((chr(40) . 'elt ' . $self->{obj}->emit_clojure() . ' ' . $self->{index_exp}->emit_clojure() . chr(41)))
        }
    }

;
    {
    package Lookup;
        sub new { shift; bless { @_ }, "Lookup" }
        sub obj { $_[0]->{obj} };
        sub index_exp { $_[0]->{index_exp} };
        sub emit_clojure {
            my $self = $_[0];
            if (Main::isa($self->{obj}, 'Var')) {
                if (((($self->{obj}->name() eq 'MATCH')) || (($self->{obj}->name() eq chr(47))))) {
                    return scalar ((chr(40) . 'gethash ' . $self->{index_exp}->emit_clojure() . ' ' . chr(40) . 'sv-hash ' . $self->{obj}->emit_clojure() . chr(41) . chr(41)))
                }
            };
            return scalar ((chr(40) . 'gethash ' . $self->{index_exp}->emit_clojure() . ' ' . $self->{obj}->emit_clojure() . chr(41)))
        }
    }

;
    {
    package Var;
        sub new { shift; bless { @_ }, "Var" }
        sub sigil { $_[0]->{sigil} };
        sub twigil { $_[0]->{twigil} };
        sub namespace { $_[0]->{namespace} };
        sub name { $_[0]->{name} };
        sub emit_clojure {
            my $self = $_[0];
            ((my  $ns) = '');
            if ($self->{namespace}) {
                ($ns = (Main::to_lisp_namespace($self->{namespace}) . '::'))
            };
            ((($self->{twigil} eq '.')) ? ((chr(40) . Main::to_lisp_identifier($self->{name}) . ' sv-self' . chr(41))) : (((($self->{name} eq chr(47))) ? (Main::to_lisp_identifier('MATCH')) : (($ns . Main::to_lisp_identifier($self->{name}))))))
        }
    }

;
    {
    package Bind;
        sub new { shift; bless { @_ }, "Bind" }
        sub parameters { $_[0]->{parameters} };
        sub arguments { $_[0]->{arguments} };
        sub emit_clojure {
            my $self = $_[0];
            if (Main::isa($self->{parameters}, 'Lit::Object')) {
                ((my  $class) = $self->{parameters}->class());
                ((my  $a) = $self->{parameters}->fields());
                ((my  $b) = $self->{arguments});
                ((my  $str) = 'do ' . chr(123) . ' ');
                ((my  $i) = 0);
                (my  $arg);
                for my $var ( @{($a)} ) {
                    ((my  $bind) = Bind->new(('parameters' => $var->[1]), ('arguments' => Call->new(('invocant' => $b), ('method' => ($var->[0])->buf()), ('arguments' => do {
    (my  $List_a = bless [], 'ARRAY');
    (my  $List_v = bless [], 'ARRAY');
    $List_a
}), ('hyper' => 0)))));
                    ($str = ($str . ' ' . $bind->emit_clojure() . ' '));
                    ($i = ($i + 1))
                };
                return scalar (($str . $self->{parameters}->emit_clojure() . ' ' . chr(125)))
            };
            if ((Main::isa($self->{parameters}, 'Decl') && (($self->{parameters}->decl() eq 'my')))) {
                return scalar ((chr(40) . 'setf ' . ($self->{parameters}->var())->emit_clojure() . ' ' . $self->{arguments}->emit_clojure() . chr(41)))
            };
            (chr(40) . 'setf ' . $self->{parameters}->emit_clojure() . ' ' . $self->{arguments}->emit_clojure() . chr(41))
        }
    }

;
    {
    package Proto;
        sub new { shift; bless { @_ }, "Proto" }
        sub name { $_[0]->{name} };
        sub emit_clojure {
            my $self = $_[0];
            (chr(40) . 'proto-' . Main::to_lisp_namespace($self->{name}) . chr(41))
        }
    }

;
    {
    package Call;
        sub new { shift; bless { @_ }, "Call" }
        sub invocant { $_[0]->{invocant} };
        sub hyper { $_[0]->{hyper} };
        sub method { $_[0]->{method} };
        sub arguments { $_[0]->{arguments} };
        sub emit_clojure {
            my $self = $_[0];
            ((my  $arguments) = '');
            if ($self->{arguments}) {
                ($arguments = Main::join(([ map { $_->emit_clojure() } @{( $self->{arguments} )} ]), ' '))
            };
            ((my  $invocant) = $self->{invocant}->emit_clojure());
            if (($invocant eq 'self')) {
                ($invocant = 'sv-self')
            };
            if ((($self->{method} eq 'values'))) {
                if (($self->{hyper})) {
                    die(('not implemented'))
                }
                else {
                    return scalar ((chr(64) . chr(123) . $invocant . chr(125)))
                }
            };
            if (($self->{method} eq 'isa')) {
                if (((($self->{arguments}->[0])->buf()) eq 'Str')) {
                    return scalar ((chr(40) . 'typep ' . $invocant . ' ' . chr(39) . 'string' . chr(41)))
                };
                return scalar ((chr(40) . 'typep ' . $invocant . ' ' . chr(39) . Main::to_lisp_namespace(($self->{arguments}->[0])->buf()) . chr(41)))
            };
            if (($self->{method} eq 'chars')) {
                if (($self->{hyper})) {
                    die(('not implemented'))
                }
                else {
                    return scalar ((chr(40) . 'length ' . $invocant . chr(41)))
                }
            };
            if (((($self->{method} eq 'yaml')) || (($self->{method} eq 'say')))) {
                if (($self->{hyper})) {
                    return scalar ((chr(91) . ' map ' . chr(123) . ' ' . $self->{method} . chr(40) . ' ' . chr(36) . '_, ' . ', ' . $arguments . chr(41) . ' ' . chr(125) . ' ' . chr(64) . chr(123) . ' ' . $invocant . ' ' . chr(125) . ' ' . chr(93)))
                }
                else {
                    return scalar ((chr(40) . $self->{method} . ' ' . $invocant . ' ' . $arguments . chr(41)))
                }
            };
            ((my  $meth) = (Main::to_lisp_identifier($self->{method}) . ' '));
            if (($self->{method} eq 'postcircumfix:' . chr(60) . chr(40) . ' ' . chr(41) . chr(62))) {
                ($meth = '')
            };
            if (($self->{hyper})) {
                (chr(40) . 'mapcar ' . chr(35) . chr(39) . $meth . $invocant . chr(41))
            }
            else {
                return scalar ((chr(40) . $meth . $invocant . ' ' . $arguments . chr(41)))
            }
        }
    }

;
    {
    package Apply;
        sub new { shift; bless { @_ }, "Apply" }
        sub code { $_[0]->{code} };
        sub arguments { $_[0]->{arguments} };
        sub namespace { $_[0]->{namespace} };
        sub emit_clojure {
            my $self = $_[0];
            ((my  $ns) = '');
            if ($self->{namespace}) {
                ($ns = (Main::to_lisp_namespace($self->{namespace}) . '::'))
            };
            ((my  $code) = ($ns . $self->{code}));
            ((my  $args) = '');
            if ($self->{arguments}) {
                ($args = Main::join(([ map { $_->emit_clojure() } @{( $self->{arguments} )} ]), ' '))
            };
            if (($code eq 'self')) {
                return scalar ('sv-self')
            };
            if (($code eq 'False')) {
                return scalar ('nil')
            };
            if (($code eq 'make')) {
                return scalar ((chr(40) . 'return-from mp6-function ' . $args . chr(41)))
            };
            if (($code eq 'substr')) {
                return scalar ((chr(40) . 'sv-substr ' . $args . chr(41)))
            };
            if (($code eq 'say')) {
                return scalar ((chr(40) . 'mp-Main::sv-say ' . chr(40) . 'list ' . $args . chr(41) . chr(41)))
            };
            if (($code eq 'print')) {
                return scalar ((chr(40) . 'mp-Main::sv-print ' . chr(40) . 'list ' . $args . chr(41) . chr(41)))
            };
            if (($code eq 'infix:' . chr(60) . chr(126) . chr(62))) {
                return scalar ((chr(40) . 'concatenate ' . chr(39) . 'string ' . chr(40) . 'sv-string ' . ($self->{arguments}->[0])->emit_clojure() . chr(41) . ' ' . chr(40) . 'sv-string ' . ($self->{arguments}->[1])->emit_clojure() . chr(41) . chr(41)))
            };
            if (($code eq 'warn')) {
                return scalar ((chr(40) . 'write-line ' . chr(40) . 'format nil ' . chr(34) . chr(126) . chr(123) . chr(126) . 'a' . chr(126) . chr(125) . chr(34) . ' ' . chr(40) . 'list ' . $args . chr(41) . chr(41) . ' *error-output*' . chr(41)))
            };
            if (($code eq 'die')) {
                return scalar ((chr(40) . 'do ' . chr(40) . 'write-line ' . chr(40) . 'format nil ' . chr(34) . chr(126) . chr(123) . chr(126) . 'a' . chr(126) . chr(125) . chr(34) . ' ' . chr(40) . 'list ' . $args . chr(41) . chr(41) . ' *error-output*' . chr(41) . ' ' . chr(40) . 'sb-ext:quit' . chr(41) . chr(41)))
            };
            if (($code eq 'array')) {
                return scalar ($args)
            };
            if (($code eq 'prefix:' . chr(60) . chr(126) . chr(62))) {
                return scalar ((chr(40) . 'sv-string ' . $args . chr(41)))
            };
            if (($code eq 'prefix:' . chr(60) . chr(33) . chr(62))) {
                return scalar ((chr(40) . 'not ' . chr(40) . 'sv-bool ' . $args . chr(41) . chr(41)))
            };
            if (($code eq 'prefix:' . chr(60) . chr(63) . chr(62))) {
                return scalar ((chr(40) . 'sv-bool ' . $args . chr(41)))
            };
            if (($code eq 'prefix:' . chr(60) . chr(36) . chr(62))) {
                return scalar ((chr(40) . 'sv-scalar ' . $args . chr(41)))
            };
            if (($code eq 'prefix:' . chr(60) . chr(64) . chr(62))) {
                return scalar ($args)
            };
            if (($code eq 'prefix:' . chr(60) . chr(37) . chr(62))) {
                return scalar ($args)
            };
            if (($code eq 'infix:' . chr(60) . '+' . chr(62))) {
                return scalar ((chr(40) . '+ ' . $args . chr(41)))
            };
            if (($code eq 'infix:' . chr(60) . '-' . chr(62))) {
                return scalar ((chr(40) . '-' . $args . chr(41)))
            };
            if (($code eq 'infix:' . chr(60) . chr(62) . chr(62))) {
                return scalar ((chr(40) . chr(62) . ' ' . $args . chr(41)))
            };
            if (($code eq 'infix:' . chr(60) . chr(38) . chr(38) . chr(62))) {
                return scalar ((chr(40) . 'sv-and ' . $args . chr(41)))
            };
            if (($code eq 'infix:' . chr(60) . chr(124) . chr(124) . chr(62))) {
                return scalar ((chr(40) . 'sv-or ' . $args . chr(41)))
            };
            if (($code eq 'infix:' . chr(60) . 'eq' . chr(62))) {
                return scalar ((chr(40) . 'sv-eq ' . $args . chr(41)))
            };
            if (($code eq 'infix:' . chr(60) . 'ne' . chr(62))) {
                return scalar ((chr(40) . 'not ' . chr(40) . 'sv-eq ' . $args . chr(41) . chr(41)))
            };
            if (($code eq 'infix:' . chr(60) . chr(61) . chr(61) . chr(62))) {
                return scalar ((chr(40) . 'eql ' . $args . chr(41)))
            };
            if (($code eq 'infix:' . chr(60) . chr(33) . chr(61) . chr(62))) {
                return scalar ((chr(40) . 'not ' . chr(40) . 'eql ' . $args . chr(41) . chr(41)))
            };
            if (($code eq 'ternary:' . chr(60) . chr(63) . chr(63) . ' ' . chr(33) . chr(33) . chr(62))) {
                return scalar ((chr(40) . 'if ' . chr(40) . 'sv-bool ' . ($self->{arguments}->[0])->emit_clojure() . chr(41) . ' ' . ($self->{arguments}->[1])->emit_clojure() . ' ' . ($self->{arguments}->[2])->emit_clojure() . chr(41)))
            };
            return scalar ((chr(40) . $ns . Main::to_lisp_identifier($self->{code}) . ' ' . $args . chr(41)))
        }
    }

;
    {
    package Return;
        sub new { shift; bless { @_ }, "Return" }
        sub result { $_[0]->{result} };
        sub emit_clojure {
            my $self = $_[0];
            return scalar ((chr(40) . 'return-from mp6-function ' . $self->{result}->emit_clojure() . chr(41)))
        }
    }

;
    {
    package If;
        sub new { shift; bless { @_ }, "If" }
        sub cond { $_[0]->{cond} };
        sub body { $_[0]->{body} };
        sub otherwise { $_[0]->{otherwise} };
        sub emit_clojure {
            my $self = $_[0];
            ((my  $block1) = Perlito::Clojure::LexicalBlock->new(('block' => $self->{body})));
            ((my  $block2) = Perlito::Clojure::LexicalBlock->new(('block' => $self->{otherwise})));
            (chr(40) . 'if ' . chr(40) . 'sv-bool ' . $self->{cond}->emit_clojure() . chr(41) . ' ' . $block1->emit_clojure() . ' ' . $block2->emit_clojure() . chr(41))
        }
    }

;
    {
    package For;
        sub new { shift; bless { @_ }, "For" }
        sub cond { $_[0]->{cond} };
        sub body { $_[0]->{body} };
        sub topic { $_[0]->{topic} };
        sub emit_clojure {
            my $self = $_[0];
            ((my  $cond) = $self->{cond});
            ((my  $block) = Perlito::Clojure::LexicalBlock->new(('block' => $self->{body})));
            if ((Main::isa($cond, 'Var') && ($cond->sigil() eq chr(64)))) {
                ($cond = Apply->new(('code' => 'prefix:' . chr(60) . chr(64) . chr(62)), ('arguments' => do {
    (my  $List_a = bless [], 'ARRAY');
    (my  $List_v = bless [], 'ARRAY');
    push( @{$List_a}, $cond );
    $List_a
})))
            };
            (chr(40) . 'dolist ' . chr(40) . $self->{topic}->emit_clojure() . ' ' . $cond->emit_clojure() . chr(41) . ' ' . $block->emit_clojure() . chr(41))
        }
    }

;
    {
    package Decl;
        sub new { shift; bless { @_ }, "Decl" }
        sub decl { $_[0]->{decl} };
        sub type { $_[0]->{type} };
        sub var { $_[0]->{var} };
        sub emit_clojure {
            my $self = $_[0];
            ((my  $decl) = $self->{decl});
            ((my  $name) = $self->{var}->name());
            ((($decl eq 'has')) ? (('sub ' . $name . ' ' . chr(123) . ' ' . chr(64) . '_ ' . chr(61) . chr(61) . ' 1 ' . chr(63) . ' ' . chr(40) . ' ' . chr(36) . '_' . chr(91) . '0' . chr(93) . '-' . chr(62) . chr(123) . $name . chr(125) . ' ' . chr(41) . ' ' . ': ' . chr(40) . ' ' . chr(36) . '_' . chr(91) . '0' . chr(93) . '-' . chr(62) . chr(123) . $name . chr(125) . ' ' . chr(61) . ' ' . chr(36) . '_' . chr(91) . '1' . chr(93) . ' ' . chr(41) . ' ' . chr(125))) : ($self->{decl} . ' ' . $self->{type} . ' ' . $self->{var}->emit_clojure()))
        }
    }

;
    {
    package Sig;
        sub new { shift; bless { @_ }, "Sig" }
        sub invocant { $_[0]->{invocant} };
        sub positional { $_[0]->{positional} };
        sub named { $_[0]->{named} };
        sub emit_clojure {
            my $self = $_[0];
            ' print ' . chr(39) . 'Signature - TODO' . chr(39) . chr(59) . ' die ' . chr(39) . 'Signature - TODO' . chr(39) . chr(59) . ' '
        }
    }

;
    {
    package Method;
        sub new { shift; bless { @_ }, "Method" }
        sub name { $_[0]->{name} };
        sub sig { $_[0]->{sig} };
        sub block { $_[0]->{block} };
        sub emit_clojure {
            my $self = $_[0];

        }
    }

;
    {
    package Sub;
        sub new { shift; bless { @_ }, "Sub" }
        sub name { $_[0]->{name} };
        sub sig { $_[0]->{sig} };
        sub block { $_[0]->{block} };
        sub emit_clojure {
            my $self = $_[0];
            ((my  $sig) = $self->{sig});
            ((my  $pos) = $sig->positional());
            ((my  $block) = Perlito::Clojure::LexicalBlock->new(('block' => $self->{block})));
            (my  $str);
            if (($pos)) {
                for my $field ( @{($pos)} ) {
                    ($str = ($str . $field->emit_clojure() . ' '))
                }
            };
            if ($str) {
                ($str = (chr(38) . 'optional ' . $str))
            };
            if ($self->{name}) {
                (chr(40) . 'defun ' . Main::to_lisp_identifier($self->{name}) . ' ' . chr(40) . $str . chr(41) . (chr(10)) . '  ' . chr(40) . 'block mp6-function ' . $block->emit_clojure() . chr(41) . chr(41) . (chr(10)))
            }
            else {
                (chr(40) . 'fn ' . $self->{name} . ' ' . chr(91) . $str . chr(93) . (chr(10)) . '  ' . chr(40) . 'block mp6-function ' . $block->emit_clojure() . chr(41) . chr(41) . (chr(10)))
            }
        }
    }

;
    {
    package Do;
        sub new { shift; bless { @_ }, "Do" }
        sub block { $_[0]->{block} };
        sub emit_clojure {
            my $self = $_[0];
            ((my  $block) = Perlito::Clojure::LexicalBlock->new(('block' => $self->{block})));
            return scalar ($block->emit_clojure())
        }
    }

;
    {
    package Use;
        sub new { shift; bless { @_ }, "Use" }
        sub mod { $_[0]->{mod} };
        sub emit_clojure {
            my $self = $_[0];
            (chr(10) . chr(59) . chr(59) . ' use ' . Main::to_lisp_namespace($self->{mod}) . (chr(10)))
        }
    }


}

1;
