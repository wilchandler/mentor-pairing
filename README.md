###Mentor Pairing Awesomeness

An app allow the organic transfer of knowledge… (or something equally catchy)

#### UI Development

Pairing Is Caring uses Compass to compile Sass to CSS. To edit the styles and have Compass automatically watch for your changes, run:

	bundle exec compass watch

For more, [check out the Compass documentation](http://compass-style.org/).

#### Development

##### Setting up Auth
Pairing is Caring uses Dev Bootcamp as it's primary auth provider. If you don't
want to hit auth.devbootcamp.com as you smoke test locally you may instead use
the omniauth developer strategy by visiting `localhost:3000/auth/developer` and
filling in the required `provider` and `id` fields.
