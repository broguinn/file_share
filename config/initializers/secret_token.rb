# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
FileShare::Application.config.secret_key_base = '0c7d03046ba958917c972a4954ab6e37b4d14bfeea7202a3736246da8e8e83dd20f18865683052d133df1fac921fc13ea6240535740527c2c384b17663820651'
