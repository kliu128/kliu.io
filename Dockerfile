FROM jguyomard/hugo-builder
COPY . /src
RUN hugo --destination "/build"

FROM nginx:alpine
COPY --from=0 /build /usr/share/nginx/html
