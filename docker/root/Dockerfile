# Use the latest ROOT image
FROM rootproject/root:latest

# Install an additional package (e.g., sudo)
RUN apt-get update && apt-get install sudo

# Create a new user named 'myuser' with a home directory and bash shell
RUN useradd -ms /bin/bash nitish

RUN usermod -aG sudo nitish

RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER nitish
WORKDIR /home/nitish

RUN git clone https://github.com/nitish-nayak/dotfiles.git

# Define the command to execute when the container starts
CMD ["bash"]
