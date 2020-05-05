# Official Vault dockerfile, plus enterprise binary

# In this case, I'm setting the version to be the same as my binary
FROM vault:1.1.3

# Bash, to make it look nicer
# And to give us this global bashrc
RUN apk add bash && \
    echo "export VAULT_ADDR=http://0.0.0.0:8200" >> /etc/profile && \
    echo "export PS1='vault01:\w\$ '" >> /etc/profile

# Make sure the vault binary exists in your current working directory
ADD vault /bin/vault
