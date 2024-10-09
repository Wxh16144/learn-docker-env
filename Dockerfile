FROM alpine:latest

RUN apk add --no-cache bash

WORKDIR /app

COPY print_env.sh /app/print_env.sh

RUN chmod +x /app/print_env.sh

CMD ["/app/print_env.sh"]