! Copyright (C) 2015 Doug Coleman.
! See http://factorcode.org/license.txt for BSD license.
IN: alien.accessors

PRIMITIVE: alien-cell ( c-ptr n -- value )
PRIMITIVE: alien-double ( c-ptr n -- value )
PRIMITIVE: alien-float ( c-ptr n -- value )
PRIMITIVE: alien-signed-1 ( c-ptr n -- value )
PRIMITIVE: alien-signed-2 ( c-ptr n -- value )
PRIMITIVE: alien-signed-4 ( c-ptr n -- value )
PRIMITIVE: alien-signed-8 ( c-ptr n -- value )
PRIMITIVE: alien-signed-cell ( c-ptr n -- value )
PRIMITIVE: alien-unsigned-1 ( c-ptr n -- value )
PRIMITIVE: alien-unsigned-2 ( c-ptr n -- value )
PRIMITIVE: alien-unsigned-4 ( c-ptr n -- value )
PRIMITIVE: alien-unsigned-8 ( c-ptr n -- value )
PRIMITIVE: alien-unsigned-cell ( c-ptr n -- value )
PRIMITIVE: set-alien-cell ( value c-ptr n -- )
PRIMITIVE: set-alien-double ( value c-ptr n -- )
PRIMITIVE: set-alien-float ( value c-ptr n -- )
PRIMITIVE: set-alien-signed-1 ( value c-ptr n -- )
PRIMITIVE: set-alien-signed-2 ( value c-ptr n -- )
PRIMITIVE: set-alien-signed-4 ( value c-ptr n -- )
PRIMITIVE: set-alien-signed-8 ( value c-ptr n -- )
PRIMITIVE: set-alien-signed-cell ( value c-ptr n -- )
PRIMITIVE: set-alien-unsigned-1 ( value c-ptr n -- )
PRIMITIVE: set-alien-unsigned-2 ( value c-ptr n -- )
PRIMITIVE: set-alien-unsigned-4 ( value c-ptr n -- )
PRIMITIVE: set-alien-unsigned-8 ( value c-ptr n -- )
PRIMITIVE: set-alien-unsigned-cell ( value c-ptr n -- )