IN: gl USING: kernel words sequences alien arrays namespaces x xlib x11 ;

: >int-array ( seq -- <int-array> )
dup length "int" <c-array> swap dup length >array [ pick set-int-nth ] 2each ;

: >attributes ( seq -- attributes )
0 add [ dup word? [ execute ] [ ] if ] map ;

: choose-visual ( attributes -- XVisualInfo* )
>attributes >int-array dpy get scr get rot glXChooseVisual ;

: create-context ( XVisualInfo* -- GLXContext )
>r dpy get r> 0 <alien> True glXCreateContext ;

: make-current ( GLXContext -- ) >r dpy get win get r> glXMakeCurrent drop ;

: swap-buffers ( -- ) dpy get win get glXSwapBuffers ;