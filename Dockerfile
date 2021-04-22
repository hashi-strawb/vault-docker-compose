# Official Vault dockerfile, plus enterprise binary

# In this case, I'm setting the version to be the same as my binary
FROM vault:1.6.3

# Bash, to make it look nicer
# And to give us this global bashrc
RUN apk add bash curl && \
    echo "export VAULT_ADDR=http://0.0.0.0:8200" >> /etc/profile && \
    echo "export PS1='vault01:\w\$ '" >> /etc/profile

# Download an Enterprise binary
RUN curl https://releases.hashicorp.com/vault/1.6.3+ent/vault_1.6.3+ent_linux_386.zip > /tmp/vault.zip && \
    unzip -o /tmp/vault.zip -d /bin && \
    chmod +x /bin/vault

# Netcat, for simulating socket audit device
RUN apk add netcat-openbsd
