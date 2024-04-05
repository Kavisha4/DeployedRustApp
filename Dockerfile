FROM messense/rust-musl-cross:x86_64-musl as builder
ENV SQLX_OFFLINE=true
WORKDIR /api-deployment-example
#Copy all
COPY . .
#Build the app
RUN cargo build --release --target x86_64-unknown-linux-musl

#New minimal image
FROM scratch
COPY --from=builder /api-deployment-example/target/x86_64-unknown-linux-musl/release/api-deployment-example /api-deployment-example
ENTRYPOINT ["/api-deployment-example"]
EXPOSE 3000