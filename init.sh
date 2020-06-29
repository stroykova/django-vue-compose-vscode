mkdir -p secrets


# Django secret key

secret_key_file=secrets/secret_key.env
if [ ! -f "$secret_key_file" ]; then
    echo "$secret_key_file not found, generating"
    echo "SECRET_KEY=$(python -c 'from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())')" > $secret_key_file
else
    echo "$secret_key_file already exists, skip"
fi


# Postgres password

postgres_file=secrets/postgres.env
if [ ! -f "$postgres_file" ]; then
    echo "$postgres_file not found, generating"
    password=$(python -c 'import string; import secrets; alphabet = string.ascii_letters + string.digits; password = "".join(secrets.choice(alphabet) for i in range(20)); print(password)')
    echo "POSTGRES_PASSWORD=$password" > $postgres_file
else
    echo "$postgres_file already exists, skip"
fi
