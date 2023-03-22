# Start from the official Python 3.10.2 image
FROM python:3.10.2
#FROM node:16.17.1

# Set the working directory to /futurecoder
WORKDIR /futurecoder

# Clone the repo
COPY . /futurecoder/
#RUN git clone https://github.com/futurecoder/course.git

# Install poetry
RUN curl -sSL https://install.python-poetry.org | python3 -
#RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
#ENV PATH="$HOME/.local/bin:$PATH"
ENV PATH="/root/.local/bin:$PATH"
ENV FUTURECODER_LANGUAGE="fr"

#RUN export PATH="$HOME/.local/bin:$PATH"


#RUN poetry config virtualenvs.create false
RUN poetry install
RUN ./scripts/generate.sh
WORKDIR /futurecoder/frontend
# Install Python dependencies
#RUN cd course && poetry install --no-root
#RUN cd frontend

# Install Node.js
# Install NVM and Node.js 16.17.1
# Install NVM and Node.js 16.17.1
# RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash && \
#     export NVM_DIR="$HOME/.nvm" && \
#     [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
#     nvm install 16.17.1 && \
#     nvm use 16.17.1 && \
#     npm install -g npm
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs
#RUN apt-get update && apt-get install -y nodejs

# Install Node.js dependencies
RUN npm ci && npm run build

# Build the frontend and copy service-worker.js
RUN cp course/service-worker.js public/

# Expose port 3000
EXPOSE 3000

# Start the frontend development server
#CMD ["npm", "start"]
# Start the frontend development server
ENTRYPOINT ["npm", "start"]
