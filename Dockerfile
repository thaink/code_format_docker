FROM golang:1.13.7
WORKDIR /app
COPY format_code.sh .
RUN apt-get update && apt-get install clang-format default-jre -y
RUN go get github.com/bazelbuild/buildtools/buildifier
RUN curl -LJO "https://github.com/google/google-java-format/releases/download/google-java-format-1.7/google-java-format-1.7-all-deps.jar"
CMD bash format_code.sh /git_dir
