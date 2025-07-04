# 1. Usar uma imagem oficial do Python como imagem base.
# A versão Alpine é escolhida por seu tamanho reduzido.
# O README menciona Python 3.10+, então usaremos uma versão estável como a 3.11.
FROM python:3.11-alpine

# 2. Definir o diretório de trabalho dentro do contêiner.
WORKDIR /app

# 3. Copiar o arquivo de dependências para o diretório de trabalho.
# Fazer isso antes de copiar o resto do código aproveita o cache de camadas do Docker.
COPY requirements.txt .

# 4. Instalar as dependências.
# --no-cache-dir: Desativa o cache, o que reduz o tamanho da imagem.
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copiar o restante do código da aplicação.
COPY . .

# 6. Expor a porta 8000 para que a aplicação possa ser acessada de fora do contêiner.
EXPOSE 8000

# 7. Definir o comando para executar a aplicação quando o contêiner iniciar.
# O host 0.0.0.0 é necessário para que a aplicação seja acessível externamente.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]   