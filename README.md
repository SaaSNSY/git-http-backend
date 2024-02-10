A dead simple git smart-http server using nginx as a frontend. No authentication, no SSL, push is free-for-all.

The orignal Alpine based version is at ynohat/git-http-backend on github and Docker hub.
This version is based on the nginx image, which is on a Debian base.

> _caveat emptor_ this is not intended for production use

Usage:

```
docker run -d -p 4080:80 -v /path/to/host/gitdir:/git nsy22/git-http-backend
```

Unauthenticated push will not work unless you enable it in repositories:

```
cd /path/to/host/gitdir
git init --bare test.git
cd test.git
git config http.receivepack true
```

Repos will then be accessible at `http://localhost:4080/git/<repo>.git`.
