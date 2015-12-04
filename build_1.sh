cd /build && \
    git clone --recursive https://github.com/neutrinolabs/xrdp.git && \
    cd xrdp && \
    ./bootstrap && \
    ./configure && \
    make


cd /build/xrdp/sesman/chansrv/pulse 
sed -i -e 's/PULSE_DIR = .*$/PULSE_DIR = \/root\/pulseaudio-4.0/' Makefile 
make 
    
cd /build/xrdp
make install 
xrdp-keygen xrdp auto && \
    cp instfiles/pam.d/xrdp-sesman.other /etc/pam.d/xrdp-sesman && \

cd /build/xrdp/xorg/X11R7.6 && \
    ./buildx.sh /opt/X11rdp && \
    ln -s /opt/X11rdp/bin/X11rdp /usr/local/bin/X11rdp && \
    cp /etc/xrdp/xrdp.sh /etc/init.d/
