FROM golang:1.25 as builder
WORKDIR  /usr/src/app
COPY . .
RUN go mod download
RUN go build -o product-catalog .
FROM alpine as release
WORKDIR /usr/src/app
COPY . .
COPY --from=builder /usr/src/app/product-catalog ./
ENV PRODUCT_CATALOG_PORT 8088
ENTRYPOINT [ "./product-catalog" ]

