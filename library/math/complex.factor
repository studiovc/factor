! Copyright (C) 2004, 2005 Slava Pestov.
! See http://factor.sf.net/license.txt for BSD license.
IN: math-internals
USING: errors generic kernel kernel-internals math ;

: (rect>) ( xr xi -- x )
    dup zero? [ drop ] [ <complex> ] if ; inline

IN: math

UNION: number real complex ;

M: real real ;
M: real imaginary drop 0 ;

M: number = ( n n -- ? ) number= ;

: rect> ( xr xi -- x )
    over real? over real? and [
        (rect>)
    ] [
        "Complex number must have real components" throw
    ] if ; inline

: >rect ( x -- xr xi ) dup real swap imaginary ; inline

: conjugate ( z -- z* ) >rect neg rect> ; inline

: arg ( z -- arg ) >rect swap fatan2 ; inline

: >polar ( z -- abs arg )
    dup abs swap >rect swap fatan2 ; inline

: cis ( theta -- cis ) dup fcos swap fsin rect> ; inline

: polar> ( abs arg -- z ) cis * ; inline

: quadrant ( z -- n ) >rect >r 0 >= 0 1 ? r> 0 >= 0 3 ? bitxor ;

M: complex absq >rect [ sq ] 2apply + ;

IN: math-internals

: 2>rect ( x y -- xr yr xi yi )
    [ [ real ] 2apply ] 2keep [ imaginary ] 2apply ; inline

M: complex number= ( x y -- ? )
    2>rect number= [ number= ] [ 2drop f ] if ;

: *re ( x y -- xr*yr xi*ri ) 2>rect * >r * r> ; inline
: *im ( x y -- xi*yr xr*yi ) 2>rect >r * swap r> * ; inline

M: complex + 2>rect + >r + r> (rect>) ;
M: complex - 2>rect - >r - r> (rect>) ;
M: complex * ( x y -- x*y ) 2dup *re - -rot *im + (rect>) ;

: complex/ ( x y -- r i m )
    #! r = xr*yr+xi*yi, i = xi*yr-xr*yi, m = yr*yr+yi*yi
    dup absq >r 2dup *re + -rot *im - r> ; inline

M: complex / ( x y -- x/y ) complex/ tuck / >r / r> (rect>) ;
M: complex /f ( x y -- x/y ) complex/ tuck /f >r /f r> (rect>) ;

M: complex 1+ >rect >r 1+ r> (rect>) ;
M: complex 1- >rect >r 1- r> (rect>) ;

M: complex abs ( z -- |z| ) absq fsqrt ;

M: complex hashcode ( n -- n )
    >rect >fixnum swap >fixnum bitxor ;