# 1. Usar uma imagem base oficial e leve do Python.
# A imagem alpine é uma ótima escolha por ser pequena.
FROM python:3.13.4-alpine3.22

# 2. Definir o diretório de trabalho dentro do contêiner.
# Isso ajuda a organizar os arquivos e os comandos subsequentes serão executados a partir deste diretório.
WORKDIR /app

# 3. Copiar o arquivo de dependências primeiro.
# Isso aproveita o cache de camadas do Docker. Se o requirements.txt não mudar,
# o Docker não reinstalará as dependências a cada build.
COPY requirements.txt .

# 4. Instalar as dependências do projeto.
# A flag --no-cache-dir reduz o tamanho final da imagem.
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copiar o restante do código da aplicação para o diretório de trabalho.
COPY . .

# 6. Expor a porta que a aplicação vai usar.
# O Uvicorn, por padrão, roda na porta 8000.
EXPOSE 8000

# 7. Comando para iniciar a aplicação quando o contêiner for executado.
# Usamos --host 0.0.0.0 para que a aplicação seja acessível de fora do contêiner.
# O --reload é ótimo para desenvolvimento, mas não deve ser usado em produção.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000","--reload"]