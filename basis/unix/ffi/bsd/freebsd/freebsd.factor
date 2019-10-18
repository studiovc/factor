USING: alien.c-types alien.syntax classes.struct unix.types ;
IN: unix.ffi

CONSTANT: FD_SETSIZE 1024

STRUCT: addrinfo
    { flags int }
    { family int }
    { socktype int }
    { protocol int }
    { addrlen socklen_t }
    { canonname char* }
    { addr void* }
    { next addrinfo* } ;

STRUCT: dirent
    { d_fileno u_int32_t }
    { d_reclen u_int16_t }
    { d_type u_int8_t }
    { d_namlen u_int8_t }
    { d_name char[256] } ;

CONSTANT: EPERM 1
CONSTANT: ENOENT 2
CONSTANT: ESRCH 3
CONSTANT: EINTR 4
CONSTANT: EIO 5
CONSTANT: ENXIO 6
CONSTANT: E2BIG 7
CONSTANT: ENOEXEC 8
CONSTANT: EBADF 9
CONSTANT: ECHILD 10
CONSTANT: EDEADLK 11
CONSTANT: ENOMEM 12
CONSTANT: EACCES 13
CONSTANT: EFAULT 14
CONSTANT: ENOTBLK 15
CONSTANT: EBUSY 16
CONSTANT: EEXIST 17
CONSTANT: EXDEV 18
CONSTANT: ENODEV 19
CONSTANT: ENOTDIR 20
CONSTANT: EISDIR 21
CONSTANT: EINVAL 22
CONSTANT: ENFILE 23
CONSTANT: EMFILE 24
CONSTANT: ENOTTY 25
CONSTANT: ETXTBSY 26
CONSTANT: EFBIG 27
CONSTANT: ENOSPC 28
CONSTANT: ESPIPE 29
CONSTANT: EROFS 30
CONSTANT: EMLINK 31
CONSTANT: EPIPE 32
CONSTANT: EDOM 33
CONSTANT: ERANGE 34
CONSTANT: EAGAIN 35
ALIAS: EWOULDBLOCK EAGAIN
CONSTANT: EINPROGRESS 36
CONSTANT: EALREADY 37
CONSTANT: ENOTSOCK 38
CONSTANT: EDESTADDRREQ 39
CONSTANT: EMSGSIZE 40
CONSTANT: EPROTOTYPE 41
CONSTANT: ENOPROTOOPT 42
CONSTANT: EPROTONOSUPPORT 43
CONSTANT: ESOCKTNOSUPPORT 44
CONSTANT: EOPNOTSUPP 45
ALIAS: ENOTSUP EOPNOTSUPP
CONSTANT: EPFNOSUPPORT 46
CONSTANT: EAFNOSUPPORT 47
CONSTANT: EADDRINUSE 48
CONSTANT: EADDRNOTAVAIL 49
CONSTANT: ENETDOWN 50
CONSTANT: ENETUNREACH 51
CONSTANT: ENETRESET 52
CONSTANT: ECONNABORTED 53
CONSTANT: ECONNRESET 54
CONSTANT: ENOBUFS 55
CONSTANT: EISCONN 56
CONSTANT: ENOTCONN 57
CONSTANT: ESHUTDOWN 58
CONSTANT: ETOOMANYREFS 59
CONSTANT: ETIMEDOUT 60
CONSTANT: ECONNREFUSED 61
CONSTANT: ELOOP 62
CONSTANT: ENAMETOOLONG 63
CONSTANT: EHOSTDOWN 64
CONSTANT: EHOSTUNREACH 65
CONSTANT: ENOTEMPTY 66
CONSTANT: EPROCLIM 67
CONSTANT: EUSERS 68
CONSTANT: EDQUOT 69
CONSTANT: ESTALE 70
CONSTANT: EREMOTE 71
CONSTANT: EBADRPC 72
CONSTANT: ERPCMISMATCH 73
CONSTANT: EPROGUNAVAIL 74
CONSTANT: EPROGMISMATCH 75
CONSTANT: EPROCUNAVAIL 76
CONSTANT: ENOLCK 77
CONSTANT: ENOSYS 78
CONSTANT: EFTYPE 79
CONSTANT: EAUTH 80
CONSTANT: ENEEDAUTH 81
CONSTANT: EIDRM 82
CONSTANT: ENOMSG 83
CONSTANT: EOVERFLOW 84
CONSTANT: ECANCELED 85
CONSTANT: EILSEQ 86
CONSTANT: ENOATTR 87
CONSTANT: EDOOFUS 88
CONSTANT: EBADMSG 89
CONSTANT: EMULTIHOP 90
CONSTANT: ENOLINK 91
CONSTANT: EPROTO 92
