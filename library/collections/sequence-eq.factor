! Copyright (C) 2005 Slava Pestov.
! See http://factorcode.org/license.txt for BSD license.
IN: sequences
USING: arrays kernel lists math sequences-internals strings
vectors ;

! Note that the sequence union does not include lists, or user
! defined tuples that respond to the sequence protocol.
UNION: sequence array string sbuf vector ;

: sequence= ( seq seq -- ? )
    2dup [ length ] 2apply = [
        dup length [ >r 2dup r> 2nth-unsafe = ] all? 2nip
    ] [
        2drop f
    ] if ; inline

M: sequence = ( obj seq -- ? )
    2dup eq? [
        2drop t
    ] [
        over type over type eq? [ sequence= ] [ 2drop f ] if
    ] if ;

M: sequence hashcode ( seq -- n )
    #! Poor
    length ;

M: string = ( obj str -- ? )
    over string? [
        over hashcode over hashcode number=
        [ sequence= ] [ 2drop f ] if
    ] [
        2drop f
    ] if ;