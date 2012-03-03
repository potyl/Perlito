# Do not edit this file - Generated by Perlito5 8.0
use v5;
use utf8;
use strict;
use warnings;
no warnings ('redefine', 'once', 'void', 'uninitialized', 'misc', 'recursion');
use Perlito5::Perl5::Runtime;
our $MATCH = Perlito5::Match->new();
package main;
use v5;
use Perlito5::AST;
package Perlito5::Javascript;
(do {
    sub tab {
        ((my  $level) = shift());
join("", (chr(9)) x $level)
    };
    ((my  %safe_char) = ((chr(36) => 1), (chr(37) => 1), (chr(64) => 1), (chr(38) => 1), ('_' => 1), (',' => 1), ('.' => 1), (':' => 1), (chr(59) => 1), ('-' => 1), ('+' => 1), ('*' => 1), (' ' => 1), ('(' => 1), (')' => 1), ('<' => 1), (chr(61) => 1), ('>' => 1), ('[' => 1), (']' => 1), (chr(123) => 1), (chr(124) => 1), (chr(125) => 1)));
    sub escape_string {
        ((my  $s) = shift());
        (my  @out);
        ((my  $tmp) = '');
        if (($s eq '')) {
            return ((chr(39) . chr(39)))
        };
        for my $i ((0 .. (length($s) - 1))) {
            ((my  $c) = substr($s, $i, 1));
            if (((((((($c ge 'a') && ($c le 'z'))) || ((($c ge 'A') && ($c le 'Z')))) || ((($c ge '0') && ($c le '9')))) || exists($safe_char{$c})))) {
                ($tmp = ($tmp . $c))
            }
            else {
                if (($tmp ne '')) {
                    push(@out, (chr(39) . $tmp . chr(39)) )
                };
                push(@out, ('String.fromCharCode(' . ord($c) . (')')) );
                ($tmp = '')
            }
        };
        if (($tmp ne '')) {
            push(@out, (chr(39) . $tmp . chr(39)) )
        };
        return (join(' + ', @out))
    };
    sub to_str {
        ((my  $cond) = shift());
        if ((((($cond->isa('Perlito5::AST::Apply') && ($cond->code() eq 'circumfix:<( )>')) && $cond->{('arguments')}) && @{$cond->{('arguments')}}))) {
            return (to_str($cond->{('arguments')}->[0]))
        };
        if (((($cond->isa('Perlito5::AST::Val::Buf')) || (($cond->isa('Perlito5::AST::Apply') && ((($cond->code() eq 'substr') || ($cond->code() eq 'join')))))))) {
            return ($cond->emit_javascript())
        }
        else {
            return (('string(' . $cond->emit_javascript() . ')'))
        }
    };
    sub to_num {
        ((my  $cond) = shift());
        if ((($cond->isa('Perlito5::AST::Val::Int') || $cond->isa('Perlito5::AST::Val::Num')))) {
            return ($cond->emit_javascript())
        }
        else {
            return (('num(' . $cond->emit_javascript() . ')'))
        }
    };
    sub to_bool {
        ((my  $cond) = shift());
        if ((((($cond->isa('Perlito5::AST::Apply') && ($cond->code() eq 'circumfix:<( )>')) && $cond->{('arguments')}) && @{$cond->{('arguments')}}))) {
            return (to_bool($cond->{('arguments')}->[0]))
        };
        if ((($cond->isa('Perlito5::AST::Apply') && ((($cond->code() eq 'infix:<' . chr(38) . chr(38) . '>') || ($cond->code() eq 'infix:<and>')))))) {
            return (('(' . to_bool($cond->{('arguments')}->[0]) . ' ' . chr(38) . chr(38) . ' ' . to_bool($cond->{('arguments')}->[1]) . ')'))
        };
        if ((($cond->isa('Perlito5::AST::Apply') && ((($cond->code() eq 'infix:<' . chr(124) . chr(124) . '>') || ($cond->code() eq 'infix:<or>')))))) {
            return (('(' . to_bool($cond->{('arguments')}->[0]) . ' ' . chr(124) . chr(124) . ' ' . to_bool($cond->{('arguments')}->[1]) . ')'))
        };
        if ((((($cond->isa('Perlito5::AST::Val::Int')) || ($cond->isa('Perlito5::AST::Val::Num'))) || (($cond->isa('Perlito5::AST::Apply') && (((((((((((($cond->code() eq 'prefix:<' . chr(33) . '>') || ($cond->code() eq 'infix:<' . chr(33) . chr(61) . '>')) || ($cond->code() eq 'infix:<' . chr(61) . chr(61) . '>')) || ($cond->code() eq 'infix:<<' . chr(61) . '>')) || ($cond->code() eq 'infix:<>' . chr(61) . '>')) || ($cond->code() eq 'infix:<>>')) || ($cond->code() eq 'infix:<<>')) || ($cond->code() eq 'infix:<eq>')) || ($cond->code() eq 'infix:<ne>')) || ($cond->code() eq 'infix:<ge>')) || ($cond->code() eq 'infix:<le>')))))))) {
            return ($cond->emit_javascript())
        }
        else {
            return (('bool(' . $cond->emit_javascript() . ')'))
        }
    };
    sub to_list {
        ((my  $items) = to_list_preprocess($_[0]));
        (@{$items} ? ('interpolate_array(' . join(', ', map($_->emit_javascript(), @{$items})) . ')') : '[]')
    };
    sub to_list_preprocess {
        (my  @items);
        for my $item (@{$_[0]}) {
            if ((($item->isa('Perlito5::AST::Apply') && ((($item->code() eq 'circumfix:<( )>') || ($item->code() eq 'list:<,>')))))) {
                for my $arg (@{to_list_preprocess($item->arguments())}) {
                    push(@items, $arg )
                }
            }
            else {
                if ((($item->isa('Perlito5::AST::Apply') && ($item->code() eq 'infix:<' . chr(61) . '>>')))) {
                    push(@items, $item->arguments()->[0] );
                    push(@items, $item->arguments()->[1] )
                }
                else {
                    push(@items, $item )
                }
            }
        };
        return (\@items)
    }
});
package Perlito5::Javascript::LexicalBlock;
(do {
    sub new {
        ((my  $class) = shift());
        bless({@_}, $class)
    };
    sub block {
        $_[0]->{'block'}
    };
    sub needs_return {
        $_[0]->{'needs_return'}
    };
    sub top_level {
        $_[0]->{'top_level'}
    };
    sub has_decl {
        ((my  $self) = $_[0]);
        ((my  $type) = $_[1]);
        for my $decl (@{$self->{('block')}}) {
            if ((defined($decl))) {
                if ((($decl->isa('Perlito5::AST::Decl') && ($decl->decl() eq $type)))) {
                    return (1)
                };
                if ((($decl->isa('Perlito5::AST::Apply') && ($decl->code() eq 'infix:<' . chr(61) . '>')))) {
                    ((my  $var) = $decl->arguments()->[0]);
                    if ((($var->isa('Perlito5::AST::Decl') && ($var->decl() eq $type)))) {
                        return (1)
                    }
                }
            }
        };
        return (0)
    };
    sub emit_javascript {
        $_[0]->emit_javascript_indented(0)
    };
    sub emit_javascript_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        (my  @block);
        for ((@{$self->{('block')}})) {
            if ((defined($_))) {
                push(@block, $_ )
            }
        };
        if ((!(@block))) {
            return ((Perlito5::Javascript::tab($level) . 'null' . chr(59)))
        };
        ((my  $out) = '');
        (my  @str);
        ((my  $has_local) = $self->has_decl(('local')));
        ((my  $create_context) = ($self->{('create_context')} && $self->has_decl(('my'))));
        ((my  $outer_pkg) = $Perlito5::Javascript::PKG_NAME);
        if ($has_local) {
            ($out = ($out . (Perlito5::Javascript::tab($level) . ('var local_idx ' . chr(61) . ' LOCAL.length' . chr(59) . chr(10)))))
        };
        if (($self->{('top_level')})) {
            ($out = ($out . (Perlito5::Javascript::tab($level) . ('try ' . chr(123) . chr(10)))));
            ($level)++
        };
        if (($create_context)) {
            ($out = ($out . (Perlito5::Javascript::tab($level) . ('(function () ' . chr(123) . chr(10)))));
            ($level)++
        };
        ((my  $tab) = Perlito5::Javascript::tab($level));
        for my $decl (@block) {
            if ((($decl->isa('Perlito5::AST::Decl') && ($decl->decl() eq 'my')))) {
                push(@str, $decl->emit_javascript_init() )
            };
            if ((($decl->isa('Perlito5::AST::Apply') && ($decl->code() eq 'infix:<' . chr(61) . '>')))) {
                ((my  $var) = $decl->arguments()->[0]);
                if ((($var->isa('Perlito5::AST::Decl') && ($var->decl() eq 'my')))) {
                    push(@str, $var->emit_javascript_init() )
                }
            }
        };
        (my  $last_statement);
        if (($self->{('needs_return')})) {
            ($last_statement = pop(@block))
        };
        for my $decl (@block) {
            if ((((ref($decl) eq 'Perlito5::AST::Apply') && ($decl->code() eq 'package')))) {
                ($Perlito5::Javascript::PKG_NAME = $decl->{('namespace')})
            };
            if ((!((($decl->isa('Perlito5::AST::Decl') && ($decl->decl() eq 'my')))))) {
                push(@str, ($decl->emit_javascript_indented($level) . chr(59)) )
            }
        };
        if ((($self->{('needs_return')} && $last_statement))) {
            if (($last_statement->isa('Perlito5::AST::If'))) {
                ((my  $cond) = $last_statement->cond());
                ((my  $body) = $last_statement->body());
                ((my  $otherwise) = $last_statement->otherwise());
                ($body = Perlito5::Javascript::LexicalBlock->new(('block' => $body->stmts()), ('needs_return' => 1)));
                push(@str, ('if ( ' . Perlito5::Javascript::to_bool($cond) . ' ) ' . chr(123) . (chr(10)) . $body->emit_javascript_indented(($level + 1)) . (chr(10)) . Perlito5::Javascript::tab($level) . chr(125)) );
                if (($otherwise)) {
                    ($otherwise = Perlito5::Javascript::LexicalBlock->new(('block' => $otherwise->stmts()), ('needs_return' => 1)));
                    push(@str, (chr(10) . Perlito5::Javascript::tab($level) . 'else ' . chr(123) . (chr(10)) . $otherwise->emit_javascript_indented(($level + 1)) . (chr(10)) . Perlito5::Javascript::tab($level) . chr(125)) )
                }
            }
            else {
                if ((((($last_statement->isa('Perlito5::AST::For') || $last_statement->isa('Perlito5::AST::While')) || ($last_statement->isa('Perlito5::AST::Apply') && ($last_statement->code() eq 'return'))) || ($last_statement->isa('Perlito5::AST::Apply') && ($last_statement->code() eq 'goto'))))) {
                    push(@str, $last_statement->emit_javascript_indented($level) )
                }
                else {
                    if (($has_local)) {
                        push(@str, ('return cleanup_local(local_idx, (' . $last_statement->emit_javascript_indented(($level + 1)) . '))' . chr(59)) )
                    }
                    else {
                        push(@str, ('return (' . $last_statement->emit_javascript_indented(($level + 1)) . ')' . chr(59)) )
                    }
                }
            }
        };
        if (($has_local)) {
            push(@str, 'cleanup_local(local_idx, null)' . chr(59) )
        };
        if (($create_context)) {
            ($level)--;
            push(@str, (chr(125) . ')()' . chr(59)) )
        };
        ($Perlito5::Javascript::PKG_NAME = $outer_pkg);
        if (($self->{('top_level')})) {
            ($level)--;
            return (($out . join((chr(10)), map(($tab . $_), @str)) . (chr(10)) . Perlito5::Javascript::tab($level) . chr(125) . (chr(10)) . Perlito5::Javascript::tab($level) . 'catch(err) ' . chr(123) . (chr(10)) . Perlito5::Javascript::tab(($level + 1)) . 'if ( err instanceof Error ) ' . chr(123) . (chr(10)) . Perlito5::Javascript::tab(($level + 2)) . 'throw(err)' . chr(59) . (chr(10)) . Perlito5::Javascript::tab(($level + 1)) . chr(125) . (chr(10)) . Perlito5::Javascript::tab(($level + 1)) . 'else ' . chr(123) . (chr(10)) . Perlito5::Javascript::tab(($level + 2)) . (($has_local ? 'return cleanup_local(local_idx, err)' : 'return(err)')) . (chr(59) . chr(10)) . Perlito5::Javascript::tab(($level + 1)) . chr(125) . (chr(10)) . Perlito5::Javascript::tab($level) . chr(125)))
        };
        return (($out . join((chr(10)), map(($tab . $_), @str))))
    }
});
package Perlito5::AST::CompUnit;
(do {
    sub emit_javascript {
        ((my  $self) = $_[0]);
        $self->emit_javascript_indented(0)
    };
    sub emit_javascript_indented {
        ((my  $self) = $_[0]);
        ((my  $level) = $_[1]);
        ((my  $outer_pkg) = $Perlito5::Javascript::PKG_NAME);
        ($Perlito5::Javascript::PKG_NAME = $self->{('name')});
        ((my  $str) = ('(function () ' . chr(123) . chr(10) . Perlito5::Javascript::LexicalBlock->new(('block' => $self->{('body')}), ('needs_return' => 0))->emit_javascript_indented(($level + 1)) . (chr(10)) . Perlito5::Javascript::tab($level) . (chr(125) . ')()' . chr(10))));
        ($Perlito5::Javascript::PKG_NAME = $outer_pkg);
        return ($str)
    };
    sub emit_javascript_program {
        ((my  $comp_units) = shift());
        ((my  $str) = '');
        for my $comp_unit (@{$comp_units}) {
            ($str = ($str . $comp_unit->emit_javascript() . (chr(10))))
        };
        return ($str)
    }
});
package Perlito5::AST::Val::Int;
(do {
    sub emit_javascript {
        $_[0]->emit_javascript_indented(0)
    };
    sub emit_javascript_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        $self->{('int')}
    }
});
package Perlito5::AST::Val::Num;
(do {
    sub emit_javascript {
        $_[0]->emit_javascript_indented(0)
    };
    sub emit_javascript_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        $self->{('num')}
    }
});
package Perlito5::AST::Val::Buf;
(do {
    sub emit_javascript {
        $_[0]->emit_javascript_indented(0)
    };
    sub emit_javascript_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        Perlito5::Javascript::escape_string($self->{('buf')})
    }
});
package Perlito5::AST::Lit::Block;
(do {
    sub emit_javascript {
        $_[0]->emit_javascript_indented(0)
    };
    sub emit_javascript_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        ((my  $sig) = 'v__');
        if (($self->{('sig')})) {
            ($sig = $self->{('sig')}->emit_javascript_indented(($level + 1)))
        };
        return ((Perlito5::Javascript::tab($level) . ('(function (' . $sig . ') ' . chr(123) . chr(10)) . (Perlito5::Javascript::LexicalBlock->new(('block' => $self->{('stmts')}), ('needs_return' => 1)))->emit_javascript_indented(($level + 1)) . (chr(10)) . Perlito5::Javascript::tab($level) . chr(125) . ')'))
    }
});
package Perlito5::AST::Index;
(do {
    sub emit_javascript {
        $_[0]->emit_javascript_indented(0)
    };
    sub emit_javascript_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        if ((($self->{('obj')}->isa('Perlito5::AST::Var') && ($self->{('obj')}->sigil() eq chr(36))))) {
            ((my  $v) = Perlito5::AST::Var->new(('sigil' => chr(64)), ('namespace' => $self->{('obj')}->namespace()), ('name' => $self->{('obj')}->name())));
            return (($v->emit_javascript_indented($level) . '[' . $self->{('index_exp')}->emit_javascript() . ']'))
        };
        ('(' . $self->{('obj')}->emit_javascript() . ' ' . chr(124) . chr(124) . ' (' . $self->{('obj')}->emit_javascript() . ' ' . chr(61) . ' new ArrayRef([]))' . ')._array_[' . $self->{('index_exp')}->emit_javascript() . ']')
    }
});
package Perlito5::AST::Lookup;
(do {
    sub emit_javascript {
        $_[0]->emit_javascript_indented(0)
    };
    sub emit_javascript_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        if ((($self->{('obj')}->isa('Perlito5::AST::Var') && ($self->{('obj')}->sigil() eq chr(36))))) {
            ((my  $v) = Perlito5::AST::Var->new(('sigil' => chr(37)), ('namespace' => $self->{('obj')}->namespace()), ('name' => $self->{('obj')}->name())));
            return (($v->emit_javascript_indented($level) . '[' . $self->{('index_exp')}->emit_javascript() . ']'))
        };
        ('(' . $self->{('obj')}->emit_javascript() . ' ' . chr(124) . chr(124) . ' (' . $self->{('obj')}->emit_javascript() . ' ' . chr(61) . ' new HashRef(' . chr(123) . chr(125) . '))' . ')._hash_[' . $self->{('index_exp')}->emit_javascript() . ']')
    }
});
package Perlito5::AST::Var;
(do {
    ((my  $table) = {(chr(36) => 'v_'), (chr(64) => 'List_'), (chr(37) => 'Hash_'), (chr(38) => '')});
    sub emit_javascript {
        $_[0]->emit_javascript_indented(0)
    };
    sub emit_javascript_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        if ((($self->{('sigil')} eq '*'))) {
            return (('NAMESPACE[' . chr(34) . (($self->{('namespace')} || $Perlito5::Javascript::PKG_NAME)) . chr(34) . '][' . chr(34) . $self->{('name')} . chr(34) . ']'))
        };
        ((my  $ns) = '');
        if (($self->{('namespace')})) {
            ($ns = ('NAMESPACE[' . chr(34) . $self->{('namespace')} . chr(34) . '].'))
        };
        ($ns . $table->{$self->{('sigil')}} . $self->{('name')})
    }
});
package Perlito5::AST::Proto;
(do {
    sub emit_javascript {
        $_[0]->emit_javascript_indented(0)
    };
    sub emit_javascript_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        ('CLASS[' . chr(34) . $self->{('name')} . chr(34) . ']')
    }
});
package Perlito5::AST::Call;
(do {
    sub emit_javascript {
        $_[0]->emit_javascript_indented(0)
    };
    sub emit_javascript_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        ((my  $invocant) = $self->{('invocant')}->emit_javascript());
        ((my  $meth) = $self->{('method')});
        if ((($meth eq 'postcircumfix:<[ ]>'))) {
            return (('(' . $invocant . ' ' . chr(124) . chr(124) . ' (' . $invocant . ' ' . chr(61) . ' new ArrayRef([]))' . ')._array_[' . $self->{('arguments')}->emit_javascript() . ']'))
        };
        if ((($meth eq 'postcircumfix:<' . chr(123) . ' ' . chr(125) . '>'))) {
            return (('(' . $invocant . ' ' . chr(124) . chr(124) . ' (' . $invocant . ' ' . chr(61) . ' new HashRef(' . chr(123) . chr(125) . '))' . ')._hash_[' . $self->{('arguments')}->emit_javascript() . ']'))
        };
        if ((($meth eq 'postcircumfix:<( )>'))) {
            ((my  @args) = ());
            for (@{$self->{('arguments')}}) {
                push(@args, $_->emit_javascript() )
            };
            return (('(' . $invocant . ')([' . join(',', @args) . '])'))
        };
        ((my  @args) = ($invocant));
        for (@{$self->{('arguments')}}) {
            push(@args, $_->emit_javascript() )
        };
        return (($invocant . '._class_.' . $meth . '([' . join(',', @args) . '])'))
    }
});
package Perlito5::AST::Apply;
(do {
    ((my  %op_infix_js) = (('infix:<->' => ' - '), ('infix:<*>' => ' * '), ('infix:<' . chr(47) . '>' => ' ' . chr(47) . ' '), ('infix:<>>' => ' > '), ('infix:<<>' => ' < '), ('infix:<>' . chr(61) . '>' => ' >' . chr(61) . ' '), ('infix:<<' . chr(61) . '>' => ' <' . chr(61) . ' '), ('infix:<eq>' => ' ' . chr(61) . chr(61) . ' '), ('infix:<ne>' => ' ' . chr(33) . chr(61) . ' '), ('infix:<le>' => ' <' . chr(61) . ' '), ('infix:<ge>' => ' >' . chr(61) . ' '), ('infix:<' . chr(61) . chr(61) . '>' => ' ' . chr(61) . chr(61) . ' '), ('infix:<' . chr(33) . chr(61) . '>' => ' ' . chr(33) . chr(61) . ' ')));
    sub emit_javascript {
        $_[0]->emit_javascript_indented(0)
    };
    sub emit_javascript_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        ((my  $apply) = $self->op_assign());
        if (($apply)) {
            return ($apply->emit_javascript_indented($level))
        };
        ((my  $code) = $self->{('code')});
        if ((ref(($code ne '')))) {
            ((my  @args) = ());
            for (@{$self->{('arguments')}}) {
                push(@args, $_->emit_javascript() )
            };
            return (('(' . $self->{('code')}->emit_javascript_indented($level) . ')(' . join(',', @args) . ')'))
        };
        if ((($code eq 'package'))) {
            return (('make_package(' . chr(34) . $self->{('namespace')} . chr(34) . ')'))
        };
        if ((($code eq 'infix:<' . chr(61) . '>>'))) {
            return (join(', ', map($_->emit_javascript_indented($level), @{$self->{('arguments')}})))
        };
        if ((exists($op_infix_js{$code}))) {
            return (('(' . join($op_infix_js{$code}, map($_->emit_javascript_indented($level), @{$self->{('arguments')}})) . ')'))
        };
        if ((($code eq 'eval'))) {
            return (('eval(perl5_to_js(' . Perlito5::Javascript::to_str($self->{('arguments')}->[0]) . (', ') . chr(34) . $Perlito5::Javascript::PKG_NAME . chr(34) . '))'))
        };
        if ((($code eq 'undef'))) {
            if ((($self->{('arguments')} && @{$self->{('arguments')}}))) {
                return (('(' . $self->{('arguments')}->[0]->emit_javascript() . ' ' . chr(61) . ' null)'))
            };
            return ('null')
        };
        if ((($code eq 'defined'))) {
            return (('(' . join(' ', map($_->emit_javascript_indented($level), @{$self->{('arguments')}})) . ' ' . chr(33) . chr(61) . ' null)'))
        };
        if ((($code eq 'shift'))) {
            if ((($self->{('arguments')} && @{$self->{('arguments')}}))) {
                return (('NAMESPACE[' . chr(34) . $Perlito5::Javascript::PKG_NAME . chr(34) . '].shift([' . join(', ', map($_->emit_javascript_indented($level), @{$self->{('arguments')}})) . '])'))
            };
            return (('NAMESPACE[' . chr(34) . $Perlito5::Javascript::PKG_NAME . chr(34) . '].shift([List__])'))
        };
        if ((($code eq 'map'))) {
            ((my  $fun) = $self->{('arguments')}->[0]);
            ((my  $list) = $self->{('arguments')}->[1]);
            return (('(function (a_) ' . chr(123) . ' ' . 'var out ' . chr(61) . ' []' . chr(59) . ' ' . 'if ( a_ ' . chr(61) . chr(61) . ' null ) ' . chr(123) . ' return out' . chr(59) . ' ' . chr(125) . chr(59) . ' ' . 'for(var i ' . chr(61) . ' 0' . chr(59) . ' i < a_.length' . chr(59) . ' i++) ' . chr(123) . ' ' . 'var v__ ' . chr(61) . ' a_[i]' . chr(59) . ' ' . 'out.push(' . $fun->emit_javascript_indented($level) . ')' . chr(125) . chr(59) . ' ' . 'return out' . chr(59) . ' ' . chr(125) . ')(' . $list->emit_javascript() . ')'))
        };
        if ((($code eq 'prefix:<' . chr(33) . '>'))) {
            return ((chr(33) . '( ' . Perlito5::Javascript::to_bool($self->{('arguments')}->[0]) . ')'))
        };
        if ((($code eq 'prefix:<' . chr(36) . '>'))) {
            ((my  $arg) = $self->{('arguments')}->[0]);
            return (('(' . $arg->emit_javascript() . ')._scalar_'))
        };
        if ((($code eq 'prefix:<' . chr(64) . '>'))) {
            ((my  $arg) = $self->{('arguments')}->[0]);
            return (('(' . $arg->emit_javascript_indented($level) . ' ' . chr(124) . chr(124) . ' (' . $arg->emit_javascript_indented($level) . ' ' . chr(61) . ' new ArrayRef([]))' . ')._array_'))
        };
        if ((($code eq 'prefix:<' . chr(37) . '>'))) {
            ((my  $arg) = $self->{('arguments')}->[0]);
            return (('(' . $arg->emit_javascript_indented($level) . ')._hash_'))
        };
        if ((($code eq 'circumfix:<[ ]>'))) {
            return (('(new ArrayRef(' . Perlito5::Javascript::to_list($self->{('arguments')}) . '))'))
        };
        if ((($code eq 'circumfix:<' . chr(123) . ' ' . chr(125) . '>'))) {
            return (('(new HashRef(array_to_hash(' . Perlito5::Javascript::to_list($self->{('arguments')}) . ')))'))
        };
        if ((($code eq 'prefix:<' . chr(92) . '>'))) {
            ((my  $arg) = $self->{('arguments')}->[0]);
            if (($arg->isa('Perlito5::AST::Var'))) {
                if ((($arg->sigil() eq chr(64)))) {
                    return (('(new ArrayRef(' . $arg->emit_javascript_indented($level) . '))'))
                };
                if ((($arg->sigil() eq chr(37)))) {
                    return (('(new HashRef(' . $arg->emit_javascript_indented($level) . '))'))
                };
                if ((($arg->sigil() eq chr(38)))) {
                    if (($arg->{('namespace')})) {
                        return (('NAMESPACE[' . chr(34) . $arg->{('namespace')} . chr(34) . '].' . $arg->{('name')}))
                    }
                    else {
                        return (('NAMESPACE[' . chr(34) . $Perlito5::Javascript::PKG_NAME . chr(34) . '].' . $arg->{('name')}))
                    }
                }
            };
            return (('(new ScalarRef(' . $arg->emit_javascript_indented($level) . '))'))
        };
        if ((($code eq 'postfix:<++>'))) {
            return (('(' . join(' ', map($_->emit_javascript(), @{$self->{('arguments')}})) . ')++'))
        };
        if ((($code eq 'postfix:<-->'))) {
            return (('(' . join(' ', map($_->emit_javascript(), @{$self->{('arguments')}})) . ')--'))
        };
        if ((($code eq 'prefix:<++>'))) {
            return (('++(' . join(' ', map($_->emit_javascript(), @{$self->{('arguments')}})) . ')'))
        };
        if ((($code eq 'prefix:<-->'))) {
            return (('--(' . join(' ', map($_->emit_javascript(), @{$self->{('arguments')}})) . ')'))
        };
        if ((($code eq 'infix:<x>'))) {
            return (('str_replicate(' . join(', ', map($_->emit_javascript(), @{$self->{('arguments')}})) . ')'))
        };
        if ((($code eq 'list:<.>'))) {
            return (('(' . join(' + ', map(Perlito5::Javascript::to_str($_), @{$self->{('arguments')}})) . ')'))
        };
        if ((($code eq 'infix:<+>'))) {
            return (('add' . '(' . join(', ', map($_->emit_javascript(), @{$self->{('arguments')}})) . ')'))
        };
        if ((($code eq 'prefix:<+>'))) {
            return (('(' . $self->{('arguments')}->[0]->emit_javascript() . ')'))
        };
        if ((($code eq 'infix:<..>'))) {
            return (('(function (a) ' . chr(123) . ' ' . 'for (var i' . chr(61) . $self->{('arguments')}->[0]->emit_javascript() . ', l' . chr(61) . $self->{('arguments')}->[1]->emit_javascript() . chr(59) . ' ' . 'i<' . chr(61) . 'l' . chr(59) . ' ++i)' . chr(123) . ' ' . 'a.push(i) ' . chr(125) . chr(59) . ' ' . 'return a ' . chr(125) . ')([])'))
        };
        if ((($code eq 'infix:<' . chr(38) . chr(38) . '>') || ($code eq 'infix:<and>'))) {
            return (('and' . '(' . $self->{('arguments')}->[0]->emit_javascript() . ', ' . 'function () ' . chr(123) . ' return ' . $self->{('arguments')}->[1]->emit_javascript() . chr(59) . ' ' . chr(125) . ')'))
        };
        if ((($code eq 'infix:<' . chr(124) . chr(124) . '>') || ($code eq 'infix:<or>'))) {
            return (('or' . '(' . $self->{('arguments')}->[0]->emit_javascript() . ', ' . 'function () ' . chr(123) . ' return ' . $self->{('arguments')}->[1]->emit_javascript() . chr(59) . ' ' . chr(125) . ')'))
        };
        if ((($code eq 'infix:<' . chr(47) . chr(47) . '>'))) {
            return ((('defined_or') . '(' . $self->{('arguments')}->[0]->emit_javascript() . ', ' . 'function () ' . chr(123) . ' return ' . $self->{('arguments')}->[1]->emit_javascript() . chr(59) . ' ' . chr(125) . ')'))
        };
        if ((($code eq 'exists'))) {
            ((my  $arg) = $self->{('arguments')}->[0]);
            if (($arg->isa('Perlito5::AST::Lookup'))) {
                ((my  $v) = $arg->obj());
                if ((($v->isa('Perlito5::AST::Var') && ($v->sigil() eq chr(36))))) {
                    ($v = Perlito5::AST::Var->new(('sigil' => chr(37)), ('namespace' => $v->namespace()), ('name' => $v->name())));
                    return (('(' . $v->emit_javascript() . ').hasOwnProperty(' . ($arg->index_exp())->emit_javascript() . ')'))
                };
                return (('(' . $v->emit_javascript() . ')._hash_.hasOwnProperty(' . ($arg->index_exp())->emit_javascript() . ')'))
            };
            if (($arg->isa('Perlito5::AST::Call'))) {
                if ((($arg->method() eq 'postcircumfix:<' . chr(123) . ' ' . chr(125) . '>'))) {
                    return (('(' . $arg->invocant()->emit_javascript() . ')._hash_.hasOwnProperty(' . $arg->{('arguments')}->emit_javascript() . ')'))
                }
            }
        };
        if ((($code eq 'ternary:<' . chr(63) . chr(63) . ' ' . chr(33) . chr(33) . '>'))) {
            return (('( ' . Perlito5::Javascript::to_bool($self->{('arguments')}->[0]) . ' ' . chr(63) . ' ' . ($self->{('arguments')}->[1])->emit_javascript() . ' : ' . ($self->{('arguments')}->[2])->emit_javascript() . ')'))
        };
        if ((($code eq 'circumfix:<( )>'))) {
            return (('(' . join(', ', map($_->emit_javascript_indented($level), @{$self->{('arguments')}})) . ')'))
        };
        if ((($code eq 'infix:<' . chr(61) . '>'))) {
            return (emit_javascript_bind($self->{('arguments')}->[0], $self->{('arguments')}->[1], $level))
        };
        if ((($code eq 'return'))) {
            return (('throw(' . ((($self->{('arguments')} && @{$self->{('arguments')}}) ? $self->{('arguments')}->[0]->emit_javascript() : 'null')) . ')'))
        };
        if ((($code eq 'goto'))) {
            return (('throw((' . $self->{('arguments')}->[0]->emit_javascript() . ')([List__]))'))
        };
        if (($self->{('namespace')})) {
            if (((($self->{('namespace')} eq 'JS') && ($code eq 'inline')))) {
                if (($self->{('arguments')}->[0]->isa('Perlito5::AST::Val::Buf'))) {
                    return ($self->{('arguments')}->[0]->{('buf')})
                }
                else {
                    die(('JS::inline needs a string constant'))
                }
            };
            ($code = ('NAMESPACE[' . chr(34) . $self->{('namespace')} . chr(34) . '].' . $code))
        }
        else {
            ($code = ('NAMESPACE[' . chr(34) . $Perlito5::Javascript::PKG_NAME . chr(34) . '].' . $code))
        };
        ((my  @args) = ());
        for (@{$self->{('arguments')}}) {
            push(@args, $_->emit_javascript_indented($level) )
        };
        ($code . '([' . join(', ', @args) . '])')
    };
    sub emit_javascript_bind {
        ((my  $parameters) = shift());
        ((my  $arguments) = shift());
        ((my  $level) = shift());
        if ((($parameters->isa('Perlito5::AST::Var') && ($parameters->sigil() eq chr(64))) || ($parameters->isa('Perlito5::AST::Decl') && ($parameters->var()->sigil() eq chr(64))))) {
            return (('(' . $parameters->emit_javascript() . ' ' . chr(61) . ' ' . Perlito5::Javascript::to_list([$arguments]) . ')'))
        }
        else {
            if ((($parameters->isa('Perlito5::AST::Var') && ($parameters->sigil() eq chr(37))) || ($parameters->isa('Perlito5::AST::Decl') && ($parameters->var()->sigil() eq chr(37))))) {
                return (('(' . $parameters->emit_javascript() . ' ' . chr(61) . ' array_to_hash(' . Perlito5::Javascript::to_list([$arguments]) . '))'))
            }
        };
        ('(' . $parameters->emit_javascript_indented($level) . ' ' . chr(61) . ' ' . $arguments->emit_javascript_indented($level) . ')')
    }
});
package Perlito5::AST::If;
(do {
    sub emit_javascript {
        $_[0]->emit_javascript_indented(0)
    };
    sub emit_javascript_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        ((my  $cond) = $self->{('cond')});
        ((my  $body) = Perlito5::Javascript::LexicalBlock->new(('block' => $self->{('body')}->stmts()), ('needs_return' => 0), ('create_context' => 1)));
        ((my  $s) = ('if ( ' . Perlito5::Javascript::to_bool($cond) . ' ) ' . chr(123) . (chr(10)) . $body->emit_javascript_indented(($level + 1)) . (chr(10)) . Perlito5::Javascript::tab($level) . chr(125)));
        if ((@{$self->{('otherwise')}->stmts()})) {
            ((my  $otherwise) = Perlito5::Javascript::LexicalBlock->new(('block' => $self->{('otherwise')}->stmts()), ('needs_return' => 0), ('create_context' => 1)));
            ($s = ($s . (chr(10)) . Perlito5::Javascript::tab($level) . 'else ' . chr(123) . (chr(10)) . $otherwise->emit_javascript_indented(($level + 1)) . (chr(10)) . Perlito5::Javascript::tab($level) . chr(125)))
        };
        return ($s)
    }
});
package Perlito5::AST::While;
(do {
    sub emit_javascript {
        $_[0]->emit_javascript_indented(0)
    };
    sub emit_javascript_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        ((my  $body) = Perlito5::Javascript::LexicalBlock->new(('block' => $self->{('body')}->stmts()), ('needs_return' => 0), ('create_context' => 1)));
        return (('for ( ' . (($self->{('init')} ? ($self->{('init')}->emit_javascript() . chr(59) . ' ') : chr(59) . ' ')) . (($self->{('cond')} ? (Perlito5::Javascript::to_bool($self->{('cond')}) . chr(59) . ' ') : chr(59) . ' ')) . (($self->{('continue')} ? ($self->{('continue')}->emit_javascript() . ' ') : ' ')) . ') ' . chr(123) . (chr(10)) . $body->emit_javascript_indented(($level + 1)) . (chr(10)) . Perlito5::Javascript::tab($level) . chr(125)))
    }
});
package Perlito5::AST::For;
(do {
    sub emit_javascript {
        $_[0]->emit_javascript_indented(0)
    };
    sub emit_javascript_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        ((my  $cond) = Perlito5::Javascript::to_list([$self->{('cond')}]));
        ((my  $body) = Perlito5::Javascript::LexicalBlock->new(('block' => $self->{('body')}->stmts()), ('needs_return' => 0)));
        ((my  $sig) = 'v__');
        if (($self->{('body')}->sig())) {
            ($sig = $self->{('body')}->sig()->emit_javascript_indented(($level + 1)))
        };
        ('(function (a_) ' . chr(123) . ' for (var i_ ' . chr(61) . ' 0' . chr(59) . ' i_ < a_.length ' . chr(59) . ' i_++) ' . chr(123) . ' ' . ('(function (' . $sig . ') ' . chr(123) . chr(10)) . $body->emit_javascript_indented(($level + 1)) . (chr(10)) . Perlito5::Javascript::tab($level) . chr(125) . ')(a_[i_]) ' . chr(125) . ' ' . chr(125) . ')' . '(' . $cond . ')')
    }
});
package Perlito5::AST::Decl;
(do {
    sub emit_javascript {
        $_[0]->emit_javascript_indented(0)
    };
    sub emit_javascript_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        if ((($self->{('decl')} eq 'local'))) {
            ((my  $ns) = ('NAMESPACE[' . chr(34) . (($self->{('var')}->{('namespace')} || $Perlito::Javascript::PKG_NAME)) . chr(34) . ']'));
            return (('set_local(' . $ns . ',' . Perlito5::Javascript::escape_string($self->{('var')}->{('name')}) . ',' . Perlito5::Javascript::escape_string($self->{('var')}->{('sigil')}) . ')' . chr(59) . ' ' . $self->{('var')}->emit_javascript_indented($level)))
        };
        $self->{('var')}->emit_javascript_indented($level)
    };
    sub emit_javascript_init {
        ((my  $self) = shift());
        if ((($self->{('decl')} eq 'my'))) {
            ((my  $str) = '');
            ($str = ($str . 'var ' . ($self->{('var')})->emit_javascript() . ' ' . chr(61) . ' '));
            if ((($self->{('var')})->sigil() eq chr(37))) {
                ($str = ($str . chr(123) . chr(125) . chr(59)))
            }
            else {
                if ((($self->{('var')})->sigil() eq chr(64))) {
                    ($str = ($str . '[]' . chr(59)))
                }
                else {
                    ($str = ($str . 'null' . chr(59)))
                }
            };
            return ($str)
        }
        else {
            die(('not implemented: Perlito5::AST::Decl ' . chr(39) . $self->{('decl')} . (chr(39))))
        }
    }
});
package Perlito5::AST::Sub;
(do {
    sub emit_javascript {
        $_[0]->emit_javascript_indented(0)
    };
    sub emit_javascript_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        ((my  $s) = ('function (List__) ' . chr(123) . (chr(10)) . (Perlito5::Javascript::LexicalBlock->new(('block' => $self->{('block')}), ('needs_return' => 1), ('top_level' => 1)))->emit_javascript_indented(($level + 1)) . (chr(10)) . Perlito5::Javascript::tab($level) . chr(125)));
        (($self->{('name')} ? ('make_sub(' . chr(34) . $Perlito5::Javascript::PKG_NAME . chr(34) . ', ' . chr(34) . $self->{('name')} . chr(34) . ', ' . $s . ')') : $s))
    }
});
package Perlito5::AST::Do;
(do {
    sub emit_javascript {
        $_[0]->emit_javascript_indented(0)
    };
    sub emit_javascript_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        ((my  $block) = $self->simplify()->block());
        return (('(function () ' . chr(123) . (chr(10)) . (Perlito5::Javascript::LexicalBlock->new(('block' => $block), ('needs_return' => 1)))->emit_javascript_indented(($level + 1)) . (chr(10)) . Perlito5::Javascript::tab($level) . chr(125) . ')()'))
    }
});
package Perlito5::AST::Use;
(do {
    sub emit_javascript {
        $_[0]->emit_javascript_indented(0)
    };
    sub emit_javascript_indented {
        ((my  $self) = shift());
        ((my  $level) = shift());
        (chr(47) . chr(47) . ' use ' . $self->{('mod')} . (chr(10)))
    }
});

1;
