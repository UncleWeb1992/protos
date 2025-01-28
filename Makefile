PROTO_DIR := proto        # Директория с .proto файлами
PROTO_FILE := proto/sso/sso.proto #.proto Файл
OUT_DIR := ./gen/go         # Директория для сгенерированных файлов
PROTOC := protoc          # Команда для компиляции protobuf
GO_FLAGS := --go_out=$(OUT_DIR) --go_opt=paths=source_relative --go-grpc_out=$(OUT_DIR) --go-grpc_opt=paths=source_relative # Флаги для Go

# Определение операционной системы
OS := $(shell uname -s)

# Правило по умолчанию
.PHONY: all
all: generate

# Генерация protobuf
.PHONY: generate
generate: $(OUT_DIR)
	@$(PROTOC) -I=$(PROTO_DIR) $(PROTO_FILE) $(GO_FLAGS)
	@echo "Protobuf files have been generated in $(OUT_DIR)"

# Создание директории для вывода, если её нет
$(OUT_DIR):
	@mkdir -p $(OUT_DIR)

# Очистка сгенерированных файлов на windows
.PHONY: clean
clean:
	@powershell -Command "Get-ChildItem -Path $(OUT_DIR) -Recurse -Filter '*.pb.go' | Remove-Item -Force"
	@echo "Generated files have been removed from $(OUT_DIR)"

# Очистка сгенерированных файлов на debian
#.PHONY: clean
#clean:
#	@rm -rf $(OUT_DIR)/**/*.pb.go
#	@echo "Generated files have been removed from $(OUT_DIR)"

