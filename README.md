# Clearcode


1. Connect to VM Azure by ssh -i Clearcode_key.pem 40.127.205.205
2. Build image by docker build -t clearcode (path to dockerfile, in my case is .)
3. Run container docker run -d  --rm -p 5001:5001 -t clearcode
4. Check ip this container and type command curl ip_container:5001. If there isn't any problem, it works. 

