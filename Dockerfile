FROM debian:10-slim
ENV PATH=/app/bin:$PATH
WORKDIR /app
RUN apt update && apt -y upgrade
RUN apt -y install wget && apt -y install zip
# RUN wget https://github.com/JohannesRonski/defichain-ain/releases/download/v2.8.1-pool-history-rc/defichain-2.8.1-pool-history-fix.zip
# RUN unzip -o defichain-2.8.1-pool-history-fix.zip -d .
# RUN rm defichain-2.8.1-pool-history-fix.zip
COPY /build/defichain-latest/ .
RUN useradd --create-home defi && \
    mkdir -p /.defi && \
    chown defi:defi /.defi && \
    ln -s /.defi /home/defi/.defi
VOLUME ["/.defi"]

USER defi:defi
CMD ["sh", "-c", "exec /app/bin/defid -blocksonly -disablewallet -datadir=/.defi $COMMANDS" ]

EXPOSE 8555 8554 18555 18554 19555 19554